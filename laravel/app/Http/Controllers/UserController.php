<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Spatie\Permission\Models\Role;

class UserController extends Controller
{
    /**
     * Menampilkan halaman utama manajemen user.
     */
    public function index(Request $request)
    {
        return view('pages.users', [
            'title' => 'User Management',
            'layout' => $request->query('layout', 'side-menu'),
        ]);
    }

    /**
     * Menyediakan data user untuk Tabulator.
     */
    public function data(Request $request)
    {
        // Mengambil semua user dengan relasi roles-nya (Eager Loading)
        // Ini adalah pendekatan yang tepat untuk pagination 'local' di Tabulator.
        $users = User::with('roles')->get();

        // Memformat data agar sesuai dengan kolom yang diharapkan oleh Tabulator di frontend.
        $data = $users->map(function ($user) {
            return [
                'id'         => $user->id,
                'name'       => $user->name,
                'email'      => $user->email,
                'unit'       => $user->unit,
                // Mengambil nama role dan menggabungkannya dengan koma jika user memiliki lebih dari satu role.
                'role'       => $user->roles->pluck('name')->join(', ')
            ];
        });

        // Karena pagination adalah 'local', kita cukup mengembalikan array of objects.
        // Tabulator akan menangani sisanya.
        return response()->json($data);
    }

    /**
     * Menyimpan user baru.
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'unit' => 'required|string|max:255',
            'password' => 'required|string|min:8|confirmed',
            'role' => 'required|exists:roles,name',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        DB::beginTransaction();
        try {
            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'unit' => $request->unit,
                'password' => Hash::make($request->password),
            ]);

            $user->assignRole($request->role);

            DB::commit();
            return response()->json(['message' => 'User created successfully!']);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Failed to create user.', 'error' => $e->getMessage()], 500);
        }
    }

    /**
     * Mengambil data user spesifik untuk form edit.
     */
    public function show(User $user)
    {
        $user->load('roles'); // Pastikan role ter-load
        return response()->json($user);
    }

    /**
     * Mengupdate data user.
     */
    public function update(Request $request, User $user)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users,email,' . $user->id,
            'unit' => 'required|string|max:255',
            'password' => 'nullable|string|min:8|confirmed',
            'role' => 'required|exists:roles,name',
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => $validator->errors()], 422);
        }

        DB::beginTransaction();
        try {
            $userData = $request->only('name', 'email', 'unit');
            if ($request->filled('password')) {
                $userData['password'] = Hash::make($request->password);
            }
            $user->update($userData);

            // Sync role, ini akan menghapus role lama dan menerapkan yang baru
            $user->syncRoles([$request->role]);

            DB::commit();
            return response()->json(['message' => 'User updated successfully!']);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => 'Failed to update user.', 'error' => $e->getMessage()], 500);
        }
    }

    /**
     * Menghapus user.
     */
    public function destroy(User $user)
    {
        // Tambahkan proteksi agar tidak bisa menghapus diri sendiri atau super-admin lain
        if ($user->id === auth()->id()) {
            return response()->json(['message' => 'You cannot delete yourself.'], 403);
        }
        if ($user->hasRole('super-admin')) {
            return response()->json(['message' => 'Cannot delete a Super Admin.'], 403);
        }

        $user->delete();
        return response()->json(['message' => 'User deleted successfully!']);
    }

    /**
     * Mengambil semua role.
     */
    public function getRoles()
    {
        $roles = Role::all()->pluck('name');
        return response()->json($roles);
    }
}
