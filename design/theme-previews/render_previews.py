# -*- coding: utf-8 -*-
"""Renders the theme preview sheets (light + dark phone mockups) with Pillow.

The mockups reuse the real app layout: app bar, sort row, category chips,
3-column comic grid and the bottom navigation, so what the sheet shows is what
the Flutter theme will look like.
"""
import math
import os

import numpy as np
from PIL import Image, ImageDraw, ImageFilter, ImageFont

S = 2  # supersampling factor (logical px -> device px)
HERE = os.path.dirname(os.path.abspath(__file__))
FONTS = r"C:\Windows\Fonts"
ICONS = r"C:\Users\weife\Desktop\work\picacg\pica_reader\build\unit_test_assets\fonts\MaterialIcons-Regular.otf"

PAGE_W, PAGE_H = 880, 1052


def p(v):
    return int(round(v * S))


def hx(s):
    s = s.lstrip("#")
    return tuple(int(s[i:i + 2], 16) for i in (0, 2, 4))


def mix(c, other, t):
    return tuple(int(c[i] + (other[i] - c[i]) * t) for i in range(3))


_cache = {}


def font(size, bold=False, mono=False, icon=False, serif=False):
    key = (size, bold, mono, icon, serif)
    if key in _cache:
        return _cache[key]
    px = p(size)
    if icon:
        f = ImageFont.truetype(ICONS, px)
    elif mono:
        f = ImageFont.truetype(os.path.join(FONTS, "consola.ttf"), px)
    elif serif:
        f = ImageFont.truetype(os.path.join(FONTS, "simsun.ttc"), px)
    elif bold:
        f = ImageFont.truetype(os.path.join(FONTS, "msyhbd.ttc"), px)
    else:
        f = ImageFont.truetype(os.path.join(FONTS, "msyh.ttc"), px)
    _cache[key] = f
    return f


def lin_grad(size, c1, c2, angle=158.0):
    w, h = size
    a = math.radians(angle)
    x = np.arange(w, dtype=np.float32)[None, :]
    y = np.arange(h, dtype=np.float32)[:, None]
    t = x * math.cos(a) + y * math.sin(a)
    t = (t - t.min()) / max(t.max() - t.min(), 1e-6)
    arr = np.array(c1, np.float32)[None, None, :] * (1 - t[..., None]) + \
          np.array(c2, np.float32)[None, None, :] * t[..., None]
    return Image.fromarray(arr.astype(np.uint8), "RGB")


def radial(size, color, alpha=0.30, spread=0.52, cx=0.5, cy=0.5):
    w, h = size
    yy, xx = np.mgrid[0:h, 0:w].astype(np.float32)
    d = np.sqrt(((xx - cx * w) / (w * spread)) ** 2 + ((yy - cy * h) / (h * spread)) ** 2)
    a = np.clip(1 - d, 0, 1) ** 2 * alpha
    arr = np.zeros((h, w, 4), np.uint8)
    arr[..., 0], arr[..., 1], arr[..., 2] = color
    arr[..., 3] = (a * 255).astype(np.uint8)
    return Image.fromarray(arr, "RGBA")


def rmask(size, r):
    m = Image.new("L", size, 0)
    ImageDraw.Draw(m).rounded_rectangle([0, 0, size[0] - 1, size[1] - 1], radius=r, fill=255)
    return m


def rot_rect(cx, cy, w, h, deg):
    a = math.radians(deg)
    ca, sa = math.cos(a), math.sin(a)
    return [(cx + dx * ca - dy * sa, cy + dx * sa + dy * ca)
            for dx, dy in ((-w / 2, -h / 2), (w / 2, -h / 2), (w / 2, h / 2), (-w / 2, h / 2))]


