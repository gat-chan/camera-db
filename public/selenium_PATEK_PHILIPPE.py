from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException, NoSuchElementException
import requests
import time
from PIL import Image
from io import BytesIO
import re
import os
from datetime import datetime

# 使用するブラウザのドライバを設定 (Chromeの場合)
driver = webdriver.Chrome()

# 一覧ページにアクセス
driver.get("https://www.patek.com/en/collection/twenty4")

# 始まるリンクを全て取得
product_links = driver.find_elements(By.XPATH, "//a[starts-with(@href, '/en/collection/twenty4/')]")

# リンクのURLをリストに保存
links = [link.get_attribute('href') for link in product_links]
# print(links)

# データを格納するリストを準備
watch_data = []

# ブランド名
brand_name = "PATEK PHILIPPE"

# 特定の文字列検出関数
def extract_question_mark_part_from_class(driver, class_name, search_strings):
    try:
        # 特定のクラス名を持つ要素を取得
        element = driver.find_element(By.CLASS_NAME, class_name)
        
        # 要素内のテキストを取得
        element_text = element.text
        
        # &thinsp; を半角スペースに変換
        element_text = element_text.replace('\u2009', ' ')  # Unicode U+2009 (thin space) を半角スペースに置換
        element_text = element_text.replace('&thinsp;', ' ')  # もしHTMLエンティティがそのまま存在する場合

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
        return 0

    except Exception as e:
        print(f"エラーが発生しました: {e}")
        return None

# 文字間の削除関数
def remove_commas_and_spaces(input_string):
    cleaned_string = input_string.replace(',', '').replace(' ', '').replace('¥', '').replace('JPY', '').replace("'", "")
    return cleaned_string

# -を_に変換
def replace_hyphen_with_underscore(text):
    return text.replace('-', '_')

# 日付の有り無しを確認する関数
def is_date_present(page_text):
    search_strings = ["Date in an aperture", "Date.", "Date coupled with local time", "Date by hand.",
                      "date in a double aperture."]
    
    for search_string in search_strings:
        # `?` を数値（整数または小数）をキャプチャする正規表現に変換
        pattern = re.escape(search_string).replace(r'\?', r'(.+)')  # 任意の文字列をキャプチャ
        pattern = pattern.replace(r'\.', r'\.')  # ピリオドに対応
        
        # 正規表現で一致するか確認
        match = re.search(pattern, page_text)
        if match:
            return '1'  # 日付が見つかった場合
    
    return '0'  # 日付が見つからなかった場合

# ページのアドレス末尾取得関数
def get_url_suffix(driver):
    # 現在のページのURLを取得
    current_url = driver.current_url
    # URLの末尾を取得
    url_suffix = current_url.split('/')[-1]
    return url_suffix

# ムーヴメント文字列構成
def convert_string(input_string):
    # マッピング辞書を定義
    conversion_dict = {
        "SELF-WINDING": "self-winding",
        "MANUAL WINDING": "manual-winding",
        "QUARTZ": "quartz",
    }

    # 入力文字列が辞書にある場合は変換、ない場合は元の文字列を返す
    return conversion_dict.get(input_string, input_string)

# 汎用的な素材取得関数
def extract_text_after_keyword(driver, keyword_list):
    try:
        # キーワードリストを使ってXPathを構築（複数のキーワードに対応）
        keyword_conditions = " or ".join([f"contains(text(), '{keyword}')" for keyword in keyword_list])
        xpath = f"//div[{keyword_conditions}]/following-sibling::div"
        
        # 要素を探して次の兄弟要素を取得
        element = driver.find_element(By.XPATH, xpath)
        
        # テキストを正規表現で解析し、カンマやピリオドの前までを取得
        extracted_text = re.match(r"^(.*?)[,.]", element.text)
        
        return extracted_text.group(1) if extracted_text else None

    except NoSuchElementException:
        print(f"{', '.join(keyword_list)} information not found.")
        return None

# 各属性の取得例
def extract_case_material(driver):
    return extract_text_after_keyword(driver, ["Case"])

def extract_bracelet_material(driver):
    return extract_text_after_keyword(driver, ["Bracelet", "Strap"])

def extract_dial_color(driver):
    return extract_text_after_keyword(driver, ["Dial"])


