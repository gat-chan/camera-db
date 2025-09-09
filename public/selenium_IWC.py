from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import requests
import time
from PIL import Image
from io import BytesIO
import re
import os
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
from datetime import datetime


# 使用するブラウザのドライバを設定 (Chromeの場合)
driver = webdriver.Chrome()

# 一覧ページにアクセス
driver.get("https://www.iwc.com/en/watches/ingenieur-watches")

# 指定のリンクがすべて表示されるまで待機
WebDriverWait(driver, 2).until(
    EC.presence_of_all_elements_located((By.XPATH, "//a[starts-with(@href, '/en/watch-collections/ingenieur/')]"))
)
time.sleep(2)

# 始まるリンクを全て取得
product_links = driver.find_elements(By.XPATH, "//a[starts-with(@href, '/en/watch-collections/ingenieur/')]")
time.sleep(2)

# リンクのURLをリストに保存（重複排除）
links = list(set([link.get_attribute('href') for link in product_links]))
print(links)

# データを格納するリストを準備
watch_data = []

# ブランド名
brand_name = "IWC"

# 特定の文字列検出関数
def extract_question_mark_part_from_class(driver, class_name_part, search_strings):
    try:
        # 部分一致するクラス名を持つ要素を取得
        element = driver.find_element(By.CSS_SELECTOR, f'[class*="{class_name_part}"]')
        
        # 要素内のテキストを取得
        element_text = element.text
        
        # &thinsp; を半角スペースに変換
        element_text = element_text.replace('\u2009', ' ')  # Unicode U+2009 (thin space) を半角スペースに置換
        element_text = element_text.replace('&thinsp;', ' ')  # HTMLエンティティがそのまま存在する場合

        # search_stringsの各パターンに対して一致するかを確認
        for search_string in search_strings:
            # `?` を数値（整数または小数）をキャプチャする正規表現に変換
            pattern = re.escape(search_string).replace(r'\?', r'(\d+(\.\d+)?)')  # 整数または小数をキャプチャ
            pattern = pattern.replace(r'\.', r'\.?')  # ピリオドに対応

            # 正規表現で一致するか確認
            match = re.search(pattern, element_text)
            if match:
                # マッチした部分の数値を返す
                return match.group(1)
        
        # マッチしなかった場合
        return None

    except Exception as e:
        if "no such element" in str(e).lower():
            print(f"{class_name_part}が含まれるクラスが見つかりませんでした。")
        else:
            print(f"エラーが発生しました: {e}")
        return None

# 文字間の削除関数
def remove_commas_and_spaces(input_string):
    cleaned_string = input_string.replace(',', '').replace(' ', '').replace('¥', '').replace('JPY', '').replace("'", "")
    return cleaned_string

# 正規表現で半角数字のみを抽出
def extract_numeric(input_string):
    numeric_string = re.sub(r'[^0-9,.]', '', input_string)
    return numeric_string

# 正規表現で半角数字のみを抽出
def extract_number(input_string):
    numeric_string = re.sub(r'[^0-9]', '', input_string)
    return numeric_string

# -を_に変換
def replace_hyphen_with_underscore(text):
    return text.replace('-', '_')

# 日付の有り無しを確認する関数
# 関数: 特定のXPathに文字列が存在するか確認
def is_date_present(search_string, timeout=4):
    xpath = '//*[@data-toggle-id="features-section-details"]//li[contains(text(), "Date display")]'  # 対象のXPathを指定

    try:
        # 要素が存在するまで待機
        WebDriverWait(driver, timeout).until(
            EC.presence_of_element_located((By.XPATH, xpath))
        )

        # 特定のリスト項目のテキストを取得
        date_present_element = driver.find_element(By.XPATH, xpath)

        # innerHTMLを取得して確認
        element_text = date_present_element.get_attribute('innerHTML')
          
        # print(f"抽出したテキスト: {element_text}")
        if search_string in element_text:
            return 1  # 文字列が見つかった場合
        else:
            return 0  # 文字列が見つからなかった場合
    
    except Exception as e:
        print(f"エラー: {e}")
        return 0  # エラーが発生した場合も0を返す
    


