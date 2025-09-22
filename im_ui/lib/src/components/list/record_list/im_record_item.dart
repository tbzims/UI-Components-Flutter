import 'package:flutter/material.dart';

import 'package:im_ui/im_ui.dart';
export 'package:flutter_slidable/flutter_slidable.dart';

/// 侧滑方向枚举
enum SwipeDirection {
  /// 左侧滑
  left,

  /// 右侧滑
  right,

  /// 左右侧滑
  both,
}

/// 操作图标对齐方式
enum ActionAlignment {
  /// 左对齐
  left,

  /// 居中对齐
  center,

  /// 右对齐
  right,
}

class IMRecordItem extends StatefulWidget {
  const IMRecordItem({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.hasArrow = false,
    this.onTap,
    this.customWidget,
    this.hasBorder = false,
    this.borderColor,
    this.borderWidth,
    this.borderHeight,
    this.borderWidthFactor = 1.0,
    this.hasDivider = true,
    this.dividerColor,
    this.dividerThickness,
    this.dividerHeight = 0.5,
    this.dividerIndent = 0.0,
    this.dividerEndIndent = 0.0,
    this.leftActions = const [],
    this.centerActions = const [],
    this.rightActions = const [],
    this.actionAlignment = ActionAlignment.right,
  }) : enableSwipe = false,
       swipeDirection = null,
       swipeActions = null,
       groupTag = null;

  /// 用于侧滑的构造函数
  const IMRecordItem.slidable({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.hasArrow = false,
    this.onTap,
    this.customWidget,
    this.hasBorder = false,
    this.borderColor,
    this.borderWidth,
    this.borderHeight,
    this.borderWidthFactor = 1.0,
    this.hasDivider = true,
    this.dividerColor,
    this.dividerThickness,
    this.dividerHeight = 0.5,
    this.dividerIndent = 0.0,
    this.dividerEndIndent = 0.0,
    this.swipeDirection = SwipeDirection.right,
    required this.swipeActions,
    this.groupTag = 'groupTag',
  }) : leftActions = const [],
       centerActions = const [],
       rightActions = const [],
       actionAlignment = ActionAlignment.right,
       enableSwipe = true,
       assert(
         swipeActions != null && swipeActions.length <= 3,
         'Swipe actions must not exceed 3',
       );

  /// 标题
  final String? title;

  /// 副标题
  final String? subtitle;

  /// 左侧widget
  final Widget? leading;

  /// 右侧widget
  final Widget? trailing;

  /// 是否有箭头
  final bool hasArrow;

  /// 点击事件
  final VoidCallback? onTap;

  /// 自定义widget
  final Widget? customWidget;

  /// 是否有边框
  final bool hasBorder;

  /// 边框颜色
  final Color? borderColor;

  /// 边框粗细
  final double? borderWidth;

  /// 边框高度
  final double? borderHeight;

  /// 边框宽度因子（0.0-1.0）
  final double borderWidthFactor;

  /// 是否有底部分割线
  final bool hasDivider;

  /// 分割线颜色
  final Color? dividerColor;

  /// 分割线粗细
  final double? dividerThickness;

  /// 分割线高度
  final double dividerHeight;

  /// 分割线左侧间距
  final double dividerIndent;

  /// 分割线右侧间距
  final double dividerEndIndent;

  /// 是否启用侧滑 (仅用于侧滑构造函数)
  final bool enableSwipe;

  /// 侧滑方向 (仅用于侧滑构造函数)
  final SwipeDirection? swipeDirection;

  /// 侧滑操作按钮 (仅用于侧滑构造函数)
  final List<SlidableAction>? swipeActions;

  /// 左侧操作图标
  final List<Widget> leftActions;

  /// 中间操作图标
  final List<Widget> centerActions;

  /// 右侧操作图标
  final List<Widget> rightActions;

  /// 操作图标对齐方式
  final ActionAlignment actionAlignment;

  /// 组标签，用于管理同一组内的侧滑项
  final Object? groupTag;

  /// 存储所有控制器的静态映射
  static final Map<Object, List<SlidableController>> _controllers = {};

