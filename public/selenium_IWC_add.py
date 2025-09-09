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
from selenium.webdriver.common.action_chains import ActionChains


# 使用するブラウザのドライバを設定 (Chromeの場合)
driver = webdriver.Chrome()

# 一覧ページにアクセス
driver.get("https://www.iwc.com/en/watches/pilot-watches")



# "AGREE" ボタンを探してクリック
agree_button = WebDriverWait(driver, 10).until(
    EC.element_to_be_clickable((By.ID, "popin_tc_privacy_button"))
)
agree_button.click()
print("AGREEボタンをクリックしました")

# データを格納するリストを準備
watch_data = []

# ブランド名
brand_name = "IWC"

def extract_matching_texts(driver, class_name, target_strings):
    matching_texts = []
    try:
        # 指定されたクラス名の要素を取得
        element = WebDriverWait(driver, 2).until(
            EC.presence_of_element_located((By.CLASS_NAME, class_name))
        )
        
        # 要素のテキストを確認
        text = element.text  # 要素のテキストを取得
        for target_string in target_strings:
            if target_string in text:
                matching_texts.append(target_string)
                    
    except Exception as e:
        print(f"エラー: {e}")
    
    # リストを単一の文字列に変換（コンマで区切る）
    return ", ".join(matching_texts)

# 特定の文字列検出関数
def extract_question_mark_part_from_class(driver, class_name_part, search_strings):
    try:
        # 部分一致するクラス名を持つ要素を取得
        element = driver.find_element(By.CSS_SELECTOR, f'[class*="{class_name_part}"]')
        
        # 要素内のテキストを取得
        element_text = element.text

        print(f"クラス内テキスト: {element_text}")
        
        # &thinsp; を半角スペースに変換
        element_text = element_text.replace('\u2009', ' ')  # Unicode U+2009 (thin space) を半角スペースに置換
        element_text = element_text.replace('&thinsp;', ' ')  # HTMLエンティティがそのまま存在する場合

        # search_stringsの各パターンに対して一致するかを確認
        for search_string in search_strings:
            # 正規表現で "Case" の直前の単語列をキャプチャ
            pattern = rf",?\s*([\w\s]+){re.escape(search_string)}"
            match = re.search(pattern, element_text)
            if match:
                # マッチした部分を返す（"Stainless steel"）
                return match.group(1).strip()
        
        # マッチしなかった場合
        return None

    except Exception as e:
        if "no such element" in str(e).lower():
            print(f"{class_name_part}が含まれるクラスが見つかりませんでした。")
        else:
            print(f"エラーが発生しました: {e}")
        return None


# 文字列変換関数
def replace_substring(input_string, char1_list, char2):
    if not char1_list:
        raise ValueError("char1_listは空リストではいけません。")
    
    # char1_listの各文字列を順番に置換
    for char1 in char1_list:
        input_string = input_string.replace(char1, char2)
    
    return input_string

# 正規表現で半角数字のみを抽出
def extract_number(input_string):
    numeric_string = re.sub(r'[^0-9]', '', input_string)
    return numeric_string

# -を_に変換
def replace_hyphen_with_underscore(text):
    return text.replace('-', '_')

# 日付の有り無しを確認する関数
def is_date_present(timeout=4):
    xpath = '//*[@data-toggle-id="features-section-details"]//li'

    try:
        WebDriverWait(driver, timeout).until(
            EC.presence_of_element_located((By.XPATH, xpath))
        )

        list_items = driver.find_elements(By.XPATH, xpath)
        date_strings = ["Date display", "Day and date display", "date and month and leap year display"]

        for item in list_items:
            element_text = item.get_attribute('innerHTML')
            # print(f"リスト項目のテキスト: {element_text}")  # デバッグ用出力

            for date_string in date_strings:
                if date_string in element_text:
                    print(f"一致した文字列: {date_string}")
                    return 1

        print("指定文字列は見つかりませんでした。")
        return 0

    except Exception as e:
        print(f"エラー: {e}")
        return 0
    
# "continue to current site" ボタンを探す
continue_button = WebDriverWait(driver, 10).until(
    EC.element_to_be_clickable((By.XPATH, "//span[contains(text(), 'continue to current site')]"))
)
# ボタンをクリック
continue_button.click()
print("continue to current site ボタンをクリックしました")
time.sleep(15.0)  # x秒間待機

# 指定のリンクがすべて表示されるまで待機
WebDriverWait(driver, 2).until(
    EC.presence_of_all_elements_located((By.XPATH, "//a[starts-with(@href, '/en/watch-collections/pilot-watches/')]"))
)