class Canvas:
    """Draw helper that takes logical coordinates and scales them."""

    def __init__(self, size):
        self.img = Image.new("RGBA", (p(size[0]), p(size[1])), (0, 0, 0, 0))
        self.d = ImageDraw.Draw(self.img)

    def rect(self, box, fill):
        self.d.rectangle([p(box[0]), p(box[1]), p(box[2]), p(box[3])], fill=fill)

    def rr(self, box, r, fill=None, outline=None, w=1):
        self.d.rounded_rectangle(
            [p(box[0]), p(box[1]), p(box[2]) - 1, p(box[3]) - 1],
            radius=p(r), fill=fill, outline=outline, width=p(w))

    def text(self, xy, s, size, fill, bold=False, anchor="la", mono=False, serif=False):
        self.d.text((p(xy[0]), p(xy[1])), s, font=font(size, bold=bold, mono=mono, serif=serif),
                    fill=fill, anchor=anchor)

    def spaced(self, xy, s, size, fill, gap=1.2, anchor="la"):
        f = font(size)
        widths = [self.d.textlength(ch, font=f) for ch in s]
        total = sum(widths) + p(gap) * (len(s) - 1)
        x, y = p(xy[0]), p(xy[1])
        if anchor.startswith("r"):
            x -= total
        elif anchor.startswith("m"):
            x -= total / 2
        for ch, w in zip(s, widths):
            self.d.text((x, y), ch, font=f, fill=fill, anchor=anchor[0] + anchor[1])
            x += w + p(gap)

    def icon(self, xy, code, size, fill, anchor="mm"):
        self.d.text((p(xy[0]), p(xy[1])), chr(code), font=font(size, icon=True), fill=fill, anchor=anchor)


# ---------------------------------------------------------------- theme data
def tm(name, en, desc, note, radius, light, dark, covers, serif=False):
    return dict(name=name, en=en, desc=desc, note=note, radius=radius, light=light,
                dark=dark, covers=covers, serif=serif)


