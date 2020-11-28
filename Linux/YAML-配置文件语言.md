# YAML 配置文件语言

> * [YAML 语言教程-阮一峰](https://www.ruanyifeng.com/blog/2016/07/yaml.html)

### 基本语法

* 大小写敏感
* 使用缩进表示层级关系
* 缩进时不允许使用 Tab 键，只允许使用空格
* 缩进的空格数不重要，只要相同层级的元素左侧对齐即可
* `#` 表示注释，从这个字符一直到行尾，都会被解析器忽略
* 字符串可以不用引号标注

### 数据结构

* 对象：键值对的集合，又称为映射（mapping）/ 哈希（hashes） / 字典（dictionary）
* 数组：一组按次序排列的值，又称为序列（sequence） / 列表（list）
* 纯量（scalars）：单个的、不可再分的值

### 例子

**`对象`** - `key: value`

``` yaml
person:
    student: xiaoming
    teacher: wang
# 或
person: { student: xiaoming, teacher: wang }
```

**`数组`** -  `- value`（横杠和空格）开头

```yaml
-
    - xiaoming
    - xiaohong
    - wang
# 类似 python 中：[[xiaoming, xiaohong, wang]]
```

**`纯量`**

* 字符串、布尔值、整数、浮点数、Null、时间、日期

```yaml
---
num: 12.23
iftrue: true
# null 用 ~ 表示
isNull: ~
# 时间采用 ISO8601 格式
iso8601: 2001-12-14t21:59:43.10-05:00 
# 使用两个感叹号，强制转换数据类型
e: !!str 123
f: !!str true
```

**`纯量 - 字符串`**

* 字符串默认不是有引号
* 字符串中包含空格或特殊字符，需要使用引号
* 只有单引号可以对特殊字符转义
* 字符串可以使用 `|` 保留换行符，也可以使用 `>` 折叠换行

### 引用

* **`&` 用来建立锚点（`defaults`），`<<` 表示合并到当前数据，`*`  用来引用锚点**

```yaml
- &showell Steve 
- Clark 
- *showell 
# 等价于 python 中
# [ Steve, Clark, Steve	]

&defaults defaults: 
  adapter:  postgres
development:
  database: myapp_development
  <<: *defaults
# 等价于 python 中
# { defaults: { adapter: 'postgres' },
#  development: 
#   { database: 'myapp_development',
#     defaults: { adapter: 'postgres' } } }
```

