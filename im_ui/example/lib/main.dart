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

  @override
  void initState() {
    super.initState();
    _themeData = IMThemeData.defaultData();
  }

  @override
  Widget build(BuildContext context) {
    // 使用多套主题
    IMTheme.needMultiTheme();
    return MaterialApp(
      title: 'UI Component',
      // 初始化国际化
      localizationsDelegates: ImUiLocalizations.localizationsDelegates,
      supportedLocales: ImUiLocalizations.supportedLocales,
      locale: const Locale('zh', 'CN'),
      // 初始化主题
      theme: ThemeData(
        extensions: [_themeData],
        colorScheme: ColorScheme.light(primary: _themeData.brandNormalColor),
      ),
      // 初始化路由
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: RouterName.home,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  /// header
  final List<String> header = ['基础组件', '表单组件', '反馈组件', '导航组件', '其他组件'];

  final List<Map<String, dynamic>> data = [
    {'title': 'button', 'page': RouterName.button},
  ];

  @override
  Widget build(BuildContext context) {
    // 获取当前主题数据
    final theme = IMTheme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UI Components',
          style: TextStyle(color: theme.brandColor1),
        ),
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
}