THEMES = [
    tm("樱花粉", "SAKURA", "延续现在的品牌粉：柔粉 + 奶油白，14px 大圆角",
       "与当前界面最接近", 14,
       dict(surface="#FFF9FB", container="#FBEEF2", card="#FFFFFF", nav="#FFF4F7",
            primary="#E0537B", onPrimary="#FFFFFF", text="#2C1B21", muted="#9A7782",
            border="#F2DDE4", chip="#FBE9EE", chipText="#7C5561"),
       dict(surface="#141013", container="#1E1619", card="#221A1E", nav="#1A1417",
            primary="#F7849F", onPrimary="#2A0B14", text="#F4E7EB", muted="#A48991",
            border="#2C2126", chip="#241B1F", chipText="#C9A9B2"),
       [("#F6B9C9", "#C4456D"), ("#D8C4EC", "#7B5CA9"), ("#F8D6B4", "#C0703F"),
        ("#BDD9E8", "#3E6E8B"), ("#EFC9D9", "#A65A86"), ("#C7E3D4", "#3F7A66")]),
    tm("墨水夜", "INK & VERMILION", "和纸白底 + 朱砂印红，6px 小圆角，标题更硬朗",
       "日式文库本的纸张感", 6,
       dict(surface="#FAF9F4", container="#F1EFE6", card="#FFFFFF", nav="#F7F5EE",
            primary="#C0342C", onPrimary="#FFFFFF", text="#191918", muted="#7E7C74",
            border="#E3E0D5", chip="#F0EDE4", chipText="#5F5D56"),
       dict(surface="#0B0B0C", container="#141416", card="#17171A", nav="#101012",
            primary="#E75A4E", onPrimary="#1A0705", text="#ECEBE6", muted="#8B8983",
            border="#252528", chip="#1B1B1E", chipText="#B4B2AB"),
       [("#D9D3C7", "#2E2C28"), ("#C9BEB0", "#4A3B33"), ("#B9C3CB", "#2C3A44"),
        ("#DCC7BC", "#5B332B"), ("#C3CBC2", "#313D33"), ("#CFC3CB", "#3E2C38")],
       serif=True),
    tm("海盐蓝", "GLACIER", "冷调冰蓝 + 雾面玻璃，14px 圆角，灰阶偏蓝",
       "最干净，接近系统感", 14,
       dict(surface="#F5F9FC", container="#E6EFF7", card="#FFFFFF", nav="#EDF4FA",
            primary="#2E6FB7", onPrimary="#FFFFFF", text="#132030", muted="#71879A",
            border="#DCE8F2", chip="#E8F0F7", chipText="#4C6A85"),
       dict(surface="#0A1117", container="#121C24", card="#16212A", nav="#0E1720",
            primary="#74A9E6", onPrimary="#05131F", text="#DCE7F1", muted="#7F94A4",
            border="#1F2B35", chip="#16212A", chipText="#A6BBCB"),
       [("#BBD4E8", "#2C5677"), ("#A9C6DD", "#1F3B55"), ("#CFE0EE", "#4B7391"),
        ("#A7D2D8", "#28636B"), ("#C3D3E6", "#395A78"), ("#D6E3F0", "#5B7C99")]),
    tm("旧纸页", "SEPIA PAPER", "米黄纸底 + 琥珀棕，衬线标题，8px 圆角",
       "护眼阅读向，久看不刺眼", 8,
       dict(surface="#F5EDDC", container="#EDE1CB", card="#FBF4E6", nav="#F1E7D4",
            primary="#96632F", onPrimary="#FFF8EC", text="#33281B", muted="#88745A",
            border="#E2D4B8", chip="#EDE1CB", chipText="#5E4B34"),
       dict(surface="#16120E", container="#201A14", card="#221B14", nav="#1A150F",
            primary="#D7A462", onPrimary="#2B1D0C", text="#EBE0CC", muted="#95846B",
            border="#2C241A", chip="#221B14", chipText="#C3B196"),
       [("#E6D3B4", "#8A5F33"), ("#D9C7AC", "#6B4B2C"), ("#E9DCC4", "#A57B47"),
        ("#CFC1A6", "#584231"), ("#E3D0B8", "#7A5233"), ("#D6C6AE", "#6A5540")],
       serif=True),
    tm("极光紫", "AURORA", "紫罗兰 + 青色荧光，16px 圆角，主色带渐变",
       "氛围感最强，夜间最出彩", 16,
       dict(surface="#F8F6FE", container="#EFEAFB", card="#FFFFFF", nav="#F2EEFC",
            primary="#6B4BE0", onPrimary="#FFFFFF", text="#1A1630", muted="#7B7391",
            border="#E6E0F7", chip="#EFEAFB", chipText="#574A82"),
       dict(surface="#0C0A14", container="#151126", card="#181330", nav="#100D1D",
            primary="#A78BFA", onPrimary="#100A26", text="#E7E3F6", muted="#8C86A4",
            border="#231C3C", chip="#181330", chipText="#B5ACD6"),
       [("#C0B0F2", "#43298F"), ("#A9C4F5", "#28367E"), ("#D7BFF0", "#5B3390"),
        ("#9FE0E8", "#1D5F6B"), ("#B9AEEF", "#3B2C7C"), ("#D3C4F4", "#614A9E")]),
    tm("苔绿", "MOSS", "低饱和苔绿 + 米白，12px 圆角，整体更安静",
       "不抢封面颜色", 12,
       dict(surface="#F4F7F1", container="#E5EDE2", card="#FFFFFF", nav="#EDF3EA",
            primary="#45704F", onPrimary="#FFFFFF", text="#1B241D", muted="#74806F",
            border="#DCE7D8", chip="#E7EEE3", chipText="#4C5F4E"),
       dict(surface="#0E1410", container="#161F19", card="#18231C", nav="#111A14",
            primary="#8CBE99", onPrimary="#08170D", text="#DDE8DF", muted="#87948B",
            border="#1F2B22", chip="#18231C", chipText="#A9B8AC"),
       [("#C6D8C3", "#3B5F42"), ("#B9CDBB", "#33503B"), ("#D8E2CB", "#57744C"),
        ("#C2CFCD", "#3A5450"), ("#D2DCC2", "#4F6842"), ("#CBD8CE", "#44614C")]),
]