# 各リンクにアクセスして情報を取得
for link in links:
    driver.get(link)

    # ページを読み込んだ後、数秒待機
    time.sleep(0.5)  # 0.5秒間待機

    # ページの全テキストを取得
    page_text = driver.find_element(By.TAG_NAME, 'body').text
    
    try:
        # モデル名
        model_name = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.CLASS_NAME, 'complication'))
        ).text
        # print(model_name)

        # 品番・型番
        model_number = get_url_suffix(driver)
        # print(model_number)

        # 防水性能
        search_strings = ["Water-resistant to ? m.", "water-resistant to ? m", "Water-resistant to ?m.", 
                        "water-resistant to ?m"]
        class_name = "article_content"
        # 防水性能を取得する前に要素の存在を確認
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.CLASS_NAME, class_name))
        )
        water_resistance = extract_question_mark_part_from_class(driver, class_name, search_strings)
        # print(waterproof)

        # ムーヴメント
        movement_type = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.CLASS_NAME, "caliber_type_header"))
        ).text
        # print(movement_type)

        # 文字列を校正
        movement_type = convert_string(movement_type)

        # キャリバー
        calibre = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((
                By.XPATH, 
                '//h1[contains(@class, "hidden_xs hidden_sm hidden_md")]'
                '//span[@class="reference"]'
            ))
        ).text

        # パワーリザーヴ
        search_strings = ["max. ? hours", "Min. ? hours", "min. ? hours", "Battery life: about ? .",
                          "Movement power reserve: ? hours"]
        class_name = "attributes"
        power_reserve = extract_question_mark_part_from_class(driver, class_name, search_strings)
        # print(power_reserve)

        # 値段
        price_raw = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.ID, 'product_price'))
        ).get_attribute('innerText')
        clean_price = price_raw.split('*')[0].strip()
        price = remove_commas_and_spaces(clean_price)
        # print(price)

        # ケースサイズ
        search_strings = ["iameter: ? mm", "iameter: ?mm", "clock): ? mm.", "clock): ?mm.", "clock): ? mm.",
                          "iameter : ? mm"]
        class_name = "article_content"
        # ケースサイズを取得する前に要素の存在を確認
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.CLASS_NAME, class_name))
        )
        case_size = extract_question_mark_part_from_class(driver, class_name, search_strings)
        # print(case_size)

        # ケース厚
        search_strings = ["Height: ? mm.", "Thickness: ? mm.", "Height: ?mm.", "Thickness: ?mm.",
                          "Height : ? mm."]
        class_name = "article_content"
        # ケース厚を取得する前に要素の存在を確認
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.CLASS_NAME, class_name))
        )
        case_thickness = extract_question_mark_part_from_class(driver, class_name, search_strings)
        # print(case_thickness)

        #ケース素材
        case_material = extract_case_material(driver)

        #ベルト素材
        bracelet_material = extract_bracelet_material(driver)

        #ダイアルカラー
        dial_colour = extract_dial_color(driver)

        # 日付の有無
        date_display = is_date_present(page_text)
        # print(date_present)

        # 登録日
        registration_date = datetime.today().strftime('%Y-%m-%d')



        # 画像を取得して保存する関数
        def download_and_save_image(image_url, brand_name, model_number, save_dir):
            try:
                response = requests.get(image_url, timeout=10)  # タイムアウトの設定（例: 10秒）
                response.raise_for_status()  # エラーチェック
                img = Image.open(BytesIO(response.content))

                # フォルダが存在しない場合は作成
                os.makedirs(save_dir, exist_ok=True)

                # ファイルパスを作成し、PNG形式で保存
                file_path = os.path.join(save_dir, f"{brand_name}_{model_number}_{suffix}.png")
                img.save(file_path, format="PNG")
                print(f"画像が{file_path}として保存されました")

            except requests.exceptions.RequestException as e:  # 通信関連のエラー処理
                #print(f"画像のダウンロード中にエラーが発生しました: {e}")
                raise  # エラーを再度投げてフォールバックさせる
            except Exception as e:  # その他のエラー
                print(f"画像の保存中に失敗しました: {e}")
                raise

        # URLのサフィックスを取得してハイフンをアンダーバーに変換
        suffix = get_url_suffix(driver)
        image_suffix = replace_hyphen_with_underscore(suffix)

        # URLの基本部分
        image_urls = [
            f"https://static.patek.com/images/articles/face_white/350/{image_suffix}@2x.jpg",
            f"https://static.patek.com/images/articles/face_white/350/{image_suffix}_1@2x.jpg",
            f"https://static.patek.com/images/articles/face_white/350/{image_suffix}_001@2x.jpg",
            f"https://static.patek.com/images/articles/face_white/350/{image_suffix}_011@2x.jpg"

        ]

        # 保存場所を指定
        save_path = "C:\\Users\\naoki\\Desktop\\scraping\\img\\patek_philippe\\"

        # 複数のURLで画像の取得を試す
        for image_url in image_urls:
            try:
                download_and_save_image(image_url, brand_name, model_number, save_path)
                break  # 成功したらループを終了
            except Exception as e:
                None
                #print(f"{image_url}のダウンロードに失敗しました: {e}")

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
            'img_path' : suffix,
            'price': price,
            'registration_date' : registration_date
        })
    
        print(f"{model_number}スクレイピング完了")

    except TimeoutException:
        print(f"情報の取得に失敗: {link}")
        continue

# SQL文をテキストデータで保存
with open('C:\\Users\\naoki\\Desktop\\scraping\\pateck_scraped_data.txt', 'w', encoding='utf-8') as file:
    for watch in watch_data:
        file.write(
            f"INSERT INTO patek_philippe SET brand_name='{watch['brand_name']}', "
            f"model_name='{watch['model_name']}', model_number='{watch['model_number']}', "
            f"water_resistance='{watch['water_resistance']}', movement_type='{watch['movement_type']}', "
            f"calibre='{watch['calibre']}', power_reserve='{watch['power_reserve']}', "
            f"case_size='{watch['case_size']}', case_thickness='{watch['case_thickness']}', "
            f"case_material='{watch['case_material']}', bracelet_material='{watch['bracelet_material']}', "
            f"dial_colour='{watch['dial_colour']}', date_display='{watch['date_display']}', "
            f"img_path='{watch['img_path']}', price='{watch['price']}', "
            f"registration_date='{watch['registration_date']}';\n"
        )

# 全てのデータを表示
print("---全スクレイピング完了！---")

