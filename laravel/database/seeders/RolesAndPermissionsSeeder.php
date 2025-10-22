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
        ];

        foreach ($permissions as $permission) {
            Permission::create(['name' => $permission]);
        }

        // 2. BUAT ROLES DAN ASSIGN PERMISSIONS
        $superAdminRole = Role::create(['name' => 'super-admin']);
        $adminRole = Role::create(['name' => 'admin-instance']);
        $instanceUserRole = Role::create(['name' => 'user-instance']);

        // Assign semua permissions ke super-admin
        $superAdminRole->givePermissionTo(Permission::all());

        // Assign permissions ke admin
        $adminRole->givePermissionTo(['view dashboard', 'manage users', 'manage roles']);

        // Assign permissions ke user biasa
        $instanceUserRole->givePermissionTo(['view dashboard', 'create articles', 'edit articles']);

        // 3. BUAT USER (CONTOH)
        // Pastikan Anda telah menambahkan 'instance' di model User dan migration

        // Hapus user yang sudah ada untuk menghindari duplikasi email (opsional)
        // User::where('email', 'superadmin@app.com')->delete();
        // User::where('email', 'admin@app.com')->delete();

        $superAdmin = User::create([
            'name' => 'Super Admin',
            'email' => 'superadmin@beantri.com',
            'instance_id' => null,
            'password' => Hash::make('password'),
            'active' => true,
        ]);

        $admin = User::create([
            'name' => 'Admin Instance',
            'email' => 'admin@allora.com',
            'instance_id' => 1,
            'password' => Hash::make('password'),
            'active' => true,
        ]);

        $user = User::create([
            'name' => 'User Instance',
            'email' => 'user@allora.com',
            'instance_id' => 1,
            'password' => Hash::make('password'),
            'active' => true,
        ]);

        // 4. ASSIGN ROLE KE USER
        $superAdmin->assignRole('super-admin');
        $admin->assignRole('admin-instance');
        $user->assignRole('user-instance');
    }
}
