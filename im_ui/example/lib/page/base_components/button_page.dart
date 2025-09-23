import 'package:flutter/material.dart';
import 'package:im_ui/im_ui.dart';

class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<StatefulWidget> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool _isDisabled = false;
  bool _showLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMButton 示例'),
        backgroundColor: IMTheme.of(context).brand1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 控制按钮
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IMButton(
                  text: _isDisabled ? '启用按钮' : '禁用按钮',
                  type: IMButtonType.fill,
                  onTap: () {
                    setState(() {
                      _isDisabled = !_isDisabled;
                    });
                  },
                ),
                IMButton(
                  text: _showLoading ? '停止加载' : '开始加载',
                  type: IMButtonType.border,
                  onTap: () {
                    setState(() {
                      _showLoading = !_showLoading;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 基础按钮部分
            const Text(
              '基础按钮',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 默认状态
            const Text(
              '默认状态',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                IMButton(
                  text: '填充样式',
                  type: IMButtonType.fill,
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '边框样式',
                  type: IMButtonType.border,
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '文字样式',
                  type: IMButtonType.text,
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 点击状态
            const Text(
              '点击状态',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                IMButton(
                  text: '填充样式',
                  type: IMButtonType.fill,
                  status: IMButtonStatus.pressed,
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '边框样式',
                  type: IMButtonType.border,
                  status: IMButtonStatus.pressed,
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '文字样式',
                  type: IMButtonType.text,
                  status: IMButtonStatus.pressed,
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 禁用状态
            const Text(
              '禁用状态',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                IMButton(
                  text: '填充样式',
                  type: IMButtonType.fill,
                  disabled: true,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '边框样式',
                  type: IMButtonType.border,
                  disabled: true,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '文字样式',
                  type: IMButtonType.text,
                  disabled: true,
                  showLoading: _showLoading,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 加载状态
            const Text(
              '加载状态',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                IMButton(
                  text: '填充样式',
                  type: IMButtonType.fill,
                  showLoading: true,
                  disabled: _isDisabled,
                ),
                IMButton(
                  text: '边框样式',
                  type: IMButtonType.border,
                  showLoading: true,
                  disabled: _isDisabled,
                ),
                IMButton(
                  text: '文字样式',
                  type: IMButtonType.text,
                  showLoading: true,
                  disabled: _isDisabled,
                ),
              ],
            ),
            const SizedBox(height: 30),

            // 文字+图标按钮部分
            const Text(
              '文字+图标按钮',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 默认状态
            const Text(
              '默认状态',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                IMButton(
                  text: '填充样式',
                  type: IMButtonType.fill,
                  icon: const Icon(Icons.add, size: 20),
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '边框样式',
                  type: IMButtonType.border,
                  icon: const Icon(Icons.edit, size: 20),
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '文字样式',
                  type: IMButtonType.text,
                  icon: const Icon(Icons.delete, size: 18),
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 点击状态
            const Text(
              '点击状态',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                IMButton(
                  text: '填充样式',
                  type: IMButtonType.fill,
                  status: IMButtonStatus.pressed,
                  icon: const Icon(Icons.add, size: 18),
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '边框样式',
                  type: IMButtonType.border,
                  status: IMButtonStatus.pressed,
                  icon: const Icon(Icons.edit, size: 18),
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '文字样式',
                  type: IMButtonType.text,
                  status: IMButtonStatus.pressed,
                  icon: const Icon(Icons.delete, size: 18),
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 禁用状态
            const Text(
              '禁用状态',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                IMButton(
                  text: '填充样式',
                  type: IMButtonType.fill,
                  icon: const Icon(Icons.add, size: 18),
                  disabled: true,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '边框样式',
                  type: IMButtonType.border,
                  icon: const Icon(Icons.edit, size: 18),
                  disabled: true,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '文字样式',
                  type: IMButtonType.text,
                  icon: const Icon(Icons.delete, size: 18),
                  disabled: true,
                  showLoading: _showLoading,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 加载状态
            const Text(
              '加载状态',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                IMButton(
                  text: '填充样式',
                  type: IMButtonType.fill,
                  icon: const Icon(Icons.add, size: 18),
                  showLoading: true,
                  disabled: _isDisabled,
                ),
                IMButton(
                  text: '边框样式',
                  type: IMButtonType.border,
                  icon: const Icon(Icons.edit, size: 18),
                  showLoading: true,
                  disabled: _isDisabled,
                ),
                IMButton(
                  text: '文字样式',
                  type: IMButtonType.text,
                  icon: const Icon(Icons.delete, size: 18),
                  showLoading: true,
                  disabled: _isDisabled,
                ),
              ],
            ),
            const SizedBox(height: 30),

            // 不同布局的按钮
            const Text(
              '纵向布局',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                IMButton(
                  textStyle: const TextStyle(fontSize: 16, color: Colors.blue),
                  type: IMButtonType.fill,
                  icon: const Icon(Icons.add),
                  width: 40,
                  layout: IMButtonLayout.vertical,
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '纵向布局',
                  width: 40,
                  textStyle: const TextStyle(fontSize: 16, color: Colors.blue),
                  type: IMButtonType.fill,
                  icon: const Icon(Icons.add),
                  layout: IMButtonLayout.vertical,
                  verticalStatus: IMVerticalStatus.separate,
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '纵向布局',
                  width: 40,
                  borderRadius: 40,
                  textStyle: const TextStyle(fontSize: 16, color: Colors.blue),
                  type: IMButtonType.fill,
                  icon: const Icon(Icons.add),
                  layout: IMButtonLayout.vertical,
                  verticalStatus: IMVerticalStatus.separate,
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '纵向布局',
                  width: 80,
                  borderRadius: 0,
                  textStyle: const TextStyle(fontSize: 16),
                  type: IMButtonType.fill,
                  icon: const Icon(Icons.add),
                  layout: IMButtonLayout.vertical,
                  verticalStatus: IMVerticalStatus.merge,
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
              ],
            ),
            const SizedBox(height: 30),

            // 自定义样式的按钮
            const Text(
              '自定义样式按钮',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                IMButton(
                  text: '自定义填充',
                  backgroundColor: Colors.purple,
                  textStyle: const TextStyle(color: Colors.white),
                  borderRadius: 20,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                ),
                IMButton(
                  text: '自定义边框',
                  borderColor: Colors.green,
                  borderWidth: 2,
                  textStyle: const TextStyle(color: Colors.green),
                  borderRadius: 10,
                ),
                IMButton(
                  text: '自定义文字',
                  textStyle: const TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