CHIPS = ["全部", "纯爱", "校园", "完结", "治愈", "科幻"]
TITLES = ["月下的她", "夏日限定", "暗恋信号", "夜行列车", "第七封信",
          "薄荷夏天", "深海回声", "放学后的雨", "光与影之间"]
AUTHORS = ["柚木", "佚名", "南川", "白鸟", "佚名", "青叶", "海生", "小林", "佚名"]

ICON_HOME = 0xF7F5
ICON_RANK = 0xF848
ICON_SEARCH = 0xF013D
ICON_ME = 0xF0071
ICON_REFRESH = 0xF00E9


def cover_art(size, pair, radius, badge):
    w, h = p(size[0]), p(size[1])
    img = lin_grad((w, h), hx(pair[0]), hx(pair[1]), 152).convert("RGBA")
    ov = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    d = ImageDraw.Draw(ov)
    r = w * 0.31
    d.ellipse([w * 0.82 - r, h * 0.10 - r, w * 0.82 + r, h * 0.10 + r], fill=(255, 255, 255, 78))
    d.polygon(rot_rect(w * 0.5, h * 0.57, w * 1.6, h * 0.13, -11), fill=(255, 255, 255, 46))
    for i, (bw, op) in enumerate(((0.33, 150), (0.21, 96), (0.27, 62))):
        y = h * 0.78 + i * p(6)
        d.rounded_rectangle([w * 0.12, y, w * (0.12 + bw), y + p(1.6)], radius=p(1), fill=(255, 255, 255, op))
    img = Image.alpha_composite(img, ov)
    if badge:
        b = ImageDraw.Draw(img)
        b.rounded_rectangle([p(6), p(6), p(6) + p(31), p(6) + p(15)], radius=p(4), fill=(0, 0, 0, 150))
        b.text((p(6) + p(15), p(13)), "完结", font=font(9), fill=(255, 255, 255), anchor="mm")
    img.putalpha(rmask((w, h), p(radius)))
    return img


