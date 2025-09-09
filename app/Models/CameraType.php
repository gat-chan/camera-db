<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CameraType extends Model
{
    protected $fillable = ['name_ja', 'name_en'];
    public $timestamps = false;

    public function cameras()
    {
        return $this->hasMany(Camera::class);
    }
}
