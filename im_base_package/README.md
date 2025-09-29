这是一个展示如何使用 IM UI 组件库的示例项目。

## 使用 IM UI 主题生成工具

IM UI 包含一个命令行工具，可用于生成自定义主题文件。

### 生成主题文件

#### 1. 生成单个主题

```bash
# 生成蓝色主题
dart run im_base_package:generate_theme "#0078FA" "lib/theme/themes/blue_theme.json"

# 生成绿色主题
dart run im_base_package:generate_theme "#34C759" "lib/theme/themes/green_theme.json"

# 生成紫色主题
dart run im_base_package:generate_theme "#AF52DE" "lib/theme/themes/purple_theme.json"
```

#### 2. 交互式生成主题

```bash
dart run im_base_package:generate_theme
```

然后按照提示输入主色调和输出路径。

### 主题文件说明

生成的主题文件包含以下颜色分类：

1. **品牌色系列** (`brand1`-`brand6`) - 基于主色调生成的一系列品牌颜色
2. **文字色系列** (`text1`-`text6`) - 各种场景下的文字颜色
3. **填充/边框色系列** (`fill1`-`fill7`) - 用于背景、边框等的填充颜色
4. **功能色系列** - 成功、警告、错误等状态颜色


### 主题使用
```dart
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// 主题
  late IMThemeData _themeData;

  @override
  void initState() {
    super.initState();
    _themeData = IMThemeData.defaultData();
  }

  /// 切换主题
  void _changeTheme(IMThemeData theme) {
    setState(() {
      _themeData = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 使用多套主题
    IMTheme.needMultiTheme();
    return MaterialApp(
      // 初始化主题
      theme: ThemeData(
        extensions: [_themeData],
        colorScheme: ColorScheme.light(primary: _themeData.brand1),
      ),
    );
  }
}

 // 从assets文件中读取JSON
  Future<void> loadThemeFromAssets(
    BuildContext context,
    String themeName,
  ) async {
    try {
      // 加载主题文件
      String themeJson = await rootBundle.loadString(
        'assets/themes/${themeName}_theme.json',
      );
      IMThemeData? theme = IMThemeData.fromJson('default', themeJson);
      if (theme != null) {
        _changeTheme(theme);
      } else {
        print('解析主题文件失败: $themeName');
      }
    } catch (e) {
      print('加载主题失败: $themeName, 错误信息: ${e.toString()}');
    }
  }

/// 使用主题色
IMTheme.of(context).brand6
```

### 使用多语言
```dart
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  /// 初始化语言
  Locale _locale = const Locale('zh', 'CN');

  /// 切换语言
  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 多语言
      localizationsDelegates: [
        ...ImUiLocalizations.localizationsDelegates,
        //TODO 这里添加自己的多语言
        YourLocaleName.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: ImUiLocalizations.supportedLocales,
      locale: _locale,
    );
  }
}

/// 使用组件的多语言
ImUiLocalizations.of(context).loading

/// 使用自己的多语言
YourLocaleName.of(context).xxx
```
当前支持中文,中文(繁体),英文,日语,土耳其语,高棉语. 如果没有默认使用英文