# 各リンクにアクセスして情報を取得
for link in links:
    driver.get(link)

    # ページを読み込んだ後、数秒待機
    time.sleep(1.0)  # x秒間待機

    # ページの全テキストを取得
    page_text = driver.find_element(By.TAG_NAME, 'body').text
    
    try:
        # モデル名
        model_name = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.CLASS_NAME, 'iwc-pdp-v3-product-info__title'))
        ).text
        print(f"モデル名= {model_name}")

        # 品番・型番
        model_number = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((
                By.XPATH, '//*[@id="iwc-main-content"]/div/section[1]/div/div[2]/div/div[1]/div/div[1]/p'))
        ).text
        print(f"型番= {model_number}")

        # 防水性能
        search_strings = ["Water resistance ? bar", "Water resistance?bar"]
        class_name_part = "iwc-section-detail"
        # 防水性能を取得する前に要素の存在を確認
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.CLASS_NAME, class_name_part))
        )
        waterproof_raw = extract_question_mark_part_from_class(driver, class_name_part, search_strings)
        waterproof_atmo = extract_numeric(waterproof_raw)

        #気圧→メートル変換
        waterproof_flo = int(float(waterproof_atmo)) *10

        #数字→文字列
        water_resistance = str(waterproof_flo)
        print(f"防水= {water_resistance}")

        # ムーヴメント
        xpath = '//*[@data-toggle-id="movement-section-details"]//li[contains(text(), "winding")]'

        # 要素が存在するまで待機
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, xpath))
        )

        # 特定のリスト項目のテキストを取得
        movement_type_element = driver.find_element(By.XPATH, xpath)

        # innerHTMLを取得して確認
        inner_html = movement_type_element.get_attribute('innerHTML')

        #空白削除
        movement_type = inner_html.strip()
        print(f"ムーヴメント= {movement_type}")

        # print(movement_type)

        # キャリバー
        xpath = '//*[@data-toggle-id="movement-section-details"]//li[contains(text(), "Calibre")]'

        # 要素が存在するまで待機
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, xpath))
        )

        # 特定のリスト項目のテキストを取得
        calibre_element = driver.find_element(By.XPATH, xpath)

        # innerHTMLを取得して確認
        calibre_html = calibre_element.get_attribute('innerHTML')

        #数字抽出
        calibre = extract_number(calibre_html)
        print(f"キャリバー= {calibre}")

        # print(calibre)

        # パワーリザーヴ
        xpath = '//*[@data-toggle-id="movement-section-details"]//li[contains(text(), "Power Reserve")]'

        # 要素が存在するまで待機
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, xpath))
        )

        # 特定のリスト項目のテキストを取得
        power_reserve_element = driver.find_element(By.XPATH, xpath)

        # innerHTMLを取得して確認
        power_html = power_reserve_element.get_attribute('innerHTML')

        #空白削除
        power_reserve = extract_numeric(power_html)

        print(f"パワーリザーヴ= {power_reserve}")

        # print(power_reserve)

        # 値段
        # price_raw = WebDriverWait(driver, 10).until(
        #     EC.presence_of_element_located((
        #         By.XPATH, '//*[@id="iwc-main-content"]/div/section[1]/div/div[2]/div/div[2]/div[1]'))
        # ).text
        # price = extract_number(price_raw)
        # print(price_raw)

        # ケースサイズ
        case_size_raw = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((
                By.XPATH, '//*[@id="iwc-features"]/div/div/div/div[1]/div[1]/ul/li[2]'))
        ).text
        case_size_num = extract_numeric(case_size_raw)

        case_size = int(float(case_size_num))
        print(f"ケースサイズ= {case_size}")

        # ケース厚
        case_thickness_raw = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((
                By.XPATH, '//*[@id="iwc-features"]/div/div/div/div[1]/div[1]/ul/li[3]'))
        ).text
        case_thickness = extract_numeric(case_thickness_raw)
        print(f"ケース厚= {case_thickness}")

        # スペックを取得
        spec_data_element = WebDriverWait(driver, 3).until(
            EC.presence_of_element_located((By.XPATH, '//*[@id="iwc-main-content"]/div/section[1]/div/div[2]/div/p'))
        )
        spec_text = spec_data_element.text
        parts = spec_text.split(", ")

        # ケース素材
        case_material = parts[0] if len(parts) > 4 else None
        print(f"ケース素材= {case_material}")

        # ブレス素材
        bracelet_material = parts[3] if len(parts) > 4 else None
        print(f"ブレス素材= {bracelet_material}")

        # 文字盤カラー
        dial_colour = parts[4] if len(parts) > 4 else None
        print(f"文字盤カラー= {dial_colour}")

        # 日付の有無
        search_string = 'Date display'
        date_display = is_date_present(search_string)
        print(f"日付有無= {date_display}")

        # 登録日
        registration_date = datetime.today().strftime('%Y-%m-%d')
        print(f"登録日= {registration_date}")

        # 画像を取得

        # ベースURLの設定
        base_url = "https://www.iwc.com"

        # Seleniumで画像を取得する処理
        try:
            # リクエストヘッダーにUser-Agentを設定
            # headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.36"}

            # まず、iwc-cx-product-galleryクラスの要素を探す
            gallery_tag = driver.find_element(By.CLASS_NAME, "iwc-cx-product-gallery")

            # gallery_tagの中からiwc-picture-tagクラスの要素を探す
            picture_tag = gallery_tag.find_element(By.CLASS_NAME, "iwc-picture-tag")
            
            # <source>タグの画像URLを取得
            source_tag = picture_tag.find_element(By.TAG_NAME, "source")
            srcset_urls = source_tag.get_attribute('srcset').split(',')  # URLリストを取得

            # 2番目のURLを取得
            image_url = srcset_urls[1].strip()  # 2番目のURLを選択

            # '2x' を取り除く
            if image_url.endswith('2x'):
                image_url = image_url[:-2]  # 末尾の '2x' を削除

            # 相対URLの場合、ベースURLを追加して完全なURLにする
            if image_url.startswith('/'):
                image_url = base_url + image_url

            print(f"取得した画像URL: {image_url}")


            # # 画像をリクエスト
            # response = requests.get(image_url, headers)
            # response.raise_for_status()  # リクエストが成功したか確認

            # # 画像を開き、PNG形式で保存
            # try:
            #     img = Image.open(BytesIO(response.content))

            #     # 保存場所を指定
            #     save_path = "C:\\Users\\naoki\\Desktop\\scraping\\img\\iwc"  # 保存したいフォルダのパス
            #     os.makedirs(save_path, exist_ok=True)  # フォルダが存在しない場合は作成

            #     # PNG形式で保存
            #     file_path = os.path.join(save_path, f"{brand_name}_{model_number}.png")
            #     img.save(file_path, format="PNG")

            #     print(f"画像が{file_path}として保存されました")

            # except Exception as e:
            #     print(f"画像の保存中にエラーが発生しました: {e}")

        except Exception as e:
             print(f"画像の取得中にエラーが発生しました: {e}")

        


        watch_data.append({
            'brand_name': brand_name,
            'model_name': model_name,
            'model_number': model_number,
            'water_resistance': water_resistance,
            'movement_type': movement_type,
            'calibre': calibre,
            'power_reserve': power_reserve,
            'case_size': case_size,
            'case_thickness': case_thickness,
            'case_material' : case_material,
            'bracelet_material' : bracelet_material,
            'dial_colour' : dial_colour,
            'date_display': date_display,
            #'chronograph' : chronograph,
            #'GMT_function' : GMT_function,
            'img_path' : model_number,
            #'price': price,
            'registration_date' : registration_date,
            'image_url' : image_url
        })
    
    except TimeoutException:
        print(f"情報の取得に失敗: {link}")
        continue

