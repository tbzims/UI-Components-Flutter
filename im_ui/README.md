# IM UI 组件库

一个 Flutter UI 组件库，包含丰富的 UI 组件和主题系统。

## 主题生成工具

IM UI 提供了一个命令行工具，用于生成自定义主题的 JSON 文件。

### 在外部项目中使用

#### 1. 添加依赖

在您的 `pubspec.yaml` 文件中添加 im_ui 依赖：

```yaml
dependencies:
  im_ui: ^0.0.1
  # 或者如果从本地路径引用
  # im_ui:
  #   path: ../path/to/im_ui
```

#### 2. 使用命令行工具生成主题

##### 方法一：使用完整的包名（推荐）

```bash
dart run im_ui:generate_theme "#623ED8" "assets/themes/purple_theme.json"
```

##### 方法二：交互式生成

```bash
dart run im_ui:generate_theme
```

然后按照提示输入主色调和输出路径。

#### 3. 在代码中使用生成的主题

```dart
import 'package:im_ui/im_ui.dart';

// 加载主题文件
String themeJson = await rootBundle.loadString('assets/themes/purple_theme.json');
IMThemeData themeData = IMThemeData.fromJson('default', themeJson);

// 应用主题
IMTheme(
  data: themeData,
  child: MyApp(),
);
```

### 命令行工具参数

```bash
# 生成单个主题文件
dart run im_ui:generate_theme <主色> <输出路径>

# 交互式生成主题
dart run im_ui:generate_theme
```

示例：
```bash
dart run im_ui:generate_theme "#0078FA" "assets/themes/blue_theme.json"
dart run im_ui:generate_theme "#34C759" "assets/themes/green_theme.json"
```

### 主题文件结构

生成的主题文件包含以下颜色定义：

- 品牌色系列 (brand1-brand6)
- 文字色系列 (text1-text6)
- 填充/边框色系列 (fill1-fill7)
- 功能色系列 (normal, success, warning, error)

这些颜色可以直接在 IM UI 组件中使用。