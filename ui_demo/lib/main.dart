import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:im_base_package/im_base_package.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// 主题
  late IMThemeData _themeData;

  Locale _locale = const Locale('zh', 'CN');

  @override
  void initState() {
    super.initState();
    _themeData = IMThemeData.defaultData();
  }

  /// 切换语言
  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
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
      title: 'UI Component',
      // 多语言
      localizationsDelegates: [
        ...ImUiLocalizations.localizationsDelegates,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: ImUiLocalizations.supportedLocales,
      locale: _locale,
      // 初始化主题
      theme: ThemeData(
        extensions: [_themeData],
        colorScheme: ColorScheme.light(primary: _themeData.brand1),
      ),
      // 初始化路由
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: RouterName.home,
      home: MyHomePage(
        onLanguageChanged: _changeLanguage,
        onThemeChanged: _changeTheme,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Function(Locale) onLanguageChanged;

  final Function(IMThemeData) onThemeChanged;

  MyHomePage({
    super.key,
    required this.onLanguageChanged,
    required this.onThemeChanged,
  });

  /// header
  final List<String> header = ['基础组件', '表单组件', '反馈组件', '导航组件', '其他组件'];

  /// 语言列表
  final List<Map<String, dynamic>> languages = [
    {'name': '中文(简体)', 'locale': Locale('zh', 'CN')},
    {'name': '中文(繁體)', 'locale': Locale('zh', 'TW')},
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'ខ្មែរ', 'locale': Locale('km', 'KH')},
    {'name': '言語', 'locale': Locale('ja', 'JP')},
    {'name': 'Dil', 'locale': Locale('tr', 'TR')},
  ];

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
        onThemeChanged(theme);
      } else {
        print('解析主题文件失败: $themeName');
      }
    } catch (e) {
      print('加载主题失败: $themeName, 错误信息: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 获取当前主题数据
    final theme = IMTheme.of(context);
    final localizations = ImUiLocalizations.of(context);
    return Scaffold(
      backgroundColor: IMTheme.of(context).brand6,
      appBar: AppBar(
        title: Text(
          'UI Components',
          style: TextStyle(color: theme.fontGyColor6),
        ),
        backgroundColor: IMTheme.of(context).brand1,
        actions: [
          IMButton(
            text: localizations.language,
            type: IMButtonType.text,
            style: IMButtonStyle.text(textColor: theme.fontGyColor6),
            onTap: () async {
              _showLanguageDrawer(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title('切换主题'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IMButton(
                  text: '默认主题',
                  style: IMButtonStyle(backgroundColor: Color(0xFF007AFF)),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  onTap: () {
                    onThemeChanged(IMThemeData.defaultData());
                  },
                ),
                IMButton(
                  text: '红色主题',
                  style: IMButtonStyle(backgroundColor: Color(0xFFF44336)),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  onTap: () => loadThemeFromAssets(context, 'red'),
                ),
                IMButton(
                  text: '紫色主题',
                  style: IMButtonStyle(backgroundColor: Color(0xFF7B1FA2)),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  onTap: () => loadThemeFromAssets(context, 'purple'),
                ),
              ],
            ),
            title('基础组件'),
            IMButton(
              text: '按钮组件',
              onTap: () => Navigator.of(context).pushNamed(RouterName.button),
            ),
            IMButton(
              text: '加载组件',
              onTap: () => Navigator.of(context).pushNamed(RouterName.loading),
            ),
            title('记录列表'),
            IMButton(
              text: '基础列表',
              onTap: () => Navigator.of(context).pushNamed(RouterName.baseList),
            ),
            IMButton(
              text: '加载列表',
              onTap: () => Navigator.of(context).pushNamed(RouterName.loadingList),
            ),
            IMButton(
              text: '索引列表',
              onTap: () => Navigator.of(context).pushNamed(RouterName.indexList),
            ),
          ],
        ),
      ),
    );
  }

  Widget title(String title) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showLanguageDrawer(BuildContext context) {
    final theme = IMTheme.of(context);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: theme.fontGyColor1, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '选择语言',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(languages[index]['name']),
                      onTap: () {
                        onLanguageChanged(languages[index]['locale']);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
