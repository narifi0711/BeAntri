<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class LogErrorController extends Controller
{
    public function index()
    {
        return view('pages/log-error', [
            'title' => 'Log Error',
        ]);
    }

    public function data(Request $request)
    {
        $logPath = storage_path('logs/laravel.log');
        $logs = [];

        if (File::exists($logPath)) {
            $logContent = File::get($logPath);
            // Regex untuk mem-parsing setiap entri log, termasuk stack trace multi-baris
            $pattern = '/^\[(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\](?:.*?(\w+)\.([A-Z]+):)?(.*?)(?=^\[\d{4}-\d{2}-\d{2}|\Z)/sm';

            preg_match_all($pattern, $logContent, $matches, PREG_SET_ORDER);

            foreach ($matches as $key => $match) {
                $stackTrace = trim($match[4]);
                $messageParts = explode("\n", $stackTrace, 2);
                $message = $messageParts[0];
                $fullTrace = isset($messageParts[1]) ? trim($messageParts[1]) : '';

                $logs[] = [
                    'id' => $key + 1,
                    'datetime' => $match[1],
                    'env' => $match[2] ?? 'local',
                    'level' => $match[3] ?? 'INFO',
                    'message' => $message,
                    'stack_trace' => $fullTrace,
                ];
            }
        }

        // Balikkan urutan array SEKARANG agar log terbaru selalu di atas, SEBELUM filtering dan pagination.
        $logs = array_reverse($logs);

        // Ambil parameter filter dari request Tabulator
        $filters = $request->input('filter', []);
        if (!empty($filters)) {
            $logs = array_filter($logs, function ($log) use ($filters) {
                foreach ($filters as $filter) {
                    // Pastikan field, type, dan value ada
                    if (!isset($filter['field']) || !isset($filter['type']) || !isset($filter['value'])) {
                        continue;
                    }

                    $field = $filter['field'];
                    $type = $filter['type'];
                    $value = $filter['value'];

                    // Pastikan field yang akan difilter ada di data log
                    if (!isset($log[$field])) {
                        return false;
                    }

                    $logValue = $log[$field];

                    // Terapkan logika filter berdasarkan tipenya
                    switch ($type) {
                        case 'like':
                            // Pencarian case-insensitive
                            if (stripos($logValue, $value) === false) return false;
                            break;
                        case '=':
                            if (strcasecmp($logValue, $value) != 0) return false;
                            break;
                        case '!=':
                            if (strcasecmp($logValue, $value) == 0) return false;
                            break;
                        // Anda bisa menambahkan case lain seperti '>', '<', dll. jika diperlukan
                        default:
                            // Jika tipe tidak didukung, jangan filter
                            break;
                    }
                }
                return true; // Jika lolos semua filter, tampilkan log
            });
        }

        // Tabulator mengharapkan format { data: [...], last_page: ... } untuk paginasi remote
        // Kita akan melakukan paginasi manual di sini
        $page = $request->input('page', 1);
        $size = $request->input('size', 10);

        $totalRecords = count($logs); // Hitung total setelah filter
        $totalPages = ceil($totalRecords / $size);
        $paginatedData = array_slice($logs, ($page - 1) * $size, $size); // Lakukan slice pada data yang sudah benar urutannya

        return response()->json([
            'last_page' => $totalPages,
            'data' => $paginatedData,
        ]);
    }

    public function clear()
    {
        $logPath = storage_path('logs/laravel.log');

        if (File::exists($logPath)) {
            File::put($logPath, '');
            return response()->json(['message' => 'Log file cleared successfully!']);
        }

        return response()->json(['message' => 'Log file not found.'], 404);

        // throw new Exception('Ini adalah error percobaan dengan ID unik.');
    }
}
