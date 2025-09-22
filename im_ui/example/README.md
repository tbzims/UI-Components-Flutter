# IM UI Example

这是一个展示如何使用 IM UI 组件库的示例项目。

## 使用 IM UI 主题生成工具

IM UI 包含一个命令行工具，可用于生成自定义主题文件。

### 生成主题文件

#### 1. 生成单个主题

```bash
# 生成蓝色主题
dart run im_ui:generate_theme "#0078FA" "lib/theme/themes/blue_theme.json"

# 生成绿色主题
dart run im_ui:generate_theme "#34C759" "lib/theme/themes/green_theme.json"

# 生成紫色主题
dart run im_ui:generate_theme "#AF52DE" "lib/theme/themes/purple_theme.json"
```

#### 2. 交互式生成主题

```bash
dart run im_ui:generate_theme
```

然后按照提示输入主色调和输出路径。

### 在代码中使用主题

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:im_ui/im_ui.dart';

class ThemeExample extends StatefulWidget {
  @override
  _ThemeExampleState createState() => _ThemeExampleState();
}

class _ThemeExampleState extends State<ThemeExample> {
  IMThemeData? _themeData;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    try {
      // 加载主题文件
      String themeJson = await rootBundle.loadString('lib/theme/themes/blue_theme.json');
      setState(() {
        _themeData = IMThemeData.fromJson('default', themeJson);
      });
    } catch (e) {
      print('加载主题失败: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_themeData == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return IMTheme(
      data: _themeData!,
      child: Scaffold(
        appBar: AppBar(
          title: Text('主题示例'),
        ),
        body: Center(
          child: Text(
            '这是使用生成主题的示例',
            style: _themeData!.ofFont('fontBodyLarge')?.toTextStyle(
              color: _themeData!.ofColor('text1'),
            ),
          ),
        ),
      ),
    );
  }
}
```

### 主题文件说明

生成的主题文件包含以下颜色分类：

1. **品牌色系列** (`brand1`-`brand6`) - 基于主色调生成的一系列品牌颜色
2. **文字色系列** (`text1`-`text6`) - 各种场景下的文字颜色
3. **填充/边框色系列** (`fill1`-`fill7`) - 用于背景、边框等的填充颜色
4. **功能色系列** - 成功、警告、错误等状态颜色

这些颜色可以直接通过 `IMThemeData.ofColor()` 方法获取使用。