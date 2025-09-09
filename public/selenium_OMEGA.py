from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import requests
from PIL import Image
from io import BytesIO
import unicodedata
import re
import os
from urllib.parse import urlparse
from datetime import datetime
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import TimeoutException
from selenium.common.exceptions import NoSuchElementException

# 使用するブラウザのドライバを設定 (Chromeの場合)
driver = webdriver.Chrome()

# シリーズの一覧ページにアクセス
driver.get("https://www.omegawatches.jp/watches/seamaster/diver-300-m/catalog")
time.sleep(20)

# 指定のリンクがすべて表示されるまで待機
# WebDriverWait(driver, 10).until(
#     EC.presence_of_all_elements_located((By.XPATH, "//a[starts-with(@href, 'watch-omega-seamaster-aqua-terra')]"))
# )

# 始まるリンクを全て取得
product_links = driver.find_elements(By.XPATH, "//a[starts-with(@href, " \
"'https://www.omegawatches.jp/watch-omega-')]")

# リンクのURLをリストに保存（重複を除外）
links = list(set(link.get_attribute('href') for link in product_links))
print(links)

# 取得したリンクの数を出力
print(f"取得した製品リンクの数: {len(links)} 件")

# データを格納するリストを準備
watch_data = []

# brandname
manufacturer_name = "オメガ"

# 日付の有り無しを確認する関数
def is_date_present(driver):
    try:
        driver.find_element("xpath", "//li[contains(., '日付表示')]")
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
    xpath = "//p[contains(text(), 'GMT') or contains(text(), 'ワールドタイマー')]"
    try:
        driver.find_element("xpath", xpath)
        return 1
    except NoSuchElementException:
        return 0

# small_secondの有り無しを確認する関数
def is_small_second_present(driver):
    xpath = "//p[contains(text(), 'GMT') or contains(text(), 'スモールセコンド')]"
    try:
        driver.find_element("xpath", xpath)
        return 1
    except NoSuchElementException:
        return 0
    
# bom削除
def clean_text(text):
    return text.replace('\ufeff', '').strip() if isinstance(text, str) else text

# 特定の文字列抽出関数
def extract_specific_strings(input_string, target_strings):
    extracted_strings = []
    for target_string in target_strings:
        if target_string in input_string:
            extracted_strings.append(target_string)
    
    # 抽出結果を結合して単一の文字列として返す
    return ', '.join(extracted_strings) if extracted_strings else ''  # マッチがなければ空文字を返す
    
# 正規表現で半角英数字を抽出
def extract_alphanumeric(input_string):
    alphanumeric_string = re.sub(r'[^a-zA-Z0-9.]', '', input_string)
    return alphanumeric_string

# 文字間の削除(, yen space)する関数
def remove_commas_and_spaces(input_string):
    cleaned_string = input_string.replace(',', '').replace(' ', '').replace('¥', '')
    return cleaned_string

# 正規表現で半角英数字を抽出
def extract_alphanumeric(input_string):
    alphanumeric_string = re.sub(r'[^a-zA-Z0-9.]', '', input_string)
    return alphanumeric_string

# 正規表現で半角数字のみを抽出
def extract_numeric(input_string):
    if not input_string:          # None, '' のどちらでも True
        return None               # あるいは '' や 0 など好きなデフォルト
    return re.sub(r'[^0-9.]', '', input_string)

#各要素取得
def clean_and_escape_text(text):
    if text is None:
        return ''

    # 不可視文字の削除（BOM、ゼロ幅スペースなど）
    text = text.replace('\ufeff', '').replace('\u200b', '')

    # 正規化（Unicodeのバラつきを整える）
    text = unicodedata.normalize('NFKC', text)

    # 一般的なエスケープ
    # text = text.replace('\\', '\\\\')   # バックスラッシュ
    # text = text.replace("'", "\\'")     # シングルクォート
    # text = text.replace('"', '\\"')     # ダブルクォート
    # text = text.replace('\n', '\\n')    # 改行
    # text = text.replace('\r', '')       # キャリッジリターン

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

