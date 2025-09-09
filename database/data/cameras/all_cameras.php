<?php

$cameraFiles = glob(__DIR__ . '/*.php');

$allCameras = [];

foreach ($cameraFiles as $file) {
    if (basename($file) !== 'all_cameras.php') {
        $cameras = include $file;

        if (!is_array($cameras)) {
            throw new \Exception("無効なファイル: $file は配列を返していません。");
        }

        $allCameras = array_merge($allCameras, $cameras);
    }
}

return $allCameras;