  /// 添加或移除控制器
  static void _manageController(
    SlidableController controller,
    Object? tag, {
    bool remove = false,
  }) {
    if (tag == null) {
      return;
    }

    if (remove) {
      if (_controllers.containsKey(tag)) {
        _controllers[tag]!.remove(controller);
      }
    } else {
      if (_controllers.containsKey(tag)) {
        if (!_controllers[tag]!.contains(controller)) {
          _controllers[tag]!.add(controller);
        }
      } else {
        _controllers[tag] = [controller];
      }
    }
  }

  /// 关闭同一组内的其他侧滑项
  static void closeOthers(Object? tag, {SlidableController? current}) {
    if (tag == null || !_controllers.containsKey(tag)) {
      return;
    }

    for (var controller in _controllers[tag]!) {
      if (controller != current) {
        controller.close();
      }
    }
  }

  @override
  State<IMRecordItem> createState() => _IMRecordItemState();
}

class _IMRecordItemState extends State<IMRecordItem>
    with TickerProviderStateMixin {
  bool _isPressed = false;
  late SlidableController _slidableController;

  @override
  void initState() {
    super.initState();
    // 如果是侧滑项，创建SlidableController
    if (widget.enableSwipe) {
      _slidableController = SlidableController(this);

      // 将控制器添加到组中
      IMRecordItem._manageController(_slidableController, widget.groupTag);

      // 监听滑动状态变化
      _slidableController.actionPaneType.addListener(
        _handleActionPaneTypeChanged,
      );
    }
  }

  @override
  void dispose() {
    if (widget.enableSwipe) {
      _slidableController.actionPaneType.removeListener(
        _handleActionPaneTypeChanged,
      );
      // 从组中移除控制器
      IMRecordItem._manageController(
        _slidableController,
        widget.groupTag,
        remove: true,
      );
      _slidableController.dispose();
    }
    super.dispose();
  }

  void _handleActionPaneTypeChanged() {
    // 当侧滑面板打开时，关闭同组的其他项
    if (widget.groupTag != null &&
        _slidableController.actionPaneType.value != ActionPaneType.none) {
      IMRecordItem.closeOthers(widget.groupTag, current: _slidableController);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = IMTheme.of(context);

    // 如果有自定义widget，直接返回
    if (widget.customWidget != null) {
      return _buildContainer(widget.customWidget!);
    }

    final content = Row(
      children: [
        // 左侧widget
        if (widget.leading != null) ...[
          widget.leading!,
          const SizedBox(width: 12),
        ],

        // 中间内容
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.title != null)
                Text(
                  widget.title!,
                  style: TextStyle(
                    fontSize: 16,
                    color: theme.colorMap['fontGyColor1'],
                  ),
                ),
              if (widget.subtitle != null)
                Text(
                  widget.subtitle!,
                  style: TextStyle(
                    fontSize: 14,
                    color: theme.colorMap['fontGyColor2'],
                  ),
                ),
            ],
          ),
        ),

        // 右侧widget
        if (widget.trailing != null) ...[
          widget.trailing!,
          const SizedBox(width: 8),
        ],

        // 箭头图标
        if (widget.hasArrow)
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: theme.colorMap['fontGyColor3'],
          ),
      ],
    );

    // 添加操作图标
    final actionContent = _buildActionContent(content);

    if (widget.enableSwipe) {
      return _buildSwipeItem(actionContent);
    } else {
      return _buildContainer(actionContent);
    }
  }

  /// 构建操作图标内容
  Widget _buildActionContent(Widget content) {
    // 如果没有操作图标，直接返回内容
    if (widget.leftActions.isEmpty &&
        widget.centerActions.isEmpty &&
        widget.rightActions.isEmpty) {
      return content;
    }

    List<Widget> leftWidgets = List<Widget>.from(widget.leftActions);
    List<Widget> centerWidgets = List<Widget>.from(widget.centerActions);
    List<Widget> rightWidgets = List<Widget>.from(widget.rightActions);

    // 根据对齐方式构建布局
    switch (widget.actionAlignment) {
      case ActionAlignment.left:
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...leftWidgets,
            if (leftWidgets.isNotEmpty &&
                (centerWidgets.isNotEmpty || rightWidgets.isNotEmpty))
              const SizedBox(width: 8),
            ...centerWidgets,
            if (centerWidgets.isNotEmpty && rightWidgets.isNotEmpty)
              const SizedBox(width: 8),
            ...rightWidgets,
            const Spacer(),
            content,
          ],
        );
      case ActionAlignment.center:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                ...leftWidgets,
                if (leftWidgets.isNotEmpty &&
                    (centerWidgets.isNotEmpty || rightWidgets.isNotEmpty))
                  const SizedBox(width: 8),
                ...centerWidgets,
              ],
            ),
            content,
            Row(children: [...rightWidgets]),
          ],
        );
      case ActionAlignment.right:
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            content,
            const Spacer(),
            ...leftWidgets,
            if (leftWidgets.isNotEmpty &&
                (centerWidgets.isNotEmpty || rightWidgets.isNotEmpty))
              const SizedBox(width: 8),
            ...centerWidgets,
            if (centerWidgets.isNotEmpty && rightWidgets.isNotEmpty)
              const SizedBox(width: 8),
            ...rightWidgets,
          ],
        );
    }
  }

  /// 构建容器
  Widget _buildContainer(Widget child) {
    final theme = IMTheme.of(context);

    BoxDecoration? decoration;
    if (widget.hasBorder) {
      decoration = BoxDecoration(
        border: Border.all(
          color: widget.borderColor ?? theme.colorMap['brandColor7']!,
          width: widget.borderWidth ?? 1.0,
        ),
      );
    }

    return Container(
      height: widget.borderHeight,
      width: double.infinity * widget.borderWidthFactor,
      decoration: decoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: widget.onTap,
            onTapDown: (_) {
              setState(() {
                _isPressed = true;
              });
            },
            onTapUp: (_) {
              setState(() {
                _isPressed = false;
              });
            },
            onTapCancel: () {
              setState(() {
                _isPressed = false;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color:
                  _isPressed
                      ? theme.colorMap['grayColor2']
                      : Colors.transparent,
              child: child,
            ),
          ),
          if (widget.hasDivider)
            Divider(
              height: widget.dividerHeight,
              thickness: widget.dividerThickness ?? 0.5,
              indent: widget.dividerIndent,
              endIndent: widget.dividerEndIndent,
              color: widget.dividerColor ?? theme.colorMap['grayColor3'],
            ),
        ],
      ),
    );
  }

  /// 构建侧滑项
  Widget _buildSwipeItem(Widget content) {
    final theme = IMTheme.of(context);

    // 确保swipeActions不为空
    if (widget.swipeActions == null || widget.swipeActions!.isEmpty) {
      return _buildContainer(content);
    }

    // 构建侧滑按钮
    List<SlidableAction> actions = [];
    if (widget.swipeActions != null && widget.swipeActions!.isNotEmpty) {
      actions = List<SlidableAction>.from(widget.swipeActions!);
    }

    // 确保最多只有3个按钮
    if (actions.length > 3) {
      // 显示警告信息
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('侧滑按钮数量不能超过3个'),
            backgroundColor: Colors.red,
          ),
        );
      });

      actions = actions.sublist(0, 3);
    }

    // 创建开始动作（左侧滑动时显示）
    List<SlidableAction> startActions = [];
    // 创建结束动作（右侧滑动时显示）
    List<SlidableAction> endActions = [];

    if (widget.swipeDirection == SwipeDirection.left) {
      startActions = actions;
    } else if (widget.swipeDirection == SwipeDirection.right) {
      endActions = actions;
    } else {
      // 对于both情况，将动作平均分配到两侧
      if (actions.length == 1) {
        endActions = actions;
      } else if (actions.length == 2) {
        startActions = [actions[0]];
        endActions = [actions[1]];
      } else if (actions.length == 3) {
        startActions = [actions[0]];
        endActions = [actions[1], actions[2]];
      }
    }

    return Slidable(
      key: widget.key ?? ValueKey(Object()),
      controller: _slidableController,
      startActionPane:
          startActions.isNotEmpty
              ? ActionPane(motion: const ScrollMotion(), children: startActions)
              : null,
      endActionPane:
          endActions.isNotEmpty
              ? ActionPane(motion: const ScrollMotion(), children: endActions)
              : null,
      child: _buildContainer(content),
    );
  }
}
