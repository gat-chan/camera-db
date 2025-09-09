<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class VideoFormat extends Model
{
    protected $fillable = ['name_ja', 'name_en'];
    //
    public function cameras()
    {
        return $this->belongsToMany(Camera::class, 'camera_video_format', 'video_format_id', 'camera_id');
    }
}
