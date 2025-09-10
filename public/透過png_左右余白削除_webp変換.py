import os
from PIL import Image
from pathlib import Path

def trim_background(image: Image.Image, bg_color=(255, 255, 255), tol=10) -> Image.Image:
    """
    透明部分 + 白背景（近似色も含む）を削除してトリミング
    bg_color: 背景とみなす色 (デフォルト白)
    tol: 許容誤差（10なら 245〜255 なども白と判定）
    """
    if image.mode != 'RGBA':
        image = image.convert('RGBA')

    data = image.getdata()
    width, height = image.size

    def is_bg(px):
        r, g, b, a = px
        if a == 0:  # 完全透明
            return True
        return (abs(r - bg_color[0]) <= tol and
                abs(g - bg_color[1]) <= tol and
                abs(b - bg_color[2]) <= tol)

    # 上下左右を走査
    top, left, right, bottom = 0, 0, width - 1, height - 1

    for y in range(height):
        if not all(is_bg(data[y * width + x]) for x in range(width)):
            top = y
            break

    for y in reversed(range(height)):
        if not all(is_bg(data[y * width + x]) for x in range(width)):
            bottom = y
            break

    for x in range(width):
        if not all(is_bg(data[y * width + x]) for y in range(height)):
            left = x
            break

    for x in reversed(range(width)):
        if not all(is_bg(data[y * width + x]) for y in range(height)):
            right = x
            break

    return image.crop((left, top, right + 1, bottom + 1))

def trim_transparent_only(image: Image.Image) -> Image.Image:
    if image.mode != 'RGBA':
        image = image.convert('RGBA')
    # alphaチャンネルを取得
    alpha = image.split()[-1]
    bbox = alpha.getbbox() 
    if bbox:
        return image.crop(bbox)
    return image


def trim_transparent_with_threshold(image: Image.Image, alpha_threshold=10) -> Image.Image:
    if image.mode != 'RGBA':
        image = image.convert('RGBA')
    alpha = image.split()[-1]
    # alpha > threshold の領域をbboxで取得
    bbox = alpha.point(lambda a: 255 if a > alpha_threshold else 0).getbbox()
    if bbox:
        return image.crop(bbox)
    return image



def process_folder(input_folder: str, output_folder: str):
    input_path = Path(input_folder)
    output_path = Path(output_folder)
    output_path.mkdir(parents=True, exist_ok=True)

    supported_exts = ["*.png", "*.jpg", "*.jpeg", "*.avif"]

    for ext in supported_exts:
        for file in input_path.glob(ext):
            try:
                with Image.open(file) as img:
                    trimmed_img = trim_background(img, bg_color=(255, 255, 255), tol=10)
                    # trimmed_img = trim_transparent_with_threshold(img, alpha_threshold=10)
                    output_filename = file.with_suffix('.webp').name
                    output_file_path = output_path / output_filename
                    trimmed_img.save(output_file_path, format='WEBP', lossless=True)
                    print(f"✅ Converted: {file.name} → {output_filename}")
            except Exception as e:
                print(f"❌ Failed: {file.name} ({e})")


if __name__ == "__main__":
    import tkinter as tk
    from tkinter import filedialog

    root = tk.Tk()
    root.withdraw()

    print("📂 入力フォルダを選択してください（PNG/JPG）")
    input_folder = filedialog.askdirectory()
    print("💾 出力フォルダを選択してください（WebP保存先）")
    output_folder = filedialog.askdirectory()

    if input_folder and output_folder:
        process_folder(input_folder, output_folder)
        print("変換が完了しました。")
    else:
        print("❗フォルダが選択されていません。")
