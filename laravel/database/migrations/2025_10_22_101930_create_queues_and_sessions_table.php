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
        // 6. Tabel queues
        Schema::create('queues', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade'); // Pelanggan
            $table->foreignId('service_id')->constrained('services')->onDelete('cascade');
            $table->string('queue_number', 20); // Contoh: P-007
            $table->enum('status', ['PENDING', 'CALLED', 'SERVING', 'COMPLETED', 'NO_SHOW', 'SKIPPED'])->default('PENDING');
            $table->boolean('is_priority_ready')->default(false); // Flag untuk logika pemanggilan dinamis
            $table->timestamps();

            $table->unique(['service_id', 'queue_number']);
        });

        // 7. Tabel queue_sessions (Dataset Kunci untuk AI)
        Schema::create('queue_sessions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('queue_id')->unique()->constrained('queues')->onDelete('cascade');
            $table->foreignId('pos_id')->nullable()->constrained('pos')->onDelete('set null');
            $table->foreignId('service_detail_id')->constrained('service_details')->onDelete('cascade');

            // Waktu Bersiap dari Input User
            $table->unsignedSmallInteger('preparation_time_sec')->default(0);

            // TIMESTAMP UNTUK AI
            $table->dateTime('time_check_in'); // Kapan user ambil nomor
            $table->dateTime('time_expected_arrival')->nullable(); // EAT (ETA + Waktu Bersiap)
            $table->dateTime('time_called')->nullable(); // Kapan dipanggil
            $table->dateTime('time_serving_start')->nullable(); // Kapan layanan dimulai
            $table->dateTime('time_serving_end')->nullable(); // Kapan layanan selesai

            // Durasi Layanan (Hasil perhitungan untuk Target Variable AI)
            $table->unsignedInteger('serving_duration_sec')->nullable();

            $table->foreignId('staff_id')->nullable()->constrained('users')->onDelete('set null'); // Staff yang melayani
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('queue_sessions');
        Schema::dropIfExists('queues');
    }
};