def screen_image(th, p_, dark):
    c = Canvas((362, 762))
    c.rect((0, 0, 362, 762), hx(p_["surface"]))
    text = hx(p_["text"])
    muted = hx(p_["muted"])
    primary = hx(p_["primary"])
    border = hx(p_["border"])

    # status bar
    c.text((16, 13), "21:04", 10.5, text, bold=True, anchor="lm")
    d = c.d
    col = (*text, 210)
    d.rounded_rectangle([p(312), p(10), p(321), p(16)], radius=p(1), fill=col)          # signal block
    d.polygon([(p(325), p(16)), (p(334), p(10)), (p(334), p(16))], fill=col)            # wifi
    d.rounded_rectangle([p(338), p(10), p(354), p(16)], radius=p(2), outline=col, width=p(1))
    d.rectangle([p(340), p(12), p(351), p(14)], fill=col)
    d.rectangle([p(355), p(12), p(356), p(14)], fill=col)

    # app bar
    c.text((18, 50), "哔咔阅读器", 19, text, bold=True, anchor="lm", serif=th["serif"])
    c.icon((344, 50), ICON_REFRESH, 19, muted, anchor="rm")

    # sort row
    c.text((18, 89), "默认排序", 12.5, text, anchor="lm")
    sort_w = c.d.textlength("默认排序", font=font(12.5))
    d.polygon([(p(18) + sort_w + p(5), p(87)), (p(18) + sort_w + p(13), p(87)),
               (p(18) + sort_w + p(9), p(92))], fill=muted)
    c.text((344, 89), "共 1,234 本", 11, muted, anchor="rm")

    # category chips
    x = 18.0
    for i, label in enumerate(CHIPS):
        tw = c.d.textlength(label, font=font(11.5)) / S
        w = tw + 22
        if i == 0:
            c.rr((x, 111, x + w, 135), 12, fill=primary)
            c.text((x + w / 2, 123), label, 11.5, hx(p_["onPrimary"]), anchor="mm")
        else:
            c.rr((x, 111, x + w, 135), 12, fill=hx(p_["chip"]), outline=border, w=1)
            c.text((x + w / 2, 123), label, 11.5, hx(p_["chipText"]), anchor="mm")
        x += w + 7

    # comic grid
    cell_w = (362 - 36 - 18) / 3
    for i in range(9):
        row, col_i = divmod(i, 3)
        cxx = 18 + col_i * (cell_w + 9)
        cyy = 152 + row * 181.6
        art = cover_art((cell_w, cell_w / 0.72), th["covers"][i % len(th["covers"])], th["radius"], i == 2)
        c.img.alpha_composite(art, (p(cxx), p(cyy)))
        c.text((cxx, cyy + cell_w / 0.72 + 5), TITLES[i], 11.5, text, bold=True, anchor="la",
               serif=th["serif"])
        c.text((cxx, cyy + cell_w / 0.72 + 21), AUTHORS[i], 10, muted, anchor="la")

    # bottom navigation
    nav_top = 704
    c.rect((0, nav_top, 362, 762), hx(p_["nav"]))
    d.rectangle([0, p(nav_top), p(362), p(nav_top) + 1], fill=border)
    items = [("首页", ICON_HOME, True), ("排行", ICON_RANK, False),
             ("搜索", ICON_SEARCH, False), ("我的", ICON_ME, False)]
    for i, (label, code, on) in enumerate(items):
        cxx = 362 / 4 * (i + 0.5)
        color = primary if on else muted
        if on:
            c.rr((cxx - 22, nav_top + 4, cxx + 22, nav_top + 30), 13,
                 fill=mix(hx(p_["nav"]), primary, 0.16))
        c.icon((cxx, nav_top + 17), code, 17, color)
        c.text((cxx, nav_top + 41), label, 10, color, bold=on, anchor="mm")

    return c.img


def phone(th, palette, dark):
    c = Canvas((380, 780))
    frame_fill = (26, 29, 35, 255) if dark else (234, 234, 236, 255)
    frame_edge = (43, 47, 55, 255) if dark else (246, 246, 248, 255)
    c.rr((0, 0, 380, 780), 34, fill=frame_fill, outline=frame_edge, w=1)
    c.rr((9, 9, 371, 771), 26, outline=(255, 255, 255, 10) if dark else (0, 0, 0, 10), w=1)
    sc = screen_image(th, palette, dark)
    sc.putalpha(rmask(sc.size, p(26)))
    c.img.alpha_composite(sc, (p(9), p(9)))
    if dark:
        # Opaque rim, pre-blended: the screen layer is masked with putalpha, so a
        # translucent stroke there would lose its alpha and turn pure white.
        c.rr((9.5, 9.5, 370.5, 770.5), 25, outline=mix(hx(palette["surface"]), (255, 255, 255), 0.08) + (255,), w=1)
    return c.img


