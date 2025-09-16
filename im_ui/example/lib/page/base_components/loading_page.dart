import 'package:flutter/material.dart';
import 'package:im_ui/im_ui.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = IMTheme.of(context);
    final localizations = ImUiLocalizations.of(context);
    return Scaffold(
      backgroundColor: theme.brandColor1,
      appBar: AppBar(
        title: const Text('Loading'),
        backgroundColor: theme.brandColor6,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
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
                IMLoading(icon: LoadingIcon.circle),

                // iOS 样式菊花加载指示器
                IMLoading(icon: LoadingIcon.activity, size: 15),

                // 点状加载指示器
                IMLoading(icon: LoadingIcon.point),
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
                  icon: LoadingIcon.circle,
                  text: localizations.loading,
                  axis: Axis.horizontal,
                ),
                IMLoading(icon: LoadingIcon.circle, text: localizations.loading),
                IMLoading(icon: null, text: localizations.loading),
              ],
            ),
            SizedBox(height: 30),
            Wrap(
              spacing: 16,
              runSpacing: 10,
              children: [
                IMLoading(
                  icon: LoadingIcon.activity,
                  size: 10,
                  text: localizations.loading,
                  axis: Axis.horizontal,
                ),
                IMLoading(icon: LoadingIcon.activity, size: 10, text: localizations.loading),
                IMLoading(icon: null, text: localizations.loading),
              ],
            ),
            SizedBox(height: 30),
            Wrap(
              spacing: 16,
              runSpacing: 10,
              children: [
                IMLoading(
                  icon: LoadingIcon.point,
                  text: localizations.loading,
                  axis: Axis.horizontal,
                ),
                IMLoading(icon: LoadingIcon.point, text: localizations.loading),
                IMLoading(icon: null, text: localizations.loading),
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
        ),
      ),
    );
  }
}
