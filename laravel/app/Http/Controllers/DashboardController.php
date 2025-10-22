<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;

class DashboardController extends Controller
{
    public function dashboardOverview1()
    {
        return view('pages/dashboard-overview-1', [
            // Specify the base layout.
            // Eg: 'side-menu', 'simple-menu', 'top-menu', 'login'
            // The default value is 'side-menu'

            // 'layout' => 'side-menu'
            'title' => 'Dashboard',
        ]);
    }
}
