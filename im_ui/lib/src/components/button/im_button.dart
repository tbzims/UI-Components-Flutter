import 'package:flutter/material.dart';
import 'package:im_ui/im_ui.dart';
import 'im_button_style.dart';

/// 定义按钮的显示样式类型
enum IMButtonType {
  /// 填充型按钮 - 背景色填充整个按钮区域
  fill,

  /// 边框型按钮 - 带边框，背景透明或半透明
  border,

  /// 文字型按钮 - 仅显示文字，无背景和边框
  text,
}

/// 定义按钮的不同交互状态
enum IMButtonStatus {
  /// 默认状态 - 按钮处于正常未交互状态
  normal,

  /// 按下状态 - 按钮被按下
  pressed,

  /// 禁用状态 - 按钮被禁用，无法交互
  disabled,

  /// 加载状态 - 按钮正在执行异步操作
  loading,
}

/// 定义按钮布局方向
enum IMButtonLayout {
  /// 横向布局
  horizontal,

  /// 纵向布局
  vertical,
}

typedef IMButtonCallback = void Function();

class IMButton extends StatefulWidget {
  /// 按钮文字
  final String? text;

  /// 按钮样式类型
  final IMButtonType type;

  /// 按钮状态
  final IMButtonStatus status;

  /// 按钮是否禁用
  final bool disabled;

  /// 按钮点击回调
  final IMButtonCallback? onTap;

  /// 按钮长按回调
  final IMButtonCallback? onLongPress;

  /// 按钮文字样式
  final TextStyle? textStyle;

  /// 按钮宽度（具体数值）
  final double? width;

  /// 最大宽度(使用百分比必传)
  final double? maxWidth;

  /// 按钮百分比宽度 (0.0 - 1.0)
  final double? percentWidth;

  /// 按钮内边距
  final EdgeInsets? padding;

  /// 按钮外边距
  final EdgeInsets? margin;

  /// 按钮圆角
  final double? borderRadius;

  /// 按钮背景颜色
  final Color? backgroundColor;

  /// 按钮边框颜色
  final Color? borderColor;

  /// 按钮边框宽度
  final double? borderWidth;

  /// 自定义按钮样式
  final IMButtonStyle? style;

  /// 自定义加载图标
  final Widget? loadingWidget;

  /// 自定义按钮图标 (支持SVG,PNG等)
  final Widget? icon;

  /// 按钮布局方向
  final IMButtonLayout layout;

  /// 是否显示加载状态
  final bool showLoading;

  const IMButton({
    super.key,
    this.text,
    this.type = IMButtonType.fill,
    this.status = IMButtonStatus.normal,
    this.disabled = false,
    this.onTap,
    this.onLongPress,
    this.textStyle,
    this.width,
    this.maxWidth,
    this.percentWidth,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.style,
    this.loadingWidget,
    this.icon,
    this.layout = IMButtonLayout.horizontal,
    this.showLoading = false,
  });

  @override
  State<IMButton> createState() => _IMButtonState();
}

class _IMButtonState extends State<IMButton> with TickerProviderStateMixin {
  /// 当前按钮状态
  late IMButtonStatus _status;
  
  /// 用于控制加载动画的控制器
  late AnimationController _loadingAnimationController;

  @override
  void initState() {
    super.initState();
    
    // 初始化动画控制器
    _loadingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    // 初始化状态
    if (widget.disabled) {
      _status = IMButtonStatus.disabled;
    } else if (widget.showLoading) {
      _status = IMButtonStatus.loading;
    } else {
      _status = widget.status;
    }
  }

  @override
  void didUpdateWidget(covariant IMButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    // 检查showLoading状态是否发生变化
    if (oldWidget.showLoading != widget.showLoading) {
      if (widget.showLoading) {
        // 开始加载动画
        _loadingAnimationController.forward();
      } else {
        // 反向加载动画
        _loadingAnimationController.reverse();
      }
    }

    // 更新按钮状态，优先级: disabled > showLoading > 其他状态
    IMButtonStatus newStatus;
    if (widget.disabled) {
      newStatus = IMButtonStatus.disabled;
    } else if (widget.showLoading) {
      newStatus = IMButtonStatus.loading;
    } else {
      newStatus = widget.status;
    }

    if (_status != newStatus) {
      setState(() {
        _status = newStatus;
      });
    }
  }

  @override
  void dispose() {
    _loadingAnimationController.dispose();
    super.dispose();
  }

  /// 处理按钮按下事件
  void _onTapDown() {
    // 只有在正常状态下才能按下
    if (_status == IMButtonStatus.normal) {
      setState(() {
        _status = IMButtonStatus.pressed;
      });
    }
  }

  /// 处理按钮释放事件
  void _onTapUp() {
    // 只有在按下状态下才能释放
    if (_status == IMButtonStatus.pressed) {
      setState(() {
        // 恢复到正常状态或保持特殊状态
        if (widget.disabled) {
          _status = IMButtonStatus.disabled;
        } else if (widget.showLoading) {
          _status = IMButtonStatus.loading;
        } else {
          _status = IMButtonStatus.normal;
        }
      });
    }
  }

