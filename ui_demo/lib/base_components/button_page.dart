import 'package:flutter/material.dart';
import 'package:im_base_package/im_base_package.dart';
class ButtonPage extends StatefulWidget {
  const ButtonPage({super.key});

  @override
  State<StatefulWidget> createState() => _ButtonPageState();
}

class _ButtonPageState extends State<ButtonPage> {
  bool _isDisabled = false;
  bool _showLoading = false;

  late IMButtonGroupController _controller;

  @override
  void initState() {
    super.initState();

    // 初始化控制器，创建3个按钮
    _controller = IMButtonGroupController([
      IMButton(
        text: '按钮1',
        onTap: () {
          print('按钮1被点击');
        },
      ),
      IMButton(
        text: '按钮2',
        type: IMButtonType.border,
        onTap: () {
          print('按钮2被点击');
        },
      ),
      IMButton(
        text: '按钮3',
        type: IMButtonType.text,
        onTap: () {
          print('按钮3被点击');
        },
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IMTheme.of(context).brand6,
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
                  type: IMButtonType.fill,
                  style: IMButtonStyle(textColor: Colors.black),
                  icon: const Icon(Icons.add),
                  layout: IMButtonLayout.vertical,
                  verticalStatus: IMVerticalStatus.separate,
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '纵向布局',
                  width: 40,
                  type: IMButtonType.fill,
                  style: IMButtonStyle(
                    textColor: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  icon: const Icon(Icons.add),
                  layout: IMButtonLayout.vertical,
                  verticalStatus: IMVerticalStatus.separate,
                  disabled: _isDisabled,
                  showLoading: _showLoading,
                ),
                IMButton(
                  text: '布局',
                  width: 60,
                  type: IMButtonType.fill,
                  icon: const Icon(Icons.add),
                  style: IMButtonStyle(
                    borderRadius: BorderRadius.circular(0),
                    textColor: Colors.black,
                  ),
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
                // 示例：用户可以传入不同状态的颜色
                IMButton(
                  text: "自定义颜色",
                  style: IMButtonStyle.fill(
                    backgroundColor: Colors.redAccent,
                    backgroundColors: {
                      IMButtonStatus.normal: Colors.redAccent,
                      IMButtonStatus.pressed: ?Colors.red[200],
                      IMButtonStatus.disabled: ?Colors.red[100],
                    },
                    textColor: Colors.white,
                    textColors: {
                      IMButtonStatus.normal: Colors.white,
                      IMButtonStatus.pressed: Colors.white70,
                      IMButtonStatus.disabled: Colors.white10,
                    },
                  ),
                  onTap: () {
                    // 按钮点击事件
                  },
                ),
                IMButton(
                  text: "自定义颜色",
                  type: IMButtonType.border,
                  style: IMButtonStyle.border(
                    borderColor: Colors.redAccent,
                    borderColors: {
                      IMButtonStatus.normal: Colors.redAccent,
                      IMButtonStatus.pressed: ?Colors.red[200],
                      IMButtonStatus.disabled: ?Colors.red[100],
                    },
                  ),
                  onTap: () {
                    // 按钮点击事件
                  },
                ),
                IMButton(
                  text: "自定义颜色",
                  type: IMButtonType.text,
                  style: IMButtonStyle.text(
                    textColor: Colors.redAccent,
                    textColors: {
                      // 不同状态的背景色
                      IMButtonStatus.normal: Colors.redAccent,
                      IMButtonStatus.pressed: ?Colors.red[200],
                      IMButtonStatus.disabled: ?Colors.red[100],
                    },
                  ),
                  onTap: () {
                    // 按钮点击事件
                  },
                ),
              ],
            ),

            const SizedBox(height: 30),
            Text(
              '基本按钮组:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // 基本按钮组
            IMButtonGroup(
              controller: _controller,
            ),

            SizedBox(height: 30),

            Text(
              '垂直按钮组:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // 垂直按钮组
            IMButtonGroup(
              items: [
                IMButton(
                  text: '顶部按钮',
                  onTap: () {
                    print('顶部按钮被点击');
                  },
                ),
                IMButton(
                  text: '中间按钮',
                  type: IMButtonType.border,
                  onTap: () {
                    print('中间按钮被点击');
                  },
                ),
                IMButton(
                  text: '底部按钮',
                  type: IMButtonType.text,
                  onTap: () {
                    print('底部按钮被点击');
                  },
                ),
              ],
              direction: Axis.vertical,
              spacing: 15,
            ),

            SizedBox(height: 30),

            Text(
              '控制按钮状态:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // 控制按钮状态的示例
            IMButtonGroup(
              items: [
                IMButton(
                  text: '禁用按钮2',
                  onTap: _disableButton2,
                ),
                IMButton(
                  text: '启用按钮2',
                  onTap: _enableButton2,
                ),
                IMButton(
                  text: '按钮2加载',
                  onTap: _loadingButton2,
                ),
              ],
            ),

            SizedBox(height: 20),

            // 演示动态添加按钮
            Text(
              '动态操作:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            IMButtonGroup(
              items: [
                IMButton(
                  text: '添加按钮',
                  onTap: _addButton,
                ),
                IMButton(
                  text: '移除按钮',
                  onTap: _removeButton,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 禁用第二个按钮
  void _disableButton2() {
    setState(() {
      _controller.setDisabled(1, true);
    });
  }

  // 启用第二个按钮
  void _enableButton2() {
    setState(() {
      _controller.setDisabled(1, false);
    });
  }

  // 设置第二个按钮为加载状态
  void _loadingButton2() {
    setState(() {
      _controller.setLoading(1, true);
    });

    // 2秒后取消加载状态
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _controller.setLoading(1, false);
      });
    });
  }

  // 添加按钮
  void _addButton() {
    setState(() {
      _controller.addItem(
        IMButton(
          text: '新按钮${_controller.items.length + 1}',
          onTap: () {
            print('新按钮被点击');
          },
        ),
      );
    });
  }

  // 移除最后一个按钮
  void _removeButton() {
    setState(() {
      if (_controller.items.length > 1) {
        _controller.removeItem(_controller.items.length - 1);
      }
    });
  }
}
