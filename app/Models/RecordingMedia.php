<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RecordingMedia extends Model
{
    protected $fillable = ['name_ja', 'name_en'];
    //
    protected $table = 'recording_medias';
    
    public function cameras()
    {
        return $this->belongsToMany(Camera::class, 'camera_recording_medias', 'recording_media_id', 'camera_id');
        
    }
}
