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
                'name' => 'Allora Klinik',
                'address' => 'Banjarbaru, Kalimantan Selatan',
                'telp' => '0951 - 321107, 321056, 321054',
                'email' => 'allora@allora.com',
                'website' => 'kumar',
                'wa' => '4649849494',
                'facebook' => 'https://facebook.com',
                'instagram' => 'mar kumar taye',
                'user_create' => 'superadmin@beantri.com',
                'user_date_create' => now(),
                'user_change' => null
            ]
        ];

        // Insert the data into the database
        DB::table($tableName)->insert($instances);
    }
}
