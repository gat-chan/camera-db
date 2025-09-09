<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CameraPrice extends Model
{
    protected $fillable = ['camera_id', 'price', 'recorded_at'];
    public $timestamps = false;

    public function camera()
    {
        return $this->belongsTo(Camera::class);
    }
}