# 始まるリンクを全て取得
product_links = driver.find_elements(By.XPATH, "//a[starts-with(@href, '/en/watch-collections/pilot-watches/')]")
time.sleep(1)

# リンクのURLをリストに保存（重複排除）
links = list(set([link.get_attribute('href') for link in product_links]))
print(links)

# 各リンクにアクセスして情報を取得
for link in links:
    driver.get(link)


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

        # ムーヴメント
        xpath = '//*[@data-toggle-id="movement-section-details"]//span[contains(text(), "winding")]'


        # 要素が存在するまで待機
        WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, xpath))
        )

        # 特定のリスト項目のテキストを取得
        movement_type_element = driver.find_element(By.XPATH, xpath)

        # innerHTMLを取得して確認
        inner_html = movement_type_element.get_attribute('innerHTML')

        #空白削除
        movement_type1 = inner_html.strip()
        parts = movement_type1.split(",")
        movement_type= parts[0]
        print(f"ムーヴメント= {movement_type}")

        # print(movement_type)

        # キャリバー
        xpath = '//*[@data-toggle-id="movement-section-details"]//span[@class="iwc-product-specs-item__value"]'      
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

        # ケース素材
        target_strings = ["Stainless steel", "Ceratanium", "18 ct 5N gold","18 ct white gold", "18 ct Armor Gold", 
                          "Platinum", "Ceramic", "Titanium", "Bronze"]
        class_name = "iwc-pdp-v3-product-info-customizer"
        case_material = extract_matching_texts(driver, class_name, target_strings)
        print(f"ケース素材= {case_material}")

        try:
            # "PRODUCT INFORMATION" ボタンを探してクリック
            product_info_button = WebDriverWait(driver, 5).until(
                EC.element_to_be_clickable((By.XPATH, "//p[contains(text(), 'PRODUCT INFORMATION')]"))
            )

            # ボタンをクリック
            product_info_button.click()
            time.sleep(1.0)  # x秒間待機

            # 展開された内容を待機して取得
            parent_element = WebDriverWait(driver, 5).until(
                EC.presence_of_element_located((By.CLASS_NAME, "iwc-pdp-v3-product-info__list"))
            )

            # <li> の中の <span> 要素を取得
            span_elements = parent_element.find_elements(By.TAG_NAME, "span")


        except TimeoutException:
            print("メニューの展開または要素の取得に失敗しました")


        # ブレス素材
        char1_list = ["with quick-change system", "with IWC-patented quick-change system", 
                      " bracelet"," by Santoni", " with EasX-CHANGE system"]
        char2 = ""  # 置き換える文字列（空文字にする）
        bracelet_material = replace_substring(span_elements[2].text, char1_list, char2)
        print(f"ブレス素材= {bracelet_material}")

        # 文字盤カラー
        char1_list = ["dial"]
        char2 = ""  # 置き換える文字列（空文字にする）
        dial_colour = replace_substring(span_elements[0].text, char1_list, char2)
        print(f"文字盤カラー= {dial_colour}")

        # 日付の有無
        date_display = is_date_present()
        print(f"日付有無= {date_display}")

        # 登録日
        registration_date = datetime.today().strftime('%Y-%m-%d')
        print(f"登録日= {registration_date}")


        


        watch_data.append({
            'brand_name': brand_name,
            'model_name': model_name,
            'model_number': model_number,
            'movement_type': movement_type,
            'calibre': calibre,
            'case_material' : case_material,
            'bracelet_material' : bracelet_material,
            'dial_colour' : dial_colour,
            'date_display': date_display,
            #'chronograph' : chronograph,
            #'GMT_function' : GMT_function,
            'img_path' : model_number,
            'registration_date' : registration_date,
        })
    
    except TimeoutException:
        print(f"情報の取得に失敗: {link}")
        continue

# SQL文をテキストデータで保存
with open('C:\\Users\\naoki\\Desktop\\scraping\\IWC_scraped_data.txt', 'w', encoding='utf-8') as file:
    for watch in watch_data:
        file.write(
            f"('{watch['brand_name']}','{watch['model_name']}','{watch['model_number']}','{watch['movement_type']}', "
            f"'{watch['calibre']}','{watch['case_material']}','{watch['bracelet_material']}', "
            f"'{watch['dial_colour']}','{watch['date_display']}','{watch['img_path']}','{watch['registration_date']}'),\n"
        )


