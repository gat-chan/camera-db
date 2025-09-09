<?php

namespace App\Http\Controllers;

use App\Models\Contact;
use Illuminate\Http\Request;
use Inertia\Inertia;

class ContactController extends Controller
{
    public function submit(Request $request)
    {
        $data = $request->validate([
            'name' => 'nullable|string|max:255',
            'email' => ['nullable', 'regex:/^[a-zA-Z0-9@._-]*$/', 'max:255'],
            'body' => 'required|string',
        ]);

        // DB保存
        Contact::create($data);

        return back(); // Inertia側の onSuccess が呼ばれる
    }
}
