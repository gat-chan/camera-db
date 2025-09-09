<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Description extends Model
{
    use HasFactory;

    protected $fillable = [
        'description_en',
        'description_ja',
    ];

    // Watch モデルとのリレーション（1対多）
    public function watches()
    {
        return $this->hasMany(Watch::class);
    }
}
