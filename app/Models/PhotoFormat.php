<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PhotoFormat extends Model
{
    protected $fillable = ['name_ja', 'name_en'];
    //
    public function cameras()
    {
        return $this->belongsToMany(Camera::class, 'camera_photo_formats');
    }
}
