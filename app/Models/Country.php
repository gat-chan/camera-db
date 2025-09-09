<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Country extends Model
{
    use HasFactory;

    protected $fillable = ['country_en', 'country_ja'];

    public function manufacturers()
    {
        return $this->hasMany(Manufacturer::class);
    }
}
