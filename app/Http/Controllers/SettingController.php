<?php
// App\Http\Controllers\SettingController.php
class SettingController extends Controller
{

  public function create()
  {
      $this->authorize('create', Setting::class);

      return inertia('Settings/Create');
  }

  public function store(Request $request)
  {
      $this->authorize('create', Setting::class);

      Setting::create($request->all());

      return redirect()->route('settings.index');
  }

  public function edit(Setting $setting)
  {
      $this->authorize('update', $setting);

      return inertia('Settings/Edit', ['setting' => $setting]);
  }

  public function update(Request $request, Setting $setting)
  {
      $this->authorize('update', $setting);

      $setting->update($request->all());

      return redirect()->route('settings.index');
  }

  public function destroy(Setting $setting)
  {
      $this->authorize('delete', $setting);

      $setting->delete();

      return redirect()->route('settings.index');
  }
}