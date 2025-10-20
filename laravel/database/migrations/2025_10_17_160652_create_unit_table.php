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
        Schema::create('unit', function (Blueprint $table) {
            // Kolom dari CREATE TABLE `unit`
            $table->string('kode', 3)->primary(); // PRIMARY KEY dari VARCHAR(3)
            $table->string('nama', 50)->nullable();
            $table->string('alamat', 250)->nullable();
            $table->string('nomor_telepon', 50)->nullable();
            $table->string('nomor_fax', 50)->nullable();
            $table->string('email', 50)->nullable();
            $table->string('website', 50)->nullable();
            $table->string('wa', 50)->nullable();
            $table->string('facebook', 50)->nullable();
            $table->string('instagram', 50)->nullable();

            // Kolom Pimpinan 1
            $table->string('pimpinan_1_jabatan', 50)->nullable();
            $table->string('pimpinan_1_nama', 50)->nullable();
            $table->string('pimpinan_1_nip', 50)->nullable();

            // Kolom Pimpinan 2
            $table->string('pimpinan_2_jabatan', 50)->nullable();
            $table->string('pimpinan_2_nama', 50)->nullable();
            $table->string('pimpinan_2_nip', 50)->nullable();

            // Kolom Pimpinan 3
            $table->string('pimpinan_3_jabatan', 50)->nullable();
            $table->string('pimpinan_3_nama', 50)->nullable();
            $table->string('pimpinan_3_nip', 50)->nullable();

            // Kolom Pimpinan 4
            $table->string('pimpinan_4_jabatan', 50)->nullable();
            $table->string('pimpinan_4_nama', 50)->nullable();
            $table->string('pimpinan_4_nip', 50)->nullable();

            // Kolom User dan App
            $table->string('user_create', 50)->nullable();
            $table->timestamp('user_date_create')->nullable(); // Menggunakan timestamp karena kolom SQL adalah DATETIME
            $table->string('user_change', 50)->nullable();
            $table->tinyInteger('app')->default(0); // Kolom TINYINT(1)

            // Laravel secara default tidak menggunakan kolom created_at dan updated_at
            // jika tidak ada $table->timestamps(). Kita tidak menambahkannya karena tidak ada di SQL.
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('unit');
    }
};
