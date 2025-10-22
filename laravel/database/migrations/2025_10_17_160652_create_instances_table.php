<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('instances', function (Blueprint $table) {
            // Kolom dari CREATE TABLE `unit`
            $table->id(); // PRIMARY KEY dari VARCHAR(3)
            $table->string('name', 50);
            $table->string('address', 250)->nullable();
            $table->string('telp', 50)->nullable();
            $table->string('email', 50)->nullable();
            $table->string('website', 50)->nullable();
            $table->string('wa', 50)->nullable();
            $table->string('facebook', 50)->nullable();
            $table->string('instagram', 50)->nullable();

            // Koordinat Lokasi Instansi (Kunci untuk Google Maps)
            $table->decimal('location_lat', 10, 8)->nullable();
            $table->decimal('location_lng', 11, 8)->nullable();
            $table->string('time_zone')->default('Asia/Makassar'); // Zona Waktu Default

            // Kolom User dan App
            $table->string('user_create', 50)->nullable();
            $table->timestamp('user_date_create')->nullable(); // Menggunakan timestamp karena kolom SQL adalah DATETIME
            $table->string('user_change', 50)->nullable();
        });

        // 2. Memperbarui Tabel Users (Modifikasi kolom yang sudah ada)
        Schema::table('users', function (Blueprint $table) {
            // Kolom 'instance_id' sudah ada (integer), kita ubah ke BIGINT UNSIGNED
            // agar kompatibel dengan 'instances.id'
            $table->unsignedBigInteger('instance_id')->nullable()->change();

            // Tambahkan Foreign Key Constraint
            $table->foreign('instance_id')
                ->references('id') // Merujuk ke instances.id
                ->on('instances')
                ->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropForeign(['instance_id']); // Hapus relasi FK
        });

        Schema::dropIfExists('instances');
    }
};
