<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class AfMethod extends Model
{
    protected $fillable = ['name_ja', 'name_en'];
    //
    public function cameras()
    {
        return $this->belongsToMany(Camera::class, 'camera_af_methods');
    }
}
