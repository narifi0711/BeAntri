<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class InstanceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Define the table name (based on the CREATE TABLE statement in the SQL file)
        $tableName = 'instances';

        // Check if the table has data, and truncate it if needed
        // Uncomment the line below if you want to clear the table before seeding
        // DB::table($tableName)->truncate();

        // Data derived from the INSERT INTO `z` statement.
        // Note: The table name in the INSERT statement is 'z', but the CREATE TABLE is 'unit',
        // so we'll assume the table name is 'unit' as defined in CREATE TABLE.
        $instances = [
            [
                'name' => 'BeAntri',
                'address' => '0841020 Surabaya',
                'telp' => null,
                'email' => 'admin@beantri.com',
                'website' => 'https://beantri.com',
                'wa' => '08115159111',
                'facebook' => null,
                'instagram' => null,
                'user_create' => 'superadmin@beantri.com',
                'user_change' => null
            ],
            [
                'name' => 'EndUser',
                'address' => null,
                'telp' => null,
                'email' => null,
                'website' => null,
                'wa' => null,
                'facebook' => null,
                'instagram' => null,
                'user_create' => 'superadmin@beantri.com',
                'user_change' => null
            ],
            [
                'name' => 'Allora Klinik',
                'address' => 'Banjarbaru, Kalimantan Selatan',
                'telp' => null,
                'email' => 'admin@allora.com',
                'website' => 'https://allora.com',
                'wa' => '081939792333',
                'facebook' => null,
                'instagram' => 'https://www.instagram.com/allora.clinic.aesthetic/',
                'user_create' => 'superadmin@beantri.com',
                'user_change' => null
            ]
        ];

        // Insert the data into the database
        DB::table($tableName)->insert($instances);
    }
}
