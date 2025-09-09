<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Manufacturer extends Model
{
    use HasFactory;

    protected $fillable = ['name', 'founded_year', 'country_id'];

    /**
     * このメーカーが属する国
     */
    public function country()
    {
        return $this->belongsTo(Country::class);
    }

    public function getNameAttribute()
    {
        return $this->name_ja; // または言語に応じて切り替えも可能
    }
}
