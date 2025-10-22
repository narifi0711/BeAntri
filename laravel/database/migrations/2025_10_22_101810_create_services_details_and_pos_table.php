<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // 3. Tabel services (Layanan Utama: Poli, Teller, dsb.)
        Schema::create('services', function (Blueprint $table) {
            $table->id();
            $table->foreignId('instance_id')->constrained('instances')->onDelete('cascade');
            $table->string('name');
            $table->string('queue_prefix', 10)->unique(); // Contoh: 'P' untuk Poli.
            $table->boolean('is_active')->default(true);
            $table->timestamps();

            $table->unique(['instance_id', 'name']); // Tidak boleh ada nama layanan sama di instansi yang sama.
        });

        // 4. Tabel service_details (Layanan Detail: Kunci Akurasi AI)
        Schema::create('service_details', function (Blueprint $table) {
            $table->id();
            $table->foreignId('service_id')->constrained('services')->onDelete('cascade');
            $table->string('name'); // Contoh: Pemeriksaan Rutin, Program Kehamilan
            $table->unsignedSmallInteger('default_duration_min')->default(15); // Durasi awal layanan (menit)
            $table->timestamps();
        });

        // 5. Tabel pos (Pos Pelayanan Fisik)
        Schema::create('pos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('instance_id')->constrained('instances')->onDelete('cascade');
            $table->foreignId('service_id')->constrained('services')->onDelete('cascade');
            $table->string('pos_number', 50); // Contoh: 'Loket 1', 'Ruang C'
            $table->foreignId('current_staff_id')->nullable()->constrained('users')->onDelete('set null');
            $table->boolean('is_open')->default(true);
            $table->timestamps();

            $table->unique(['instance_id', 'pos_number']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pos');
        Schema::dropIfExists('service_details');
        Schema::dropIfExists('services');
    }
};
