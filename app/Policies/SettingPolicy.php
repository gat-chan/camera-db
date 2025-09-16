<?php
// App\Policies\SettingPolicy.php

namespace App\Policies;

use App\Models\User;
use App\Models\Setting;

class SettingPolicy
{
    /**
     * データが存在しない時のみ作成可能
     */
    public function create(User $user): bool
    {
        return !Setting::exists();
    }

    /**
     * 管理者のみ更新可能
     */
    public function update(User $user, Setting $setting): bool
    {
        return $user->is_admin;
    }

    /**
     * 管理者のみ削除可能
     */
    public function delete(User $user, Setting $setting): bool
    {
        return $user->is_admin;
    }
}
