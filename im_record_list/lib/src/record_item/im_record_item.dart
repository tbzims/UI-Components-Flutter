import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../im_record_list.dart';

export 'package:flutter_slidable/flutter_slidable.dart';

typedef IMClick = void Function(IMRecordItem cell);

/// 内容对齐方式
enum IMRecordItemAlign {
  /// 左对齐
  left,

  /// 居中
  center,

  /// 右对齐
  right,
}

class IMRecordItem extends StatefulWidget {
  /// 单元格
  /// * [bgColor] - 背景颜色
  /// * [tapColor] - 点击背景颜色
  /// * [onTap] - 点击事件
  /// * [onLongPress] - 长按事件
  /// * [enableSwipe] - 是否启用侧滑
  /// * [extentRatio] - 侧滑宽度占整行百分比
  /// * [swipeActions] - 侧滑操作按钮
  /// * [groupTag] - 组标签，用于管理同一组内的侧滑项
  /// * [align] - 内容对齐方式
  /// * [margin] - 外边距
  /// * [padding] - 内边距
  /// * [bordered] - 是否显示下边框
  /// * [leftWidget] - 最左侧图标组件
  /// * [rightWidget] - 最右侧图标组件
  /// * [titleWidget] - 标题组件
  /// * [descriptionWidget] - 下方内容描述组件
  const IMRecordItem({
    super.key,
    this.bgColor,
    this.tapColor,
    this.onTap,
    this.onLongPress,
    this.enableSwipe = false,
    this.extentRatio,
    this.swipeActions,
    this.groupTag,
    this.align = IMRecordItemAlign.center,
    this.margin,
    this.padding = const EdgeInsets.all(16.0),
    this.bordered,
    this.leftWidget,
    this.rightWidget,
    this.titleWidget,
    this.descriptionWidget,
  }) : assert(
          swipeActions == null || swipeActions.length <= 3,
          '滑动操作按钮数量不能超过3个',
        );

  /// 基础单元格样式
  /// * [bgColor] - 背景颜色
  /// * [tapColor] - 点击背景颜色
  /// * [onTap] - 点击事件
  /// * [onLongPress] - 长按事件
  /// * [enableSwipe] - 是否启用侧滑
  /// * [extentRatio] - 侧滑宽度占整行百分比
  /// * [swipeActions] - 侧滑操作按钮
  /// * [groupTag] - 组标签，用于管理同一组内的侧滑项
  /// * [align] - 内容对齐方式
  /// * [margin] - 外边距
  /// * [padding] - 内边距
  /// * [bordered] - 是否显示下边框
  /// * [titleWidget] - 标题组件
  /// * [descriptionWidget] - 下方内容描述组件
  const IMRecordItem.base({
    super.key,
    this.bgColor,
    this.tapColor,
    this.onTap,
    this.onLongPress,
    this.enableSwipe = false,
    this.extentRatio,
    this.swipeActions,
    this.groupTag,
    this.align = IMRecordItemAlign.center,
    this.margin,
    this.padding = const EdgeInsets.all(16.0),
    this.bordered,
    this.titleWidget = const Text(
      '标题标题标题标题',
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
    ),
    this.descriptionWidget,
  })  : leftWidget = null,
        rightWidget = null;

