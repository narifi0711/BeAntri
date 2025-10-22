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
        // 8. Tabel user_locations (Lokasi Real-Time User dari Flutter)
        Schema::create('user_locations', function (Blueprint $table) {
            $table->id();
            $table->foreignId('queue_id')->constrained('queues')->onDelete('cascade');
            $table->decimal('current_lat', 10, 8);
            $table->decimal('current_lng', 11, 8);
            $table->timestamps(); // Timestamp di sini menunjukkan kapan data lokasi ini diterima
        });

        // 9. Tabel eta_logs (Log Panggilan Google Maps API)
        Schema::create('eta_logs', function (Blueprint $table) {
            $table->id();
            $table->foreignId('queue_id')->constrained('queues')->onDelete('cascade');
            $table->unsignedInteger('distance_m')->nullable(); // Jarak dalam meter
            $table->unsignedInteger('duration_sec')->nullable(); // Waktu tempuh (tanpa traffic)
            $table->unsignedInteger('traffic_sec')->nullable(); // Waktu tempuh (dengan traffic)
            $table->boolean('is_traffic_enabled')->default(false);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('eta_logs');
        Schema::dropIfExists('user_locations');
    }
};
