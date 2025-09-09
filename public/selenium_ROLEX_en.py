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


# 使用するブラウザのドライバを設定 (Chromeの場合)
driver = webdriver.Chrome()

# シリーズの一覧ページにアクセス
driver.get("https://www.rolex.com/watches/find-rolex?family=1908")

# 指定のリンクがすべて表示されるまで待機
WebDriverWait(driver, 10).until(
    EC.presence_of_all_elements_located((By.XPATH, "//a[starts-with(@href, '/watches/1908/')]"))
)

# 始まるリンクを全て取得
product_links = driver.find_elements(By.XPATH, "//a[starts-with(@href, '/watches/1908/')]")

# リンクのURLをリストに保存
links = [link.get_attribute('href') for link in product_links]
print(links)

# データを格納するリストを準備
watch_data = []

# brandname
brand_name = "ROLEX"

# 要素の有り無しを確認する関数
def is_element_present(driver, xpath, timeout=1):
    try:
        # 指定された時間内に要素が存在するか確認
        WebDriverWait(driver, timeout).until(
            EC.presence_of_element_located((By.XPATH, xpath))
        )
        return '1'  # 要素が存在した場合
    except TimeoutException:
        return '0'  # 要素が存在しない場合

# 各リンクにアクセスして情報を取得
for link in links:
    # ページにアクセス
    driver.get(link)
    
    try:
        # 要素が表示されるまで最大10秒待機 (要素が表示されたら取得)
        model_name = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, '/html/body/div[1]/div/main/header/div/div[2]/hgroup/h1/p[1]'))
        ).text

        model_number = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, '//*[@id="root"]/div/main/header/div/div[2]/hgroup/h1/p[3]'))
        ).text

        waterproof = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//h5[text()='Water resistance']/following-sibling::p[1]"))
        ).text

        movement_type = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//h5[text()='Movement']/following-sibling::p[1]"))
        ).text

        calibre = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//h5[text()='Calibre']/following-sibling::p[1]"))
        ).text

        power_reserve = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//h5[text()='Power reserve']/following-sibling::p[1]"))
        ).text

        case_size = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//h5[text()='Diameter']/following-sibling::p[1]"))
        ).text

        case_material = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "(//h5[text()='Material']/following-sibling::p[1])[1]"))
        ).text

        bracelet_material = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "(//h5[text()='Material']/following-sibling::p[1])[2]"))
        ).text
        
        dial_colour = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, "//h5[text()='Dial']/following-sibling::p[1]"))
        ).text

        price = WebDriverWait(driver, 10).until(
            EC.presence_of_element_located((By.XPATH, '/html/body/div[1]/div/main/header/div/div[2]/p/span'))
        ).text

        # 日付の有無を確認
        date_display = is_element_present(driver, "//h5[text()='Functions']")

        # クロノグラフの有無を確認
        chronograph = is_element_present(driver, "//p[contains(text(), 'mechanical chronograph')]")

        # GMTの有無を確認
        GMT_function = is_element_present(driver, "//p[contains(text(), 'GMT')]")

        # 登録日
        registration_date = datetime.today().strftime('%Y-%m-%d')



        # 特定の文字列抽出関数
        def extract_specific_strings(input_string, target_strings):
            extracted_strings = []
            for target_string in target_strings:
                if target_string in input_string:
                    extracted_strings.append(target_string)
            
            # 抽出結果を結合して単一の文字列として返す
            return ', '.join(extracted_strings) if extracted_strings else ''  # マッチがなければ空文字を返す
        
        # 防水性能抽出
        target_string = ["100 metres", "150 metres", "300 metres", "1,220 metres", "3,900 metres", "11,000 metres"]
        input_string = waterproof
        waterproof2 = extract_specific_strings(input_string, target_string)

        # ムーヴメント抽出
        target_string = ["self-winding", "手巻", "クオーツ"]
        input_string = movement_type
        movement_type = extract_specific_strings(input_string, target_string)

        # 文字間の削除(, yen space)する関数
        def remove_commas_and_spaces(input_string):
            cleaned_string = input_string.replace(',', '').replace(' ', '').replace('¥', '')
            return cleaned_string
        
        # 値段整理
        price2 = remove_commas_and_spaces(price)


        # 正規表現で半角英数字を抽出
        def extract_alphanumeric(input_string):
            alphanumeric_string = re.sub(r'[^a-zA-Z0-9]', '', input_string)
            return alphanumeric_string


        # 正規表現で半角数字のみを抽出
        def extract_numeric(input_string):
            numeric_string = re.sub(r'[^0-9]', '', input_string)
            return numeric_string
        
        # 防水性能抽出
        water_resistance = extract_numeric(waterproof2)
        # パワーリザーブ抽出
        power_reserve = extract_numeric(power_reserve)
        # ケースサイズ抽出
        case_size = extract_numeric(case_size)
        # キャリバー抽出
        calibre = extract_numeric(calibre)

        # 型番変換
        def replace_reference_number(text):
            return text.replace("Reference ", "")
        
        model_number = replace_reference_number(model_number)
        




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
        base_url = "https://media.rolex.com/image/upload/q_auto:eco/f_auto/t_v7-majesty/c_limit,w_2440/v1/catalogue/2024/upright-c/"
        image_url = f"{base_url}{suffix}"
        print(image_url)

        # 画像を取得
        response = requests.get(image_url)
        response.raise_for_status()  # エラーチェック

        # 画像を開き、PNG形式で保存
        try:
            img = Image.open(BytesIO(response.content))

            # 保存場所を指定
            save_path = "C:\\Users\\naoki\\Desktop\\scraping\\img\\rolex"  # ここに保存したいフォルダのパスを指定
            os.makedirs(save_path, exist_ok=True)  # フォルダが存在しない場合は作成

            # PNG形式で保存
            file_path = os.path.join(save_path, f"{brand_name}_{model_number}_{suffix}.png")  # suffixをファイル名として使用
            img.save(file_path, format="PNG")
            print(f"画像が{file_path}として保存されました")

        except Exception as e:
            print(f"画像の保存中にエラーが発生しました: {e}")


        watch_data.append({
            'brand_name': brand_name,
            'model_name': model_name,
            'model_number': model_number,
            'water_resistance': water_resistance,
            'movement_type': movement_type,
            'calibre': calibre,
            'power_reserve': power_reserve,
            'case_size': case_size,
            'case_material' : case_material,
            'bracelet_material' : bracelet_material,
            'dial_colour' : dial_colour,
            'date_display': date_display,
            'chronograph' : chronograph,
            'GMT_function' : GMT_function,
            'img_path' : suffix,
            'price': price2,
            'registration_date' : registration_date
        })
    
    except TimeoutException:
        print(f"情報の取得に失敗: {link}")
        continue

