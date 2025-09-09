from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import requests
from PIL import Image
from io import BytesIO
import re
import os
from datetime import datetime
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
from selenium.common.exceptions import NoSuchElementException


# 使用するブラウザのドライバを設定 (Chromeの場合)
driver = webdriver.Chrome()

# シリーズの一覧ページにアクセス
driver.get("https://www.rolex.com/ja/watches/find-rolex?family=1908")

# 指定のリンクがすべて表示されるまで待機
WebDriverWait(driver, 10).until(
    EC.presence_of_all_elements_located((By.XPATH, "//a[starts-with(@href, '/ja/watches/1908/')]"))
)

# 始まるリンクを全て取得
product_links = driver.find_elements(By.XPATH, "//a[starts-with(@href, '/ja/watches/1908/')]")

# リンクのURLをリストに保存
links = [link.get_attribute('href') for link in product_links]
print(links)

# データを格納するリストを準備
watch_data = []

# brandname
manufacturer_name = "ロレックス"

# 日付の有り無しを確認する関数
def is_element_present(driver, xpath, timeout=3):
    try:
        # 指定された時間内に要素が存在するか確認
        WebDriverWait(driver, timeout).until(
            EC.visibility_of_element_located((By.XPATH, xpath))
        )
        return '1'  # 要素が存在した場合
    except TimeoutException:
        return '0'  # 要素が存在しない場合

# 日付の有り無しを確認する関数
def is_date_present(driver):
    xpath = "//p[contains(text(), '日付') ]"
    try:
        driver.find_element("xpath", xpath)
        return 1
    except NoSuchElementException:
        return 0
    
# スモセコの有り無しを確認する関数
def is_small_second_present(driver):
    xpath = "//p[contains(text(), 'スモールセコンド') ]"
    try:
        driver.find_element("xpath", xpath)
        return 1
    except NoSuchElementException:
        return 0
    
# クロノグラフの有り無しを確認する関数
def is_chronograph_present(driver):
    xpath = "//p[contains(text(), 'クロノグラフ') ]"
    try:
        driver.find_element("xpath", xpath)
        return 1
    except NoSuchElementException:
        return 0
    
# GMTの有り無しを確認する関数
def is_gmt_or_dual_time_present(driver):
    xpath = "//p[contains(text(), 'GMT') or contains(text(), '第2タイムゾーン時刻表示')]"
    try:
        driver.find_element("xpath", xpath)
        return 1
    except NoSuchElementException:
        return 0

