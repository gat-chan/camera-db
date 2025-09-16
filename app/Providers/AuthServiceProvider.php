<?php
// app/Providers/AuthServiceProvider.php

namespace App\Providers;

use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use App\Models\Camera;
use App\Policies\CameraPolicy;

class AuthServiceProvider extends ServiceProvider
{
    protected $policies = [
        Camera::class => CameraPolicy::class,
    ];

    public function boot(): void
    {
        $this->registerPolicies();
    }
}
