import 'package:flutter/material.dart';
import 'im_button.dart';

/// 按钮组控制器
class IMButtonGroupController {
  final List<IMButton> _items;

  IMButtonGroupController([List<IMButton>? items])
      : _items = List<IMButton>.from(
      items ?? List.generate(2, (_) => IMButton())) {
    // 确保最多只有5个按钮
    if (_items.length > 5) {
      _items.removeRange(5, _items.length);
    }
  }

  /// 获取按钮项列表
  List<IMButton> get items => List.unmodifiable(_items);

  /// 更新指定索引的按钮配置
  void updateItemAt(int index, IMButton newItem) {
    if (index >= 0 && index < _items.length) {
      _items[index] = newItem;
    }
  }

  /// 设置指定按钮为禁用状态
  void setDisabled(int index, bool disabled) {
    if (index >= 0 && index < _items.length) {
      _items[index] = IMButton(
        text: _items[index].text,
        icon: _items[index].icon,
        disabled: disabled,
        showLoading: _items[index].showLoading,
        onTap: _items[index].onTap,
        style: _items[index].style,
        type: _items[index].type,
        width: _items[index].width,
        padding: _items[index].padding,
        margin: _items[index].margin,
      );
    }
  }

  /// 设置指定按钮为加载状态
  void setLoading(int index, bool loading) {
    if (index >= 0 && index < _items.length) {
      _items[index] = IMButton(
        text: _items[index].text,
        icon: _items[index].icon,
        disabled: _items[index].disabled,
        showLoading: loading,
        onTap: _items[index].onTap,
        style: _items[index].style,
        type: _items[index].type,
        width: _items[index].width,
        padding: _items[index].padding,
        margin: _items[index].margin,
      );
    }
  }

  /// 批量设置按钮为禁用状态
  void setAllDisabled(List<int> indices, bool disabled) {
    for (var index in indices) {
      setDisabled(index, disabled);
    }
  }

  /// 批量设置按钮为加载状态
  void setAllLoading(List<int> indices, bool loading) {
    for (var index in indices) {
      setLoading(index, loading);
    }
  }

  /// 添加按钮项
  void addItem(IMButton item) {
    if (_items.length < 5) {
      _items.add(item);
    }
  }

  /// 移除指定索引的按钮项
  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
    }
  }

  /// 清空所有按钮项
  void clear() {
    _items.clear();
  }
}

/// IM按钮组组件
class IMButtonGroup extends StatefulWidget {
  /// 按钮组控制器
  final IMButtonGroupController? controller;

  /// 按钮项列表
  final List<IMButton>? items;

  /// 按钮组排列方向
  final Axis direction;

  /// 按钮之间的间距
  final double spacing;

  /// 主轴对齐方式
  final MainAxisAlignment mainAxisAlignment;

  /// 交叉轴对齐方式
  final CrossAxisAlignment crossAxisAlignment;

  const IMButtonGroup({
    super.key,
    this.controller,
    this.items,
    this.direction = Axis.horizontal,
    this.spacing = 10.0,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : assert(
  controller == null || items == null,
  '不能同时指定controller和items',
  );

  @override
  State<IMButtonGroup> createState() => _IMButtonGroupState();
}

class _IMButtonGroupState extends State<IMButtonGroup> {
  late IMButtonGroupController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        IMButtonGroupController(widget.items ??
            List.generate(2, (_) => IMButton()));
  }

  @override
  void didUpdateWidget(covariant IMButtonGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果items发生变化且没有使用controller，则更新内部controller
    if (widget.controller == null &&
        widget.items != null &&
        widget.items != oldWidget.items) {
      _controller = IMButtonGroupController(widget.items);
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _controller.items;

    // 确保最多只有5个按钮
    final displayItems = items.length > 5 ? items.sublist(0, 5) : items;

    List<Widget> buttons = [];
    for (int i = 0; i < displayItems.length; i++) {
      final item = displayItems[i];
      buttons.add(
        IMButton(
          text: item.text,
          icon: item.icon,
          disabled: item.disabled,
          showLoading: item.showLoading,
          onTap: item.onTap,
          style: item.style,
          type: item.type,
          width: item.width,
          padding: item.padding,
          margin: item.margin,
        ),
      );
    }

    if (widget.direction == Axis.horizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: widget.mainAxisAlignment,
        crossAxisAlignment: widget.crossAxisAlignment,
        children: _addSpacing(buttons, widget.spacing),
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: widget.mainAxisAlignment,
        crossAxisAlignment: widget.crossAxisAlignment,
        children: _addSpacing(buttons, widget.spacing),
      );
    }
  }

  /// 在按钮之间添加间距
  List<Widget> _addSpacing(List<Widget> buttons, double spacing) {
    if (buttons.isEmpty) return buttons;

    List<Widget> result = [];
    for (int i = 0; i < buttons.length; i++) {
      result.add(buttons[i]);
      if (i < buttons.length - 1) {
        if (widget.direction == Axis.horizontal) {
          result.add(SizedBox(width: spacing));
        } else {
          result.add(SizedBox(height: spacing));
        }
      }
    }
    return result;
  }
}
