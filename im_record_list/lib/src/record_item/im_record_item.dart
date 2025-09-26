import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../im_record_list.dart';

export 'package:flutter_slidable/flutter_slidable.dart';

typedef IMClick = void Function(IMRecordItem cell);

/// 单元格类型
enum IMRecordItemType {
  /// 基础样式
  base,

  /// 图标数据单元格
  iconData,

  /// 头像数据单元格
  avatarData,
}

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
  const IMRecordItem.base({
    super.key,
    this.type = IMRecordItemType.base,
    this.bgColor,
    this.tapColor,
    this.onTap,
    this.enableSwipe = false,
    this.swipeActions,
    this.groupTag,
    this.align = IMRecordItemAlign.center,
    this.margin,
    this.padding,
    this.onLongPress,
    this.bordered,
    this.leftWidget,
    this.rightWidget,
    this.titleWidget,
    this.descriptionWidget,
  });

  /// 单元格类型
  final IMRecordItemType type;

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
    // 设置默认内边距
    EdgeInsets padding = widget.padding ?? const EdgeInsets.all(16.0);

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

    return Container(
      margin: widget.margin,
      color: widget.bgColor,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap != null ? () => widget.onTap!(widget) : null,
          onLongPress: widget.onLongPress != null
              ? () => widget.onLongPress!(widget)
              : null,
          highlightColor: widget.tapColor,
          child: Padding(
            padding: padding,
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
        ),
      ),
    );
  }
}
