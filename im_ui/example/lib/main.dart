import 'package:flutter/material.dart';
import 'package:im_ui/im_ui.dart';
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

  void _changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 使用多套主题
    IMTheme.needMultiTheme();
    return MaterialApp(
      title: 'UI Component',
      // 初始化国际化 (添加语言后使用 flutter gen-l10n 更多语言)
      localizationsDelegates: ImUiLocalizations.localizationsDelegates,
      supportedLocales: ImUiLocalizations.supportedLocales,
      locale: _locale,
      // 初始化主题
      theme: ThemeData(
        extensions: [_themeData],
        colorScheme: ColorScheme.light(primary: _themeData.brandNormalColor),
      ),
      // 初始化路由
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: RouterName.home,
      home: MyHomePage(onLanguageChanged: _changeLanguage),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final Function(Locale) onLanguageChanged;
  MyHomePage({super.key,required this.onLanguageChanged});

  /// header
  final List<String> header = ['基础组件', '表单组件', '反馈组件', '导航组件', '其他组件'];

  final List<Map<String, dynamic>> data = [
    {'title': 'button', 'page': RouterName.button},
    {'title': 'loading', 'page': RouterName.loading},
  ];

  /// 语言列表
  final List<Map<String, dynamic>> languages = [
    {'name': '中文(简体)', 'locale': Locale('zh', 'CN')},
    {'name': '中文(繁體)', 'locale': Locale('zh', 'TW')},
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'ខ្មែរ', 'locale': Locale('km', 'KH')},
  ];

  @override
  Widget build(BuildContext context) {
    // 获取当前主题数据
    final theme = IMTheme.of(context);
    final localizations = ImUiLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UI Components',
          style: TextStyle(color: theme.brandColor1),
        ),
        actions: [
          IMButton(
            text: localizations.language,
            type: ButtonType.text,
            textStyle: TextStyle(
              color: theme.brandColor1,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            onTap: () async {
              _showLanguageDrawer(context);
            },
          ),
        ],
        backgroundColor: theme.brandColor7,
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: data.length,
        padding: EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (_, i) => Container(),
        itemBuilder: (_, i) => Padding(
          padding: EdgeInsets.only(top: 10),
          child: IMButton(
            text: data[i]['title'],
            onTap: () => Navigator.of(context).pushNamed(data[i]['page']),
          ),
        ),
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
                    bottom: BorderSide(color: theme.brandColor4, width: 1),
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
                        Navigator.of(context).pop();
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
