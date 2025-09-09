<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ColorOption extends Model
{
    protected $fillable = ['name_ja', 'name_en'];
    //
    public function cameras()
    {
        return $this->belongsToMany(Camera::class, 'camera_color_option', 'color_option_id', 'camera_id');
    }
}
