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

# 使用するブラウザのドライバを設定 (Chromeの場合)
driver = webdriver.Chrome()

# シリーズの一覧ページにアクセス
driver.get("https://www.omegawatches.jp/watches/de-ville/prestige/catalog?filter_movement_type=Q&price=0-1999999&watch_dial=3174")
time.sleep(10)

# 始まるリンクを全て取得
product_links = driver.find_elements(By.XPATH, "//a[starts-with(@href, " \
"'https://www.omegawatches.jp/watch-omega-de-ville-prestige-quartz-27-5-mm-43423286055001')]")

# リンクのURLをリストに保存（重複を除外）
links = list(set(link.get_attribute('href') for link in product_links))
print(links)

# 取得したリンクの数を出力
print(f"取得した製品リンクの数: {len(links)} 件")

# データを格納するリストを準備
watch_data = []

# brandname
manufacturer_name = "オメガ"
   
# bom削除
def clean_text(text):
    return text.replace('\ufeff', '').strip() if isinstance(text, str) else text


#各要素取得
def clean_and_escape_text(text):
    if text is None:
        return ''

    # 不可視文字の削除（BOM、ゼロ幅スペースなど）
    text = text.replace('\ufeff', '').replace('\u200b', '')

    # 一般的なエスケープ
    text = text.replace('\\', '\\\\')   # バックスラッシュ
    text = text.replace("'", "\\'")     # シングルクォート
    text = text.replace('"', '\\"')     # ダブルクォート
    text = text.replace('\n', '\\n')    # 改行
    text = text.replace('\r', '')       # キャリッジリターン

    return text.strip()

def get_element_text_safe(driver, by, selector, timeout=5):
    try:
        element = WebDriverWait(driver, timeout).until(
            EC.presence_of_element_located((by, selector))
        )
        raw_text = element.get_attribute("innerText") or element.text
        return clean_and_escape_text(raw_text)
    except Exception:
        return ''
    
# 画像並列保存
def download_and_save_image(index, url, reference_number, save_path):
    try:
        response = requests.get(url, timeout=10)
        response.raise_for_status()
        img_data = Image.open(BytesIO(response.content))

        base_filename = f"OMEGA_{reference_number}"
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
    from concurrent.futures import ThreadPoolExecutor, as_completed

    # 保存先パス
    save_path = "C:\\Users\\naoki\\Desktop\\scraping\\img\\omega"
    os.makedirs(save_path, exist_ok=True)

    # ギャラリー取得
    gallery_ul = driver.find_element(By.CLASS_NAME, "pp-gallery__ul")
    img_elements = gallery_ul.find_elements(By.TAG_NAME, "img")

    image_jobs = []

    for index, img in enumerate(img_elements):
        srcset = img.get_attribute("srcset")
        if not srcset:
            continue

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

    # 並列で画像をダウンロード（index順ではない）
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

    # index順に並び替え
    results.sort(key=lambda x: x[0])

    # 逐次的にファイル保存（順番を守る）
    for index, img_data in results:
        try:
            img = Image.open(img_data)
            base_filename = f"OMEGA_{reference_number}"
            file_path = os.path.join(save_path, f"{base_filename}.png")
            count = 1
            while os.path.exists(file_path):
                file_path = os.path.join(save_path, f"{base_filename}_{count}.png")
                count += 1
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

        # 技術資料　クリック
        try:
            # 「技術」という文字を持つボタンをクリック可能になるまで待機
            feature_button = WebDriverWait(driver, 10).until(
                EC.element_to_be_clickable((By.XPATH, '//button[contains(@class, "ow-collapsible__title") and contains(text(), "技術")]'))
            )
            feature_button.click()
        except Exception as e:
            print(f"「技術資料」ボタンクリックに失敗しました: {e}")

        time.sleep(0.5)

        reference_number = get_element_text_safe(driver, By.CSS_SELECTOR, 'dd.technical-data-value[data-code="sku"]')
        print(reference_number)

        scrape_images(driver, reference_number)


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