with open('C:\\Users\\naoki\\Desktop\\scraping\\rolex_scraped_data.txt', 'w', encoding='utf-8') as file:
    for watch in watch_data:
        file.write(
            f"INSERT INTO {watch['brand_name']} SET brand_name='{watch['brand_name']}', model_name='{watch['model_name']}', "
            f"model_number='{watch['model_number']}', water_resistance='{watch['water_resistance']}', movement_type='{watch['movement_type']}', "
            f"calibre='{watch['calibre']}', power_reserve='{watch['power_reserve']}', case_size='{watch['case_size']}', "
            f"case_material='{watch['case_material']}', bracelet_material='{watch['bracelet_material']}', "
            f"dial_colour='{watch['dial_colour']}', date_display='{watch['date_display']}', chronograph='{watch['chronograph']}', "
            f"GMT_function='{watch['GMT_function']}', img_path='{watch['img_path']}', price='{watch['price']}', registration_date='{watch['registration_date']}';\n"
        )

# 全てのデータを表示
for watch in watch_data:
    print(
        f"モデル名: {watch['model_name']}, モデルナンバー: {watch['model_number']}, 防水性能: {watch['water_resistance']}, "
        f"ムーヴメント: {watch['movement_type']}, キャリバー: {watch['calibre']}, パワーリザーヴ: {watch['power_reserve']}, "
        f"価格: {watch['price']}, ケースサイズ: {watch['case_size']}, "
    )