  /// 数据单元格样式
  /// * [bgColor] - 背景颜色
  /// * [tapColor] - 点击背景颜色
  /// * [onTap] - 点击事件
  /// * [onLongPress] - 长按事件
  /// * [enableSwipe] - 是否启用侧滑
  /// * [extentRatio] - 侧滑宽度占整行百分比
  /// * [swipeActions] - 侧滑操作按钮
  /// * [groupTag] - 组标签，用于管理同一组内的侧滑项
  /// * [align] - 内容对齐方式
  /// * [margin] - 外边距
  /// * [padding] - 内边距
  /// * [bordered] - 是否显示下边框
  /// * [titleWidget] - 标题组件
  /// * [descriptionWidget] - 下方内容描述组件
  const IMRecordItem.iconData({
    super.key,
    this.bgColor,
    this.tapColor,
    this.onTap,
    this.onLongPress,
    this.enableSwipe = false,
    this.extentRatio,
    this.swipeActions,
    this.groupTag,
    this.align = IMRecordItemAlign.center,
    this.margin,
    this.padding = const EdgeInsets.all(16.0),
    this.bordered,
    this.leftWidget = const Icon(
      Icons.file_copy_rounded,
      size: 24.0,
      color: Colors.grey,
    ),
    this.titleWidget = const Text(
      '标题标题标题标题',
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
    ),
    this.descriptionWidget = const Text(
      '副标题副标题副标题副标题副标题副标',
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.grey,
      ),
    ),
  }) : rightWidget = null;

  /// 头像单元格样式
  /// * [bgColor] - 背景颜色
  /// * [tapColor] - 点击背景颜色
  /// * [onTap] - 点击事件
  /// * [onLongPress] - 长按事件
  /// * [enableSwipe] - 是否启用侧滑
  /// * [extentRatio] - 侧滑宽度占整行百分比
  /// * [swipeActions] - 侧滑操作按钮
  /// * [groupTag] - 组标签，用于管理同一组内的侧滑项
  /// * [align] - 内容对齐方式
  /// * [margin] - 外边距
  /// * [padding] - 内边距
  /// * [bordered] - 是否显示下边框
  /// * [leftWidget] - 最左侧图标组件
  /// * [rightWidget] - 最右侧图标组件
  /// * [titleWidget] - 标题组件
  /// * [descriptionWidget] - 下方内容描述组件
  const IMRecordItem.avatarData({
    super.key,
    this.bgColor,
    this.tapColor,
    this.onTap,
    this.onLongPress,
    this.enableSwipe = false,
    this.extentRatio,
    this.swipeActions,
    this.groupTag,
    this.align = IMRecordItemAlign.center,
    this.margin,
    this.padding = const EdgeInsets.all(16.0),
    this.bordered,
    this.leftWidget = const CircleAvatar(
      radius: 16.0,
      backgroundColor: Colors.grey,
    ),
    this.titleWidget = const Text(
      '标题标题标题标题',
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
    ),
    this.descriptionWidget = const Text(
      '副标题副标题副标题副标题副标题副标',
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.grey,
      ),
    ),
    this.rightWidget = const Row(children: [
      Icon(
        Icons.add,
        size: 16.0,
        color: Colors.grey,
      ),
      SizedBox(width: 4.0),
      Text(
        '右侧文字',
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.grey,
        ),
      )
    ]),
  });

  /// 单元格对齐方式
  final IMRecordItemAlign align;

  /// 背景颜色
  final Color? bgColor;

  /// 背景点击颜色
  final Color? tapColor;

  /// 外边距
  final EdgeInsets? margin;

  /// 内边距
  final EdgeInsets? padding;

  /// 点击事件
  final IMClick? onTap;

  /// 长按事件
  final IMClick? onLongPress;

  /// 是否显示下边框，仅在CellGroup组件下起作用
  final bool? bordered;

  /// 是否启用侧滑
  final bool enableSwipe;

  /// 侧滑宽度占整行百分比
  final double? extentRatio;

  /// 侧滑操作按钮
  final List<SlidableAction>? swipeActions;

  /// 最左侧图标组件
  final Widget? leftWidget;

  /// 最右侧图标组件
  final Widget? rightWidget;

  /// 标题组件
  final Widget? titleWidget;

  /// 下方内容描述组件
  final Widget? descriptionWidget;

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
  late SlidableController _slidableController;
  late Color _bgColor;

  bool _isLongPressed = false;

  @override
  void initState() {
    super.initState();
    _resetBgColor();
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

  /// 点击切换背景色
  void _toggleBgColor() {
    if (mounted) {
      setState(() {
        _bgColor = widget.tapColor ?? Colors.grey.shade300;
      });
    }
  }

  /// 恢复背景色
  void _resetBgColor() {
    if (mounted) {
      setState(() {
        _bgColor = widget.bgColor ?? Colors.transparent;
      });
    }
  }

  /// 长按开始
  void _onLongPressStart() {
    if (mounted) {
      setState(() {
        _isLongPressed = true;
        _bgColor = widget.tapColor ?? Colors.grey.shade300;
      });
    }
  }

  /// 长按结束
  void _onLongPressEnd() {
    if (mounted) {
      setState(() {
        _isLongPressed = false;
        _bgColor = widget.bgColor ?? Colors.transparent;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 主体内容
    Widget content = _buildContent();

    // 如果启用侧滑，包装在Slidable中
    if (widget.enableSwipe) {
      content = Slidable(
        key: widget.key ?? const ValueKey(Object()),
        controller: _slidableController,
        endActionPane:
            widget.swipeActions != null && widget.swipeActions!.isNotEmpty
                ? ActionPane(
                    motion: const ScrollMotion(),
                    extentRatio: widget.extentRatio ?? 0.5,
                    children: widget.swipeActions!,
                  )
                : null,
        child: content,
      );
    }

    return content;
  }

  /// 构建内容组件
  Widget _buildContent() {
    // 根据对齐方式设置主轴对齐
    MainAxisAlignment mainAxisAlignment;
    switch (widget.align) {
      case IMRecordItemAlign.left:
        mainAxisAlignment = MainAxisAlignment.start;
        break;
      case IMRecordItemAlign.center:
        mainAxisAlignment = MainAxisAlignment.center;
        break;
      case IMRecordItemAlign.right:
        mainAxisAlignment = MainAxisAlignment.end;
        break;
    }

    return GestureDetector(
      onTap: widget.onTap != null ? () => widget.onTap!(widget) : null,
      onLongPress:
          widget.onLongPress != null ? () => widget.onLongPress!(widget) : null,
      onTapDown: (_) => _toggleBgColor(),
      onTapUp: (_) => _resetBgColor(),
      onTapCancel: () => _resetBgColor(),
      onLongPressStart: (_) => _onLongPressStart(),
      onLongPressEnd: (_) => _onLongPressEnd(),
      child: Container(
        margin: widget.margin,
        color: _bgColor,
        padding: widget.padding,
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          children: [
            // 左侧组件
            if (widget.leftWidget != null) ...[
              widget.leftWidget!,
              const SizedBox(width: 12),
            ],

            // 中间内容区域（可扩展）
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 标题组件
                  if (widget.titleWidget != null) widget.titleWidget!,

                  // 描述组件
                  if (widget.descriptionWidget != null) ...[
                    const SizedBox(height: 4),
                    widget.descriptionWidget!,
                  ],
                ],
              ),
            ),

            // 右侧组件
            if (widget.rightWidget != null) ...[
              const SizedBox(width: 12),
              widget.rightWidget!,
            ],
          ],
        ),
      ),
    );
  }
}