# SQL文をテキストデータで保存
with open('C:\\Users\\naoki\\Desktop\\scraping\\IWC_scraped_data.txt', 'w', encoding='utf-8') as file:
    for watch in watch_data:
        file.write(
            f"INSERT INTO patek_philippe SET brand_name='{watch['brand_name']}', "
            f"model_name='{watch['model_name']}', model_number='{watch['model_number']}', "
            f"water_resistance='{watch['water_resistance']}', movement_type='{watch['movement_type']}', "
            f"calibre='{watch['calibre']}', power_reserve='{watch['power_reserve']}', "
            f"case_size='{watch['case_size']}', case_thickness='{watch['case_thickness']}', "
            f"case_material='{watch['case_material']}', bracelet_material='{watch['bracelet_material']}', "
            f"dial_colour='{watch['dial_colour']}', date_display='{watch['date_display']}', "
            f"img_path='{watch['img_path']}', "
            f"registration_date='{watch['registration_date']}';\n"
        )

        # 画像urlをテキストデータで保存
with open('C:\\Users\\naoki\\Desktop\\scraping\\img\\IWC\\img.txt', 'w', encoding='utf-8') as file:
    for watch in watch_data:
        file.write(f"{watch['brand_name']}_{watch['model_number']}_{watch['image_url']}\n") 

