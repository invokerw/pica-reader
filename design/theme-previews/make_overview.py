# -*- coding: utf-8 -*-
"""Compose a single contact sheet (00-overview.png) from the six theme previews."""
from PIL import Image, ImageDraw, ImageFont

BASE = r"C:\Users\weife\Desktop\work\picacg\design\theme-previews"
F_BOLD = r"C:\Windows\Fonts\msyhbd.ttc"
F_REG = r"C:\Windows\Fonts\msyh.ttc"

THEMES = [
    ("01-sakura.png", "01", "樱花粉", "SAKURA", "#E0537B"),
    ("02-ink-and-vermilion.png", "02", "墨水夜", "INK", "#C0342C"),
    ("03-glacier.png", "03", "海盐蓝", "GLACIER", "#2E6FB7"),
    ("04-sepia-paper.png", "04", "旧纸页", "SEPIA", "#96632F"),
    ("05-aurora.png", "05", "极光紫", "AURORA", "#6B4BE0"),
    ("06-moss.png", "06", "苔绿", "MOSS", "#45704F"),
]

S = 2                  # previews are rendered at 2x logical size
LIGHT_BOX = (72, 288, 848, 1866)
DARK_BOX = (932, 288, 1708, 1866)
SCALE = 0.24

b = lambda pt: ImageFont.truetype(F_BOLD, pt)
r = lambda pt: ImageFont.truetype(F_REG, pt)

phone_w = int((LIGHT_BOX[2] - LIGHT_BOX[0]) * SCALE)
phone_h = int((LIGHT_BOX[3] - LIGHT_BOX[1]) * SCALE)

COLS, PAD, GAP = 3, 44, 26
col_w = phone_w * 2 + 14
head_h = 76
row_h = head_h + phone_h + 26
W = PAD * 2 + COLS * col_w + (COLS - 1) * GAP
H = 108 + 2 * row_h + 20

sheet = Image.new("RGB", (W, H), (13, 14, 17))
d = ImageDraw.Draw(sheet)

# soft top glow
for i in range(220):
    a = int(20 * (1 - i / 220))
    d.line([(0, i), (W, i)], fill=(13 + a, 14 + a, 17 + a // 2))

d.text((PAD, 30), "哔咔阅读器 · 主题方案", font=b(30), fill=(242, 240, 244))
d.text((PAD + b(30).getbbox("哔咔阅读器 · 主题方案")[2] + 16, 40),
       "6 sets · each with a day / night palette", font=r(16), fill=(126, 126, 134))
sub = "每套都是完整配色：日间 + 夜间，切换即时生效"
w = r(15).getbbox(sub)[2]
d.text((W - PAD - w, 44), sub, font=r(15), fill=(122, 122, 130))

for idx, (fname, num, cn, en, hexcol) in enumerate(THEMES):
    src = Image.open(f"{BASE}\\{fname}")
    cx = PAD + (idx % COLS) * (col_w + GAP)
    cy = 108 + (idx // COLS) * row_h

    accent = tuple(int(hexcol[i:i + 2], 16) for i in (1, 3, 5))
    d.rounded_rectangle([cx, cy + 4, cx + 34, cy + 38], 10, fill=accent)
    nw = b(15).getbbox(num)[2]
    d.text((cx + 17 - nw / 2, cy + 15), num, font=b(15), fill=(255, 255, 255))
    d.text((cx + 46, cy + 2), cn, font=b(21), fill=(240, 238, 242))
    cw = b(21).getbbox(cn)[2]
    d.text((cx + 46 + cw + 9, cy + 10), en, font=r(13), fill=(128, 128, 136))

    for j, box in enumerate((LIGHT_BOX, DARK_BOX)):
        crop = src.crop(box).resize((phone_w, phone_h), Image.LANCZOS)
        sheet.paste(crop, (cx + j * (phone_w + 14), cy + head_h))

    d.text((cx, cy + head_h + phone_h + 4), "日间", font=r(12), fill=(120, 120, 128))
    d.text((cx + phone_w + 14, cy + head_h + phone_h + 4), "夜间",
           font=r(12), fill=(120, 120, 128))

out = f"{BASE}\\00-overview.png"
sheet.save(out, quality=95)
print(out, sheet.size)
