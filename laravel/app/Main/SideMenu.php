<?php

namespace App\Main;

use Illuminate\Support\Facades\Auth;

class SideMenu
{
    /**
     * List of side menu items.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public static function menu()
    {
        $menu = [
            'dashboard-overview-1' => [
                'icon' => [
                    'lucide' => 'layout-dashboard',
                    'svg' => ''
                ],
                'route_name' => 'dashboard-overview-1',
                'params' => [
                    'layout' => 'side-menu',
                ],
                'title' => 'Dashboard',
                'permission' => 'view dashboard'
            ],
            'users' => [
                'icon' => [
                    'lucide' => 'users',
                    'svg' => ''
                ],
                'route_name' => 'users',
                'params' => [
                    'layout' => 'side-menu',
                ],
                'title' => 'User Management',
                'permission' => 'manage users'
            ],
            'log-error' => [
                'icon' => [
                    'lucide' => 'bug',
                    'svg' => '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-bug-icon lucide-bug"><path d="M12 20v-9"/><path d="M14 7a4 4 0 0 1 4 4v3a6 6 0 0 1-12 0v-3a4 4 0 0 1 4-4z"/><path d="M14.12 3.88 16 2"/><path d="M21 21a4 4 0 0 0-3.81-4"/><path d="M21 5a4 4 0 0 1-3.55 3.97"/><path d="M22 13h-4"/><path d="M3 21a4 4 0 0 1 3.81-4"/><path d="M3 5a4 4 0 0 0 3.55 3.97"/><path d="M6 13H2"/><path d="m8 2 1.88 1.88"/><path d="M9 7.13V6a3 3 0 1 1 6 0v1.13"/></svg>'
                ],
                'route_name' => 'log-error',
                'params' => [
                    'layout' => 'side-menu',
                ],
                'title' => 'Log Error',
                'permission' => 'view error logs'
            ]
        ];

        // Ambil user yang sedang login
        $user = Auth::user();

        // Jika tidak ada user yang login, kembalikan array kosong
        if (!$user) {
            return [];
        }

        // Filter menu berdasarkan permission
        $filteredMenu = array_filter($menu, function ($item) use ($user) {
            // Jika item adalah 'devider', selalu tampilkan
            if (is_string($item) && $item === 'devider') {
                return true;
            }

            // Jika menu tidak memiliki kunci 'permission', anggap publik dan tampilkan
            if (!isset($item['permission'])) {
                return true;
            }

            // Cek apakah user memiliki permission yang dibutuhkan
            return $user->can($item['permission']);
        });

        return $filteredMenu;
    }
}