# 各リンクにアクセスして情報を取得
for link in links:
    # ページにアクセス
    driver.get(link)
    
    try:
        # 要素が表示されるまで最大10秒待機 (要素が表示されたら取得)
        watch_name_ja = WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.ID, 'mj-watchName'))
        ).text
        print(watch_name_ja)

        reference_number = WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.CLASS_NAME, 'e1yf0wve7'))
        ).text
        print(reference_number)

        water_resistance = WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.XPATH, "//h5[text()='防水性']/following-sibling::p[1]"))
        ).text
        print(water_resistance)

        movement_type_name = WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.XPATH, "//h5[text()='ムーブメント']/following-sibling::p[1]"))
        ).text
        print(movement_type_name)

        caliber = WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.XPATH, "//h5[text()='キャリバー']/following-sibling::p[1]"))
        ).text
        print(caliber)

        power_reserve = WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.XPATH, "//h5[text()='パワーリザーブ']/following-sibling::p[1]"))
        ).text
        print(power_reserve)

        case_diameter = WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.XPATH, "//h5[text()='直径']/following-sibling::p[1]"))
        ).text
        print(case_diameter)

        case_material_name_ja = WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.XPATH, "(//h5[text()='素材']/following-sibling::p[1])[1]"))
        ).text
        print(case_material_name_ja)

        strap_material_name_ja = WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.XPATH, "(//h5[text()='素材']/following-sibling::p[1])[2]"))
        ).text
        print(strap_material_name_ja)
        
        dial_color_ja = WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.XPATH, "//h5[text()='ダイアル']/following-sibling::p[1]"))
        ).text
        print(dial_color_ja)

        crystal_type = "サファイアクリスタル"

        clasp_type_ja = WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.XPATH, "//h5[text()='クラスプ']/following-sibling::p[1]"))
        ).text
        print(clasp_type_ja)

        price = WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.XPATH, '/html/body/div[1]/div/main/header/div/div[2]/p/span'))
        ).text
        print(price)

        # 日付の有無を確認
        date_display = is_date_present(driver)
        print(date_display)

        # スモセコの有無を確認
        small_second = is_small_second_present(driver)
        print(small_second)

        # クロノグラフの有無を確認
        chronograph = is_chronograph_present(driver)
        print(chronograph)

        # GMTの有無を確認
        GMT_function = is_gmt_or_dual_time_present(driver)
        print(GMT_function)


        # 特定の文字列抽出関数
        def extract_specific_strings(input_string, target_strings):
            extracted_strings = []
            for target_string in target_strings:
                if target_string in input_string:
                    extracted_strings.append(target_string)
            
            # 抽出結果を結合して単一の文字列として返す
            return ', '.join(extracted_strings) if extracted_strings else ''  # マッチがなければ空文字を返す
        
        # 防水性能抽出
        target_string = ["50", "100", "150", "300", "1,220", "3,900", "11,000"]
        input_string = water_resistance
        water_resistance2 = extract_specific_strings(input_string, target_string)

        # ムーヴメント抽出
        target_string = ["自動巻", "手巻", "クオーツ"]
        input_string = movement_type_name
        movement_type_name = extract_specific_strings(input_string, target_string)

        # 文字間の削除(, yen space)する関数
        def remove_commas_and_spaces(input_string):
            cleaned_string = input_string.replace(',', '').replace(' ', '').replace('¥', '')
            return cleaned_string
        
        # 防水性能整理
        water_resistance3 = remove_commas_and_spaces(water_resistance2)
        # 値段整理
        price2 = remove_commas_and_spaces(price)


        # 正規表現で半角英数字を抽出
        def extract_alphanumeric(input_string):
            alphanumeric_string = re.sub(r'[^a-zA-Z0-9]', '', input_string)
            return alphanumeric_string
        
        # モデルナンバー抽出
        reference_number = extract_alphanumeric(reference_number)
        # キャリバー抽出
        caliber = extract_alphanumeric(caliber)


        # 正規表現で半角数字のみを抽出
        def extract_numeric(input_string):
            numeric_string = re.sub(r'[^0-9]', '', input_string)
            return numeric_string
        
        # パワーリザーブ抽出
        power_reserve = extract_numeric(power_reserve)
        # ケースサイズ抽出
        case_diameter = extract_numeric(case_diameter)

        # ページのアドレス末尾取得関数
        def get_url_suffix(driver):
            # 現在のページのURLを取得
            current_url = driver.current_url
            # URLの末尾を取得
            url_suffix = current_url.split('/')[-1]
            return url_suffix

        # 関数を使ってURLの末尾を取得
        suffix = get_url_suffix(driver)

       # URLの基本部分
        base_url = "https://media.rolex.com/image/upload/q_auto:eco/f_auto/t_v7/c_limit,w_3840/v1/catalogue/2025/upright-c/"
        image_url = f"{base_url}{suffix}"
        print(image_url)

        # 画像を取得
        response = requests.get(image_url)
        response.raise_for_status()  # エラーチェック

        # 画像を開き、PNG形式で保存
        try:
            img = Image.open(BytesIO(response.content))

            # 保存場所を指定
            save_path = "C:\\Users\\naoki\\Desktop\\scraping\\img\\rolex"
            os.makedirs(save_path, exist_ok=True)

            # 元のファイル名を作成
            base_filename = f"{manufacturer_name}_{reference_number}"
            file_path = os.path.join(save_path, f"{base_filename}.png")

            # ファイル名に連番を付けて重複を回避
            count = 1
            while os.path.exists(file_path):
                file_path = os.path.join(save_path, f"{base_filename}_{count}.png")
                count += 1

            # 画像を保存
            img.save(file_path, format="PNG")
            print(f"画像が{file_path}として保存されました")

        except Exception as e:
            print(f"画像の保存中にエラーが発生しました: {e}")


        watch_data.append({
            'manufacturer_name': manufacturer_name,
            'watch_name_ja': watch_name_ja,
            'reference_number': reference_number,
            'water_resistance': water_resistance3,
            'movement_type_name': movement_type_name,
            'caliber': caliber,
            'power_reserve': power_reserve,
            'case_diameter': case_diameter,
            'case_material_name_ja' : case_material_name_ja,
            'strap_material_name_ja' : strap_material_name_ja,
            'clasp_type_ja' : clasp_type_ja,
            'dial_color_ja' : dial_color_ja,
            'crystal_type': crystal_type,
            'date_display': date_display,
            'small_second': small_second,
            'chronograph' : chronograph,
            'GMT_function' : GMT_function,
            'price': price2,
        })
    
    except TimeoutException:
        print(f"情報の取得に失敗: {link}")
        continue

with open('C:\\Users\\naoki\\Desktop\\scraping\\rolex_scraped_data.txt', 'w', encoding='utf-8') as file:
    for watch in watch_data:
        file.write(
            f"[ 'manufacturer_name' => '{watch['manufacturer_name']}', "
            f"'watch_name_ja' => '{watch['watch_name_ja']}', "
            f"'reference_number' => '{watch['reference_number']}', "
            f"'water_resistance' => '{watch['water_resistance']}', "
            f"'movement_type_name' => '{watch['movement_type_name']}', "
            f"'caliber' => '{watch['caliber']}', "
            f"'power_reserve' => '{watch['power_reserve']}', "
            f"'case_diameter' => '{watch['case_diameter']}', "
            f"'case_material_name_ja' => '{watch['case_material_name_ja']}', "
            f"'strap_material_name_ja' => '{watch['strap_material_name_ja']}', "
            f"'clasp_type_ja' => '{watch['clasp_type_ja']}', "
            f"'dial_color_ja' => '{watch['dial_color_ja']}', "
            f"'crystal_type' => '{watch['crystal_type']}', "
            f"'date_display' => '{watch['date_display']}', "
            f"'small_second' => '{watch['small_second']}', "
            f"'chronograph' => '{watch['chronograph']}', "
            f"'GMT_function' => '{watch['GMT_function']}', "
            f"'price' => '{watch['price']}'],\n"
        )

# 全てのデータを表示
# for watch in watch_data:
#     print(
#         f"モデル名: {watch['name']}, モデルナンバー: {watch['reference_number']}, 防水性能: {watch['water_resistance']}, "
#         f"ムーヴメント: {watch['movement_type_id']}, キャリバー: {watch['caliber']}, パワーリザーヴ: {watch['power_reserve']}, "
#         f"価格: {watch['price']}, ケースサイズ: {watch['case_diameter']}, "
#     )
