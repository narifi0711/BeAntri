<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\DarkModeController;
use App\Http\Controllers\ColorSchemeController;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\LogErrorController;
use App\Http\Controllers\UserController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('dark-mode-switcher', [DarkModeController::class, 'switch'])->name('dark-mode-switcher');
Route::get('color-scheme-switcher/{color_scheme}', [ColorSchemeController::class, 'switch'])->name('color-scheme-switcher');

Route::controller(AuthController::class)->middleware('loggedin')->group(function () {
    Route::get('login', 'loginView')->name('login.index');
    Route::post('login', 'login')->name('login.check');
});

Route::middleware('auth')->group(function () {
    Route::get('logout', [AuthController::class, 'logout'])->name('logout');
    Route::controller(DashboardController::class)->group(function () {
        Route::get('/', 'dashboardOverview1')->name('dashboard-overview-1')->middleware(['role:super-admin|admin-unit|user-unit']);
    });

    Route::controller(UserController::class)->group(function () {
        Route::get('users', 'index')->name('users')->middleware(['role:super-admin|admin-unit']);
        Route::get('user/data', 'data')->name('users.data')->middleware(['role:super-admin|admin-unit']);
        Route::get('users/roles', 'getRoles')->name('users.roles')->middleware(['role:super-admin|admin-unit']);
        Route::post('users', 'store')->name('users.store')->middleware(['role:super-admin|admin-unit']);
        Route::get('users/{user}', 'show')->name('users.show')->middleware(['role:super-admin|admin-unit']);
        Route::put('users/{user}', 'update')->name('users.update')->middleware(['role:super-admin|admin-unit']);
        Route::delete('users/{user}', 'destroy')->name('users.destroy')->middleware(['role:super-admin|admin-unit']);
    });

    Route::controller(LogErrorController::class)->group(function () {
        Route::get('log-error-page', 'index')->name('log-error')->middleware(['role:super-admin']);
        Route::get('log-error/data', 'data')->name('log-error.data')->middleware(['role:super-admin']);
        Route::delete('log-error/clear', 'clear')->name('log-error.clear')->middleware(['role:super-admin']);
    });
});
