<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DisplayLanguage extends Model
{
    protected $fillable = ['name_ja', 'name_en'];
    //
    public function cameras()
    {
        return $this->belongsToMany(Camera::class, 'camera_display_language', 'display_language_id', 'camera_id');
    }
}
