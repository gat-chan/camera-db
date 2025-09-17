<template>
	<p><span class="font-semibold">センサータイプ:</span> {{ camera.sensor_type?.name_ja || '不明' }}</p>
	              <p><span class="font-semibold">有効画素数:</span> {{ camera.effective_pixels || '不明' }} 万画素</p>
</template>
