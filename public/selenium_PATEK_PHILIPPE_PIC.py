from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import requests
from PIL import Image
from io import BytesIO
import os
from urllib.parse import urlparse
from datetime import datetime
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
from concurrent.futures import ThreadPoolExecutor
from concurrent.futures import ThreadPoolExecutor, as_completed

# 使用するブラウザのドライバを設定 (Chromeの場合)
driver = webdriver.Chrome()

# シリーズの一覧ページにアクセス
driver.get("https://www.patek.com/en/collection/watch-finder?Collections.Collections=Twenty%7E4")
time.sleep(10)

# 「calatrava」リンクが含まれるまで最大15秒間待機
WebDriverWait(driver, 15).until(
    EC.presence_of_all_elements_located((By.XPATH, "//a[contains(@href, '/collection/twenty4/')]"))
)

# 少し余裕を持って待機
time.sleep(2)

# 対象リンクをすべて取得
product_links = driver.find_elements(By.XPATH, "//a[contains(@href, '/collection/twenty4/')]")
links = list(set(link.get_attribute('href') for link in product_links))
print(f"{len(links)} 件のリンクを取得:")
for l in links:
    print(l)

# 取得したリンクの数を出力
print(f"取得した製品リンクの数: {len(links)} 件")

# データを格納するリストを準備
watch_data = []

# brandname
manufacturer_name = "Patek-Philippe"
   
   
# 画像並列保存
def download_and_save_image(index, url, reference_number, save_path):
    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        img_data = Image.open(BytesIO(response.content))

        base_filename = f"{manufacturer_name}_{reference_number}"
        file_path = os.path.join(save_path, f"{base_filename}.png")
        

        count = 1
        while os.path.exists(file_path):
            file_path = os.path.join(save_path, f"{base_filename}_{count}.png")
            count += 1

        img_data.save(file_path)
        print(f"[{index}] 画像を保存しました: {file_path}")
    except Exception as e:
        print(f"[{index}] 画像保存エラー（{url}）: {e}")

def scrape_images(driver, reference_number):
    # 保存先パス
    save_path = "C:\\Users\\naoki\\Desktop\\scraping\\img"
    os.makedirs(save_path, exist_ok=True)

    # ギャラリーのスライドラッパーを取得
    gallery_wrapper = driver.find_element(By.CLASS_NAME, "product-technical-section-carousel_slides-wrapper__qj2Fw")
    img_elements = gallery_wrapper.find_elements(By.TAG_NAME, "img")

    image_jobs = []

    for index, img in enumerate(img_elements):
        srcset = img.get_attribute("srcset")
        if not srcset:
            continue

        # srcsetから最大解像度のURLを抽出
        max_width = 0
        best_url = None
        for entry in srcset.split(","):
            parts = entry.strip().split(" ")
            if len(parts) != 2:
                continue
            url, width_part = parts
            try:
                width = int(width_part.replace("w", ""))
                if width > max_width:
                    max_width = width
                    best_url = url
            except:
                continue

        if best_url:
            image_jobs.append((index, best_url))

    # 並列ダウンロード
    def download_image(index, url):
        try:
            response = requests.get(url, timeout=10)
            response.raise_for_status()
            img_data = BytesIO(response.content)
            return (index, img_data)
        except Exception as e:
            print(f"[{index}] ダウンロードエラー（{url}）: {e}")
            return None

    results = []
    with ThreadPoolExecutor(max_workers=5) as executor:
        futures = [executor.submit(download_image, idx, url) for idx, url in image_jobs]
        for future in as_completed(futures):
            result = future.result()
            if result:
                results.append(result)

    # index順に並べて保存
    results.sort(key=lambda x: x[0])
    for index, img_data in results:
        try:
            img = Image.open(img_data)
            if index == 0:
                file_path = os.path.join(save_path, f"{manufacturer_name}_{reference_number}.png")
            else:
                file_path = os.path.join(save_path, f"{manufacturer_name}_{reference_number}_{index}.png")
            img.save(file_path)
            print(f"[{index}] 画像を保存しました: {file_path}")
        except Exception as e:
            print(f"[{index}] 保存エラー: {e}")

# 各リンクにアクセスして情報を取得
for link in links:
    # ページにアクセス
    driver.get(link)
    
    # ページが完全に読み込まれるまで待機
    WebDriverWait(driver, 10).until(
        lambda d: d.execute_script('return document.readyState') == 'complete'
    )

    try:

        reference_number_el = driver.find_element(By.CSS_SELECTOR, "h2.product-technical-section_title__P_9Eu")
        reference_number = reference_number_el.text.strip()
        reference_number_safe = reference_number.replace("/", "_").strip()
        print(reference_number_safe)

        scrape_images(driver, reference_number_safe)


        watch_data.append({
            'manufacturer_name': manufacturer_name,
            'reference_number': reference_number,
        })
    
    except TimeoutException:
        print(f"情報の取得に失敗: {link}")
        continue

    # 取得したリンクの数を出力
    print(f"取得したウォッチデータの件数: {len(watch_data)} / {len(links)}件")


with open('omega_scraped_data.txt', 'w', encoding='utf-8') as file:
    for watch in watch_data:
        file.write(
            f"'reference_number' => '{watch['reference_number']}', "
        )