# 各リンクにアクセスして情報を取得
for link in links:
    # ページにアクセス
    driver.get(link)
    
    # ページが完全に読み込まれるまで待機
    WebDriverWait(driver, 10).until(
        lambda d: d.execute_script('return document.readyState') == 'complete'
    )

    try:
        # 要素が表示されるまで最大10秒待機 (要素が表示されたら取得)


        # 名前取得
        collection = clean_text(get_element_text_safe(driver, By.CLASS_NAME, 'collection') or '')
        subcollection = clean_text(get_element_text_safe(driver, By.CLASS_NAME, 'subcollection') or '')

        # 結合して時計の名前を作成（片方が空でもOK）
        watch_name_ja = f"{collection} {subcollection}".strip()
        print(watch_name_ja)

        # 値段
        price_amount_element = driver.find_element("xpath", "//span[@data-price-type='finalPrice']")
        price = price_amount_element.get_attribute("data-price-amount")  # → "1738000"
        print(price)

        try:
            retry_limit = 3  # ページ再読み込みの最大回数
            success = False

            for retry in range(retry_limit):
                print(f"==== ページ再試行 {retry + 1} 回目 ====")

                if retry > 0:
                    driver.get(link)
                    print("ページを再読み込みしました")
                    WebDriverWait(driver, 10).until(
                        lambda d: d.execute_script('return document.readyState') == 'complete'
                    )

                # 「説明」ボタン取得
                feature_button = WebDriverWait(driver, 10).until(
                    EC.presence_of_element_located((By.XPATH, '//button[contains(@class, "ow-collapsible__title") and contains(text(), "説明")]'))
                )

                WebDriverWait(driver, 10).until(EC.element_to_be_clickable(feature_button))
                feature_button.click()
                print("「説明」ボタンをクリックして展開を試みました")

                max_attempts = 5
                for attempt in range(max_attempts):
                    aria_expanded = feature_button.get_attribute("aria-expanded")
                    print(f"[試行 {attempt + 1}] aria-expanded: {aria_expanded}")

                    if aria_expanded == "true":
                        success = True
                        print("説明ブロックが展開されました")
                        break
                    time.sleep(1.0)

                if success:
                    break  # retryループも終了

            if not success:
                print("最大リトライ回数を超えました。説明ブロック取得失敗")

        except Exception as e:
            print(f"説明ブロックの処理に失敗しました: {e}")



        # 説明テキスト取得処理
        description_container = WebDriverWait(driver, 10).until(
                    EC.visibility_of_element_located((By.CSS_SELECTOR, 'div.technical-data-value[data-code="description"]'))
                )
        if description_container:
            p_elements = description_container.find_elements(By.TAG_NAME, 'p')
            description_ja = "\\n".join([
                clean_and_escape_text(p.get_attribute("innerText"))
                for p in p_elements if p.get_attribute("innerText").strip()
            ])
            print(description_ja)
        else:
            print("説明要素が見つかりませんでした")


        # 技術資料　クリック
        try:
            # 「技術」という文字を持つボタンをクリック可能になるまで待機
            feature_button = WebDriverWait(driver, 10).until(
                EC.element_to_be_clickable((By.XPATH, '//button[contains(@class, "ow-collapsible__title") and contains(text(), "技術")]'))
            )
            feature_button.click()
            print("「技術資料」ボタンをクリックしました")
        except Exception as e:
            print(f"「技術資料」ボタンクリックに失敗しました: {e}")

        time.sleep(0.5)

        reference_number = get_element_text_safe(driver, By.CSS_SELECTOR, 'dd.technical-data-value[data-code="sku"]')
        print(reference_number)
        water_resistance = get_element_text_safe(driver, By.CSS_SELECTOR, 'dd.technical-data-value[data-code="watch_waterresistance"]')
        print(water_resistance)
        movement_type_name = get_element_text_safe(driver, By.CSS_SELECTOR, 'dd.technical-data-value[data-code="caliber_movement_label"]')
        print(f"DEBUG: {repr(movement_type_name)}")
        caliber = get_element_text_safe(driver, By.CSS_SELECTOR, 'dd.technical-data-value[data-code="caliber_product_caliber_option_id"]')
        print(caliber)
        power_reserve = get_element_text_safe(driver, By.CSS_SELECTOR, 'dd.technical-data-value[data-code="caliber_power_reserve"]')
        print(power_reserve)
        case_diameter = get_element_text_safe(driver, By.CSS_SELECTOR, 'dd.technical-data-value[data-code="watch_casediameter"]')
        print(case_diameter)
        case_thickness = get_element_text_safe(driver, By.CSS_SELECTOR, 'dd.technical-data-value[data-code="watch_thickness"]')
        print(case_thickness)
        lug_width = get_element_text_safe(driver, By.CSS_SELECTOR, 'dd.technical-data-value[data-code="watch_between_lugs_size"]')
        print(lug_width)
        lug_to_lug = get_element_text_safe(driver, By.CSS_SELECTOR, 'dd.technical-data-value[data-code="watch_lug_to_lug"]')
        print(lug_to_lug)
        weight = get_element_text_safe(driver, By.CSS_SELECTOR, 'dd.technical-data-value[data-code="watch_case_weight"]')
        print(weight)
        case_material_name_ja = clean_text(get_element_text_safe(driver, By.CSS_SELECTOR, 'dd.technical-data-value[data-code="watch_watchcase"]') or '')
        print(case_material_name_ja)
        dial_color_ja = clean_text(get_element_text_safe(driver, By.CSS_SELECTOR, 'dd.technical-data-value[data-code="watch_dial"]') or '')
        print(dial_color_ja)
        crystal_type = clean_text(get_element_text_safe(driver, By.CSS_SELECTOR, 'dd.technical-data-value[data-code="watch_crystal"]') or '')
        print(crystal_type)
    
        # ストラップ　クリック
        try:
            # 「ストラップ」または「ブレスレット」という文字を含むボタンを取得
            strap_or_bracelet_button = WebDriverWait(driver, 10).until(
                EC.element_to_be_clickable((
                    By.XPATH,
                    '//button[contains(@class, "ow-collapsible__title") and (contains(text(), "ストラ") or contains(text(), "ブレスレ"))]'
                ))
            )
            strap_or_bracelet_button.click()
            print("「ストラップ」または「ブレスレット」ボタンをクリックしました")
        except Exception as e:
            print(f"ボタンクリックに失敗しました: {e}")

        time.sleep(0.5)

        strap_material_name_ja = clean_text(WebDriverWait(driver, 10).until(
            EC.visibility_of_element_located((By.CSS_SELECTOR, 'dd.technical-data-value[data-code="strap_materials"]'))
        ).text.strip())
        print(strap_material_name_ja)

        clasp_type_ja = None
        try:
            clasp_type_ja = WebDriverWait(driver, 2).until(
                EC.visibility_of_element_located((By.CSS_SELECTOR, 'dd.technical-data-value[data-code="strap_clasp_type"]'))
            ).text.strip()
        except:
            try:
                clasp_type_ja = WebDriverWait(driver, 2).until(
                    EC.visibility_of_element_located((By.CSS_SELECTOR, 'dd.technical-data-value[data-code="buckle_type"]'))
                ).text.strip()
            except:
                clasp_type_ja = None

        if clasp_type_ja:
            clasp_type_ja = clean_text(clasp_type_ja)
            print(clasp_type_ja)
        else:
            print("clasp_type_ja not found")

        # 機能　クリック
        try:
            # 「機能」タブが存在するかをまず確認
            feature_buttons = driver.find_elements(By.XPATH, '//button[contains(@class, "ow-collapsible__title") and contains(text(), "機能")]')

            if feature_buttons:
                # 存在する場合のみクリック可能になるまで待機してクリック
                feature_button = WebDriverWait(driver, 10).until(
                    EC.element_to_be_clickable(feature_buttons[0])
                )
                feature_button.click()
                print("「機能」ボタンをクリックしました")

                time.sleep(0.5)

                # 各機能の有無を確認
                date_display = is_date_present(driver)
                print(date_display)

                chronograph = is_chronograph_present(driver)
                print(chronograph)

                GMT_function = is_gmt_or_dual_time_present(driver)
                print(GMT_function)

                small_second = is_small_second_present(driver)
                print(small_second)

            else:
                print("「機能」タブが存在しません。各機能は 0 として扱います。")
                date_display = 0
                chronograph = 0
                GMT_function = 0
                small_second = 0

        except Exception as e:
            print(f"「機能」タブ処理中にエラーが発生しました: {e}")
            date_display = 0
            chronograph = 0
            GMT_function = 0
            small_second = 0
        
        # 防水性能抽出
        target_string = ["30 メートル", "50 メートル", "60 メートル", "100 メートル", "150 メートル", "300 メートル", "600 メートル", "1,220", "3,900", "6000 メートル", "11,000"]
        input_string = water_resistance
        water_resistance2 = extract_specific_strings(input_string, target_string)
        water_resistance3 = extract_numeric(water_resistance2)

        # ムーヴメント抽出
        target_string = ["自動巻", "手巻", "クオーツ", "クォーツ"]
        input_string = movement_type_name
        movement_type_name = extract_specific_strings(input_string, target_string)

        # クリスタル抽出
        target_string = ["強化プラスチックガラス", "サファイアクリスタル", "サファイアガラス", "ミネラルガラス", "アクリルガラス"]
        input_string = crystal_type
        crystal_type = extract_specific_strings(input_string, target_string)
       
        # 値段整理
        price2 = remove_commas_and_spaces(price)
       
        # モデルナンバー抽出
        reference_number = extract_alphanumeric(reference_number)
        # キャリバー抽出
        caliber = extract_alphanumeric(caliber)
       
        # ケースサイズ抽出
        case_diameter = extract_numeric(case_diameter)
        # ケース厚抽出
        case_thickness = extract_numeric(case_thickness)
        # ラグ幅抽出
        lug_width = extract_numeric(lug_width)
        # ラグ長抽出
        lug_to_lug = extract_numeric(lug_to_lug)
        # パワーリザーブ抽出
        power_reserve = extract_numeric(power_reserve)
        # 重量抽出
        weight = extract_numeric(weight)

        
        # # 保存先パス
        # save_path = "C:\\Users\\naoki\\Desktop\\scraping\\img\\omega"
        # os.makedirs(save_path, exist_ok=True)

        # # ".pp-gallery__ul" 内の <img> 要素のみ取得
        # gallery_ul = driver.find_element(By.CLASS_NAME, "pp-gallery__ul")
        # img_elements = gallery_ul.find_elements(By.TAG_NAME, "img")

        # for index, img in enumerate(img_elements):
        #     srcset = img.get_attribute("srcset")
        #     if not srcset:
        #         continue  # srcsetがないimgはスキップ

        #     # 最大幅のURLを選ぶ
        #     max_width = 1100
        #     best_url = None
        #     for entry in srcset.split(","):
        #         parts = entry.strip().split(" ")
        #         if len(parts) != 2:
        #             continue
        #         url, width_part = parts
        #         try:
        #             width = int(width_part.replace("w", ""))
        #             if width > max_width:
        #                 max_width = width
        #                 best_url = url
        #         except:
        #             continue

        #     if not best_url:
        #         continue

        #     print(f"[{index}] 保存対象画像URL（最大幅 {max_width}w）: {best_url}")


        #     # 画像保存処理
        #     try:
        #         response = requests.get(best_url)
        #         response.raise_for_status()
        #         img_data = Image.open(BytesIO(response.content))

        #         # 元のファイル名を作成
        #         base_filename = f"OMEGA_{reference_number}"
        #         file_path = os.path.join(save_path, f"{base_filename}.png")

        #         # ファイル名に連番を付けて重複を回避
        #         count = 1
        #         while os.path.exists(file_path):
        #             file_path = os.path.join(save_path, f"{base_filename}_{count}.png")
        #             count += 1

        #         img_data.save(file_path)
        #         print(f"画像を保存しました: {file_path}")

        #     except Exception as e:
        #         print(f"画像保存エラー（{best_url}）: {e}")


        watch_data.append({
            'manufacturer_name': manufacturer_name,
            'watch_name_ja': watch_name_ja,
            'description_ja': description_ja,
            'reference_number': reference_number,
            'water_resistance': water_resistance3,
            'movement_type_name': movement_type_name,
            'caliber': caliber,
            'power_reserve': power_reserve,
            'case_diameter': case_diameter,
            'case_thickness': case_thickness,
            'lug_width': lug_width,
            'lug_to_lug': lug_to_lug,
            'weight': weight,
            'case_material_name_ja' : case_material_name_ja,
            'strap_material_name_ja' : strap_material_name_ja,
            'clasp_type_ja' : clasp_type_ja,
            'dial_color_ja' : dial_color_ja,
            'date_display': date_display,
            'crystal_type': crystal_type,
            'chronograph' : chronograph,
            'GMT_function' : GMT_function,
            'small_second' : small_second,
            'price': price2,
        })
    
    except TimeoutException:
        print(f"情報の取得に失敗: {link}")
        continue

    # 取得したリンクの数を出力
    print(f"取得したウォッチデータの件数: {len(watch_data)} / {len(links)}件")


