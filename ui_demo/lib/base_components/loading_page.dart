import 'package:flutter/material.dart';
import 'package:im_base_package/im_base_package.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = IMTheme.of(context);
    final localizations = ImUiLocalizations.of(context);
    return Scaffold(
      backgroundColor: theme.brand6,
      appBar: AppBar(
        title: const Text('Loading'),
        backgroundColor: theme.brand1,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '组件类型',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 10,
              children: [
                // Android 样式圆形加载指示器
                IMLoading(iconType: LoadingStyle.circle),

                // iOS 样式菊花加载指示器
                IMLoading(iconType: LoadingStyle.activity, size: 15),

                // 点状加载指示器
                IMLoading(iconType: LoadingStyle.point),
              ],
            ),
            SizedBox(height: 30),
            Text(
              '带有文字',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 10,
              children: [
                IMLoading(
                  iconType: LoadingStyle.circle,
                  text: localizations.loading,
                  axis: Axis.horizontal,
                ),
                IMLoading(iconType: LoadingStyle.circle, text: localizations.loading),
                IMLoading(iconType: null, text: localizations.loading),
              ],
            ),
            SizedBox(height: 30),
            Wrap(
              spacing: 16,
              runSpacing: 10,
              children: [
                IMLoading(
                  iconType: LoadingStyle.activity,
                  size: 10,
                  text: localizations.loading,
                  axis: Axis.horizontal,
                ),
                IMLoading(iconType: LoadingStyle.activity, size: 10, text: localizations.loading),
                IMLoading(iconType: null, text: localizations.loading),
              ],
            ),
            SizedBox(height: 30),
            Wrap(
              spacing: 16,
              runSpacing: 10,
              children: [
                IMLoading(
                  iconType: LoadingStyle.point,
                  text: localizations.loading,
                  axis: Axis.horizontal,
                ),
                IMLoading(iconType: LoadingStyle.point, text: localizations.loading),
                IMLoading(iconType: null, text: localizations.loading),
              ],
            ),
            SizedBox(height: 30),
            Text(
              '自定义',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 16,
              runSpacing: 10,
              children: [
                IMLoading(iconColor: Colors.red),
                IMLoading(
                  text: localizations.loading,
                  textStyle: TextStyle(color: Colors.red),
                ),
                IMLoading(customIcon: Icon(Icons.error), text: localizations.loading),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