def render(th, index):
    page = Image.new("RGBA", (p(PAGE_W), p(PAGE_H)), hx("#0A0B0E") + (255,))
    page.alpha_composite(radial((p(PAGE_W), p(PAGE_H)), hx(th["light"]["primary"]), 0.20, 0.75,
                                cx=0.5, cy=0.42))
    page.alpha_composite(radial((p(PAGE_W), p(PAGE_H)), hx(th["dark"]["primary"]), 0.16, 0.5,
                                cx=0.92, cy=0.95))

    c = Canvas((PAGE_W, PAGE_H))
    white = (245, 246, 248, 255)
    grey = (139, 145, 157, 255)
    dim = (110, 116, 128, 255)

    # header
    badge = lin_grad((p(44), p(44)), hx(th["light"]["primary"]), hx(th["dark"]["primary"]), 45)
    badge.putalpha(rmask(badge.size, p(12)))
    page.alpha_composite(badge, (p(40), p(32)))
    c.text((62, 54), f"{index:02d}", 17, (255, 255, 255, 255), bold=True, anchor="mm", mono=True)

    c.text((100, 47), th["name"], 27, white, bold=True, anchor="lm", serif=th["serif"])
    name_w = c.d.textlength(th["name"], font=font(27, bold=True, serif=th["serif"])) / S
    c.spaced((100 + name_w + 10, 50), th["en"], 12, (124, 131, 143, 255), gap=1.4, anchor="lm")

    c.text((100, 80), th["desc"], 12.5, grey, anchor="lm")

    note_f = font(11.5)
    nw = c.d.textlength(th["note"], font=note_f) / S + 24
    c.rr((840 - nw, 40, 840, 68), 14, fill=(23, 26, 32, 255), outline=(38, 42, 51, 255), w=1)
    c.text((840 - nw / 2, 54), th["note"], 11.5, (201, 207, 217, 255), anchor="mm")

    # light / dark captions
    c.d.ellipse([p(40), p(117), p(46), p(123)], fill=(232, 232, 234, 255))
    c.text((54, 122), "日间 Light", 11.5, (201, 207, 217, 255), bold=True, anchor="lm")
    light_w = c.d.textlength("日间 Light", font=font(11.5, bold=True)) / S
    c.text((54 + light_w + 8, 122), "跟随系统", 11.5, dim, anchor="lm")

    c.d.ellipse([p(460), p(117), p(466), p(123)], fill=hx(th["dark"]["primary"]) + (255,))
    c.text((474, 122), "夜间 Dark", 11.5, (201, 207, 217, 255), bold=True, anchor="lm")
    dark_w = c.d.textlength("夜间 Dark", font=font(11.5, bold=True)) / S
    c.text((474 + dark_w + 8, 122), "自动 / 手动切换", 11.5, dim, anchor="lm")

    # phones
    light_phone = phone(th, th["light"], False)
    dark_phone = phone(th, th["dark"], True)
    for ph, x in ((light_phone, 40), (dark_phone, 460)):
        shadow = Image.new("RGBA", ph.size, (0, 0, 0, 0))
        ImageDraw.Draw(shadow).rounded_rectangle(
            [0, 0, ph.size[0] - 1, ph.size[1] - 1], radius=p(34), fill=(0, 0, 0, 165))
        shadow = shadow.filter(ImageFilter.GaussianBlur(p(16)))
        page.alpha_composite(shadow, (p(x), p(148) + p(12)))
        page.alpha_composite(ph, (p(x), p(148)))

    page.alpha_composite(c.img)

    # palette strip
    swatches = [("主色", th["light"]["primary"]), ("日间底", th["light"]["surface"]),
                ("日间卡片", th["light"]["container"]), ("夜间底", th["dark"]["surface"]),
                ("夜间卡片", th["dark"]["card"]), ("夜间主色", th["dark"]["primary"])]
    foot = Canvas((PAGE_W, PAGE_H))
    for i, (label, hexv) in enumerate(swatches):
        x = 40 + i * 135
        y = 964
        foot.rr((x, y, x + 125, y + 56), 11, fill=(18, 21, 26, 255), outline=(33, 37, 44, 255), w=1)
        sw = hx(hexv)
        foot.rr((x + 10, y + 17, x + 32, y + 39), 7, fill=sw + (255,),
                outline=(255, 255, 255, 26), w=1)
        foot.text((x + 41, y + 21), label, 9.5, (154, 161, 173, 255), anchor="lm")
        foot.text((x + 41, y + 37), hexv.upper(), 9.5, (230, 233, 238, 255), anchor="lm", mono=True)
    page.alpha_composite(foot.img)

    return page.convert("RGB")


if __name__ == "__main__":
    for i, th in enumerate(THEMES, start=1):
        img = render(th, i)
        out = os.path.join(HERE, f"{i:02d}-{th['en'].lower().replace(' ', '-').replace('&', 'and')}.png")
        img.save(out, "PNG", optimize=True)
        print(out)
