<?php

// database/seeders/RolesAndPermissionsSeeder.php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

class RolesAndPermissionsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Reset cached roles and permissions
        app()[\Spatie\Permission\PermissionRegistrar::class]->forgetCachedPermissions();

        // 1. BUAT PERMISSIONS
        $permissions = [
            'view dashboard',
            'manage users',
            'manage roles',
            'create articles',
            'edit articles',
            'delete articles',
            'view error logs',
            // Tambahkan permissions lain sesuai kebutuhan unit Anda
        ];

        foreach ($permissions as $permission) {
            Permission::create(['name' => $permission]);
        }

        // 2. BUAT ROLES DAN ASSIGN PERMISSIONS
        $superAdminRole = Role::create(['name' => 'super-admin']);
        $adminRole = Role::create(['name' => 'admin-unit']);
        $unitUserRole = Role::create(['name' => 'user-unit']);

        // Assign semua permissions ke super-admin
        $superAdminRole->givePermissionTo(Permission::all());

        // Assign permissions ke admin
        $adminRole->givePermissionTo(['view dashboard', 'manage users', 'manage roles']);

        // Assign permissions ke user biasa
        $unitUserRole->givePermissionTo(['view dashboard', 'create articles', 'edit articles']);

        // 3. BUAT USER (CONTOH)
        // Pastikan Anda telah menambahkan 'unit' di model User dan migration

        // Hapus user yang sudah ada untuk menghindari duplikasi email (opsional)
        // User::where('email', 'superadmin@app.com')->delete();
        // User::where('email', 'admin@app.com')->delete();

        $superAdmin = User::create([
            'name' => 'Super Admin',
            'email' => 'nasrul.arifin@ecampus.ut.ac.id',
            'unit' => 'Core Team',
            'password' => Hash::make('password'),
            'active' => true,
        ]);

        $admin = User::create([
            'name' => 'Admin Unit',
            'email' => 'admin.unit@ecampus.ut.ac.id',
            'unit' => '49',
            'password' => Hash::make('password'),
            'active' => true,
        ]);

        $user = User::create([
            'name' => 'User Unit',
            'email' => 'user.unit@ecampus.ut.ac.id',
            'unit' => '49',
            'password' => Hash::make('password'),
            'active' => true,
        ]);

        // 4. ASSIGN ROLE KE USER
        $superAdmin->assignRole('super-admin');
        $admin->assignRole('admin-unit');
        $user->assignRole('user-unit');
    }
}