  /// 处理按钮取消事件
  void _onTapCancel() {
    // 只有在按下状态下才能取消
    if (_status == IMButtonStatus.pressed) {
      setState(() {
        // 恢复到正常状态或保持特殊状态
        if (widget.disabled) {
          _status = IMButtonStatus.disabled;
        } else if (widget.showLoading) {
          _status = IMButtonStatus.loading;
        } else {
          _status = IMButtonStatus.normal;
        }
      });
    }
  }

  /// 处理按钮点击事件
  void _onTap() {
    // 只有在正常和按下状态下才能点击
    if (_status == IMButtonStatus.normal || _status == IMButtonStatus.pressed) {
      widget.onTap?.call();
    }
  }

  /// 处理按钮长按事件
  void _onLongPress() {
    // 只有在正常和按下状态下才能长按
    if (_status == IMButtonStatus.normal || _status == IMButtonStatus.pressed) {
      widget.onLongPress?.call();
    }
  }

  /// 获取按钮样式
  IMButtonStyle _getStyle() {
    // 如果有自定义样式，优先使用
    if (widget.style != null) {
      return widget.style!;
    }

    // 如果有自定义颜色属性，创建自定义样式
    if (widget.backgroundColor != null ||
        widget.borderColor != null ||
        widget.borderRadius != null) {
      return IMButtonStyle(
        backgroundColor: widget.backgroundColor,
        borderColor: widget.borderColor,
        textColor: widget.textStyle?.color,
        borderRadius: widget.borderRadius != null
            ? BorderRadius.circular(widget.borderRadius!)
            : null,
      );
    }

    // 否则根据类型和状态生成默认样式
    return IMButtonStyle.generateStyleByTheme(
      context,
      widget.type,
      _status,
    );
  }

  /// 构建按钮内容
  Widget _buildContent(IMButtonStyle style) {
    // 构建普通内容（图标+文字）
    Widget normalContent;
    
    // 如果没有文字和图标
    if (widget.text == null && widget.icon == null) {
      normalContent = const SizedBox();
    } else {
      // 构建内容组件
      final List<Widget> children = [];

      // 添加图标
      if (widget.icon != null) {
        children.add(widget.icon!);
      }

      // 添加文字
      if (widget.text != null) {
        children.add(
          Text(
            widget.text!,
            style: widget.textStyle ??
                TextStyle(
                  color: style.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
        );
      }

      // 添加图标和文字之间的间距
      if (children.length == 2) {
        if (widget.layout == IMButtonLayout.horizontal) {
          children.insert(1, const SizedBox(width: 8));
        } else {
          children.insert(1, const SizedBox(height: 8));
        }
      }

      // 根据布局方向返回组件
      normalContent = widget.layout == IMButtonLayout.horizontal
          ? Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            );
    }
    
    // 构建加载内容
    Widget loadingContent = widget.loadingWidget ??
        IMLoading(
          size: 20,
          iconColor: style.textColor,
        );
    
    // 根据是否显示加载状态返回相应的内容，使用动画
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: child,
          ),
        );
      },
      child: widget.showLoading 
        ? KeyedSubtree(
            key: const ValueKey('loading'),
            child: loadingContent,
          )
        : KeyedSubtree(
            key: const ValueKey('content'),
            child: normalContent,
          ),
    );
  }

  /// 构建按钮装饰
  BoxDecoration _buildDecoration(IMButtonStyle style) {
    switch (widget.type) {
      case IMButtonType.fill:
        return BoxDecoration(
          color: style.backgroundColor,
          borderRadius: style.borderRadius ?? BorderRadius.circular(6),
        );
      case IMButtonType.border:
        return BoxDecoration(
          color: style.backgroundColor,
          borderRadius: style.borderRadius ?? BorderRadius.circular(6),
          border: Border.all(
            color: style.borderColor ?? IMTheme.of(context).brand1,
            width: style.borderWidth ?? 1.0,
          ),
        );
      case IMButtonType.text:
        return BoxDecoration(
          color: style.backgroundColor,
          borderRadius: style.borderRadius ?? BorderRadius.circular(6),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = _getStyle();

    // 计算按钮宽度
    double? buttonWidth;
    if (widget.width != null) {
      buttonWidth = widget.width;
    } else if (widget.percentWidth != null && widget.maxWidth != null) {
      buttonWidth = widget.maxWidth! * widget.percentWidth!;
    }

    return Container(
      width: buttonWidth,
      margin: widget.margin,
      child: GestureDetector(
        onTapDown: (_) => _onTapDown(),
        onTapUp: (_) => _onTapUp(),
        onTapCancel: _onTapCancel,
        onTap: _onTap,
        onLongPress: _onLongPress,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: _buildDecoration(style),
          padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 8),
          child: Center(
            child: _buildContent(style),
          ),
        ),
      ),
    );
  }
}
