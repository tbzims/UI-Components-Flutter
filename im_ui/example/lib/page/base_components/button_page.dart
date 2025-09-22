import 'package:flutter/material.dart';
import 'package:im_ui/im_ui.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = IMTheme.of(context);
    return Scaffold(
      backgroundColor: theme.fontGyColor1,
      appBar: AppBar(
        title: const Text('Button'),
        backgroundColor: theme.fontGyColor1,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
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
                  IMButton(
                    text: '默认按钮',
                    type: ButtonType.fill,
                    theme: IMButtonTheme.primary,
                  ),
                  IMButton(
                    text: '描边按钮',
                    type: ButtonType.outline,
                    theme: IMButtonTheme.primary,
                  ),
                  IMButton(
                    text: '文字按钮',
                    type: ButtonType.text,
                    theme: IMButtonTheme.primary,
                  ),
                  IMButton(
                    text: '禁用按钮',
                    type: ButtonType.fill,
                    theme: IMButtonTheme.primary,
                    disabled: true,
                  ),
                  IMButton(
                    text: '加载中按钮',
                    type: ButtonType.fill,
                    width: 110,
                    height: 42,
                    theme: IMButtonTheme.primary,
                    showLoading: true,
                    onTap: () async {
                      await Future.delayed(Duration(seconds: 2));
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                '带有图标的按钮',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 10,
                children: [
                  IMButton(
                    text: '左图标',
                    icon: Icons.apps_outlined,
                    type: ButtonType.fill,
                    theme: IMButtonTheme.primary,
                  ),
                  IMButton(
                    text: '右图标',
                    icon: Icons.apps_outlined,
                    iconPosition: ButtonIconPosition.right,
                    type: ButtonType.fill,
                    theme: IMButtonTheme.primary,
                  ),
                  IMButton(
                    icon: Icons.apps_outlined,
                    type: ButtonType.fill,
                    theme: IMButtonTheme.primary,
                  ),
                  IMButton(
                    text: '上图标',
                    icon: Icons.apps_outlined,
                    type: ButtonType.fill,
                    theme: IMButtonTheme.primary,
                    iconPosition: ButtonIconPosition.top,
                  ),
                  IMButton(
                    text: '下图标',
                    icon: Icons.apps_outlined,
                    type: ButtonType.fill,
                    theme: IMButtonTheme.primary,
                    iconPosition: ButtonIconPosition.bottom,
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                '按钮形状',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 10,
                children: [
                  IMButton(
                    text: '胶囊按钮',
                    type: ButtonType.fill,
                    shape: ButtonShape.round,
                    theme: IMButtonTheme.primary,
                  ),
                  IMButton(
                    text: '圆角按钮',
                    type: ButtonType.fill,
                    shape: ButtonShape.rectangle,
                    theme: IMButtonTheme.primary,
                  ),

                  IMButton(
                    text: '圆形\n按钮',
                    width: 60,
                    height: 60,
                    padding: EdgeInsets.zero,
                    type: ButtonType.fill,
                    shape: ButtonShape.circle,
                    theme: IMButtonTheme.primary,
                  ),
                  IMButton(
                    text: '方形按钮',
                    type: ButtonType.fill,
                    shape: ButtonShape.square,
                    theme: IMButtonTheme.primary,
                  ),
                  IMButton(
                    text: '填充按钮',
                    type: ButtonType.fill,
                    shape: ButtonShape.filled,
                    theme: IMButtonTheme.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