with open('omega_scraped_data.txt', 'w', encoding='utf-8') as file:
    for watch in watch_data:
        file.write(
            f"['manufacturer_name' => '{watch['manufacturer_name']}', "
            f"'watch_name_ja' => '{watch['watch_name_ja']}', "
            f"'description_ja' => '{watch['description_ja']}', "
            f"'reference_number' => '{watch['reference_number']}', "
            f"'price' => '{watch['price']}',"
            f"'case_diameter' => '{watch['case_diameter']}', "
            f"'case_thickness' => '{watch['case_thickness']}', "
            f"'lug_width' => '{watch['lug_width']}', "
            f"'lug_to_lug' => '{watch['lug_to_lug']}', "
            f"'case_material_name_ja' => '{watch['case_material_name_ja']}', "
            f"'strap_material_name_ja' => '{watch['strap_material_name_ja']}', "
            f"'clasp_type_ja' => '{watch['clasp_type_ja']}', "
            f"'dial_color_ja' => '{watch['dial_color_ja']}', "
            f"'crystal_type' => '{watch['crystal_type']}', "
            f"'water_resistance' => '{watch['water_resistance']}', "
            f"'weight' => '{watch['weight']}', "       
            f"'movement_type_name' => '{watch['movement_type_name']}', "
            f"'caliber' => '{watch['caliber']}', "
            f"'power_reserve' => '{watch['power_reserve']}', "
            f"'date_display' => '{watch['date_display']}', "
            f"'chronograph' => '{watch['chronograph']}', "
            f"'GMT_function' => '{watch['GMT_function']}',"
            f"'small_second' => '{watch['small_second']}'],\n"
        )

# 全てのデータを表示
# for watch in watch_data:
#     print(
#         f"モデル名: {watch['name']}, モデルナンバー: {watch['reference_number']}, 防水性能: {watch['water_resistance']}, "
#         f"ムーヴメント: {watch['movement_type_id']}, キャリバー: {watch['caliber']}, パワーリザーヴ: {watch['power_reserve']}, "
#         f"価格: {watch['price']}, ケースサイズ: {watch['case_diameter']}, "
#     )
