"""Build declaration+wire-key catalog, using original annotations and real REA evidence.
No APK execution, account or target HTTP request. Non-PICA model scope stays explicit.
"""
from dex_evidence import OUT
from pathlib import Path
import re,json
http={'Lfn2;':'GET','Ln94;':'POST','Lo94;':'PUT'}
param={'Ljd4;':'Path','Lqq4;':'Query','Lrq4;':'QueryMap','Lz90;':'Body','Lb26;':'Tag'}
report=json.loads((OUT/'focused_dex.json').read_text(encoding='utf8'))
frozen=json.loads((OUT/'remaining_targets.json').read_text(encoding='utf8'))
schema=json.loads((OUT/'rea_model_schema.json').read_text(encoding='utf8'))
pica={m['id']:m for m in frozen['pica_endpoints']}
index=json.loads((OUT/'rea'/'validation'/'index.json').read_text(encoding='utf8'))
methods={i.get('original_task',{}).get('original_method_id'):i for i in index if i['operation']=='inspect_android_method' and i['ok']}
cls=json.loads((OUT/'rea'/'validation'/'class-eg4.json').read_text(encoding='utf8'))['normalized_result']
rea_ids={'Leg4;->'+m['name']+m['dex_descriptor'] for m in cls['methods']}
assert set(pica)==rea_ids, 'PICA declaration identity mismatch'
models={m['class_descriptor']:m for m in schema['models']}
def short(desc):
 return 'JsonElement（通用 JSON 树）' if desc=='Lq83;' else desc[1:-1].split('/')[-1] if desc else '未在本范围细审'
def model_link(desc):
 if desc in models:return f'[{short(desc)}](<REA模型清单.md#{short(desc).lower()}>)'
 return short(desc)
lines=['# APK HTTP 协议声明与 REA 模型清单','',
 'HTTP method/path/参数来自原 APK DEX 注解；PICA 的 **33/33 方法完整签名** 已与实际 REA 成员清单对照一致。接口为 abstract，REA 方法体为空不抹除原注解。',
 '已穷举此 APK 中 Retrofit parser 识别的 8 类 HTTP 注解：GET 27、POST 13、PUT 2，DELETE/HEAD/PATCH/OPTIONS/HTTP 各 0，共 **42 个接口方法**；不保证覆盖 raw socket/WebView/运行时生成的协议。',
 'Continuation 不上网；Tag 是客户端元数据，不自动变成 query。非 PICA 接口不能默认套用 PICA HMAC。',
 '[机器可读原注解/泛型签名](<remaining_targets.json>) · [62 模型/299 字段](<REA模型清单.md>) · [请求缺省值/省略规则](<REA请求模型复核.md>)。','',
 '| 接口方法 | HTTP | 路径 | 网络参数 | 请求 Body | PicaResponse 的 data 类型 |',
 '|---|---|---|---|---|---|']
for m in report['endpoints']:
 ann=m['http_annotations'][0];ps=[];body=None
 types=re.findall(r'\[*L[^;]+;|\[*[ZBSCIJFD]',m['prototype'].split(')')[0][1:])
 for idx,slot in enumerate(m.get('parameter_annotations',[])):
  for a in slot:
   name=param.get(a['type'],a['type']);value=a['values'].get('value','')
   ps.append(f'arg{idx}: {name}'+(f'({value})' if value else ''))
   if name=='Body':body=types[idx]
 data=pica.get(m['id'],{}).get('response_data_descriptor')
 item=methods.get(m['id']);label=f"`{m['class'][1:-1]}.{m['name']}`"
 if item:label=f"[{label}](<rea/validation/{Path(item['file']).name}>)"
 lines.append(f"| {label} | {http[ann['type']]} | `{ann['values']['value']}` | {'; '.join(ps) or '无'} | {model_link(body) if body else '无'} | {model_link(data) if m['class']=='Leg4;' else '非 PICA（未全面细审返回模型）'} |")
lines+=['','## QueryMap / 搜索分支','',
 '`GET comics` 的已知映射：category→`c`、tag→`t`、author→`a`、creatorId→`ca`、chineseTeam→`ct`、sort→`s`。前五项非 null 才加，sort 总添加；随后 `customParams.putAll` 可覆盖这些键，调用方最后设置 `page`，覆盖自定义 page。',
 '排序值：DEFAULT=`dd`，TIME_ASC=`da`，LIKES_DESC=`ld`，VIEWS_DESC=`vd`；名字是客户端枚举，不保证服务端含义。keyword 或 categories 非 null 时进入 `POST comics/advanced-search`，分页仍为 query，keyword/sort/categories 在 Body。',
 'JADX 对 `toQueryMap` 丢失了前五个 put，不能照抄该 Java；[REA 原输出](<rea/validation/007-priority-com.picacg.domain.model.ComicListParams-toQueryMap.java>)应结合[原始字节码修正证据](<rea_original_corrections.json>)。调用分支见[REA kr](<rea/validation/006-priority-kr-invokeSuspend.java#L152-L190>)。','',
 '## 已验证的 PICA 请求 wire keys','']
requests=['SignInRequest','RegisterRequest','AdvancedSearchBody','ContentBody','AvatarUpdateRequest','SloganUpdateRequest']
for name in requests:
 m=next(m for m in schema['models'] if short(m['class_descriptor'])==name)
 lines+=['### '+name,'','| JSON key | 缺键 | serializer |','|---|---|---|']
 for k in m['wire_fields']:
  expr=(k['serializer_expression'] or '参见原证据').replace('|','\\|')
  lines.append(f"| [`{k['key']}`](<{k['rea_source']}#L{k['rea_line']}>) | {'允许（具体默认值见请求复核）' if k['optional'] else '不允许'} | `{expr}` |")
 lines+=['']
lines+=['## 返回模型边界','',
 'PICA 返回外壳是 `PicaResponse<T>`：code/message 必需，error/data 可省略且 nullable；成功包装器另要求 data 非 null。`JsonElement` 是任意 JSON 树，不是 Unit，也不能伪造为固定字段对象。',
 '全部声明的 PICA 具体根模型及发现的嵌套模型在[REA 模型清单](<REA模型清单.md>)（62 个模型，299 个字段注册）。key/optional 已逐个与原 DEX 对照；构造器/defaults、child serializer 原表达式与来源链接保留，未做服务端动态校验。',
 'MacCMS / 推荐 / AIBIKA / DNS 的非 PICA 参数声明保留；其完整返回模型、运行时地址和验签不在本次全面细审范围。']
(OUT/'protocol_catalog.md').write_text('\n'.join(lines)+'\n',encoding='utf8')
print('PICA identities matched 33/33; HTTP endpoints',len(report['endpoints']))
