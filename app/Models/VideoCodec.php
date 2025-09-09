<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class VideoCodec extends Model
{
    //
    public function cameras()
    {
        return $this->belongsToMany(Camera::class, 'camera_video_codecs');
    }
}
