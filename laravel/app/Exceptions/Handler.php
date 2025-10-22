<?php

namespace App\Exceptions;

use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Throwable;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Log;
use Symfony\Component\HttpFoundation\Response;

class Handler extends ExceptionHandler
{
    /**
     * A list of exception types with their corresponding custom log levels.
     *
     * @var array<class-string<\Throwable>, \Psr\Log\LogLevel::*>
     */
    protected $levels = [
        //
    ];

    /**
     * A list of the exception types that are not reported.
     *
     * @var array<int, class-string<\Throwable>>
     */
    protected $dontReport = [
        //
    ];

    /**
     * A list of the inputs that are never flashed to the session on validation exceptions.
     *
     * @var array<int, string>
     */
    protected $dontFlash = [
        'current_password',
        'password',
        'password_confirmation',
    ];

    /**
     * Register the exception handling callbacks for the application.
     *
     * @return void
     */
    public function register()
    {
        $this->reportable(function (Throwable $e) {
            //
        });
    }

    /**
     * Report or log an exception.
     */
    public function report(Throwable $exception)
    {
        // Method ini sudah dipanggil secara otomatis oleh Laravel.
        // Kita bisa menambahkan UUID di sini jika diperlukan untuk semua laporan error.
        if ($this->shouldReport($exception)) {
            $logId = (string) Str::uuid();
            $exception->logId = $logId; // Menambahkan ID ke objek exception untuk bisa diakses di render()

            // Biarkan Laravel yang menangani logging utama, tapi kita bisa menambahkan konteks UUID.
            Log::shareContext(['uuid' => $logId]);
        }

        parent::report($exception);
    }

    /**
     * Render an exception into an HTTP response.
     */
    public function render($request, Throwable $exception)
    {
        // Ambil UUID yang sudah dibuat di method report()
        $logId = $exception->logId ?? (string) Str::uuid();
        $statusCode = $this->isHttpException($exception) ? $exception->getStatusCode() : 500;

        if ($request->expectsJson() || $request->is('api/*')) {
            $response = [
                'message' => $this->isHttpException($exception) ? $exception->getMessage() : 'Terjadi kesalahan pada server.',
                'error_id' => $logId,
            ];

            // Jika APP_DEBUG aktif, sertakan detail teknis (Hanya untuk Development!)
            if (config('app.debug')) {
                $response['trace'] = $exception->getTrace();
                $response['code'] = $exception->getCode();
            }

            return response()->json($response, $statusCode);
        }

        // Jika APP_DEBUG=false dan terjadi error 500, tampilkan halaman error kustom.
        if (!config('app.debug') && $statusCode >= 500) {
            // Pastikan file 'resources/views/errors/custom-500.blade.php' ada.
            return response()->view(
                'errors.custom-500',
                ['errorId' => $logId],
                $statusCode
            );
        }

        return parent::render($request, $exception);
    }
}
