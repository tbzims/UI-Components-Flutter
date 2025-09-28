import 'package:flutter/material.dart';
import 'package:im_base_package/im_base_package.dart';

import 'router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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

  final List<Map<String, dynamic>> data = [
    {'title': '基础列表', 'page': RouterName.base},
    {'title': '刷新列表', 'page': RouterName.loading},
    {'title': '索引列表', 'page': RouterName.index},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'IM 记录列表组件示例',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        padding: EdgeInsets.symmetric(horizontal: 20),
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
