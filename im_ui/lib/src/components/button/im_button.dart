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

/// 纵向布局样式
enum IMVerticalStatus {
  /// 文字和图标分离
  separate,

  /// 文字和图标合并
  merge,
}

typedef IMButtonCallback = void Function();

class IMButton extends StatefulWidget {
  /// 按钮样式类型
  final IMButtonType type;

  /// 按钮状态
  final IMButtonStatus status;

  /// 按钮文字
  final String? text;

  /// 按钮文字大小
  final double? textSize;

  /// 间距
  final double? spacing;

  /// 自定义按钮图标 (支持SVG,PNG等)
  final Widget? icon;

  /// 是否显示加载状态
  final bool showLoading;

  /// 自定义加载图标
  final Widget? loadingWidget;

  /// 按钮是否禁用
  final bool disabled;

  /// 按钮点击回调
  final IMButtonCallback? onTap;

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

  /// 按钮边框宽度
  final double? borderWidth;

  /// 自定义按钮样式
  final IMButtonStyle? style;

  /// 按钮布局方向
  final IMButtonLayout layout;

  /// 纵向布局样式
  final IMVerticalStatus? verticalStatus;

  const IMButton({
    super.key,
    this.text,
    this.textSize = 16,
    this.type = IMButtonType.fill,
    this.status = IMButtonStatus.normal,
    this.disabled = false,
    this.onTap,
    this.width,
    this.maxWidth,
    this.percentWidth,
    this.padding,
    this.margin,
    this.borderWidth,
    this.style,
    this.loadingWidget,
    this.icon,
    this.layout = IMButtonLayout.horizontal,
    this.verticalStatus,
    this.showLoading = false,
    this.spacing = 8.0,
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
      _loadingAnimationController.forward();
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

  /// 获取按钮样式
  IMButtonStyle _getStyle() {
    // 如果有自定义样式，优先使用，并与默认样式合并
    if (widget.style != null) {
      return widget.style!.mergeWithDefaults(
        context,
        widget.type,
        _status,
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
        // 是纵向布局
        bool isVertical = widget.layout == IMButtonLayout.vertical;
        // 是分离布局
        bool isSeparate = widget.verticalStatus == IMVerticalStatus.separate;
        if (!(isVertical && isSeparate)) {
          children.add(
            Text(
              widget.text ?? '',
              style: TextStyle(
                color: style.getTextColor(_status, buttonType: widget.type) ??
                    style.textColor,
                fontSize: widget.textSize,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }
      }

      // 添加图标和文字之间的间距
      if (children.length == 2) {
        if (widget.layout == IMButtonLayout.horizontal) {
          children.insert(1, SizedBox(width: widget.spacing));
        } else if (widget.layout == IMButtonLayout.vertical) {
          children.insert(1, SizedBox(height: widget.spacing));
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
          size: widget.textSize ?? 16,
          iconColor: style.getTextColor(_status, buttonType: widget.type) ??
              style.textColor,
        );

    // 使用 Stack 和 AnimatedBuilder 实现双向动画效果
    return Stack(
      alignment: Alignment.center,
      children: [
        // 普通内容
        AnimatedBuilder(
          animation: _loadingAnimationController,
          builder: (context, child) {
            return Opacity(
              opacity: 1.0 - _loadingAnimationController.value,
              child: Transform.scale(
                scale: 1.0 - 0.2 * _loadingAnimationController.value,
                child: child,
              ),
            );
          },
          child: normalContent,
        ),
        // 加载内容
        AnimatedBuilder(
          animation: _loadingAnimationController,
          builder: (context, child) {
            return Opacity(
              opacity: _loadingAnimationController.value,
              child: Transform.scale(
                scale: 0.8 + 0.2 * _loadingAnimationController.value,
                child: child,
              ),
            );
          },
          child: loadingContent,
        ),
      ],
    );
  }

  /// 构建按钮装饰
  BoxDecoration _buildDecoration(IMButtonStyle style) {
    switch (widget.type) {
      case IMButtonType.fill:
        return BoxDecoration(
          color: style.getBackgroundColor(_status) ?? style.backgroundColor,
          borderRadius: style.borderRadius ?? BorderRadius.circular(6),
        );
      case IMButtonType.border:
        return BoxDecoration(
          color: style.getBackgroundColor(_status) ?? style.backgroundColor,
          borderRadius: style.borderRadius ?? BorderRadius.circular(6),
          border: Border.all(
            color: style.getBorderColor(_status) ??
                style.borderColor ??
                IMTheme.of(context).brand1,
            width: style.borderWidth ?? 1.0,
          ),
        );
      case IMButtonType.text:
        return BoxDecoration(
          color: style.getBackgroundColor(_status) ?? style.backgroundColor,
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
    if (widget.layout == IMButtonLayout.vertical &&
        widget.verticalStatus == IMVerticalStatus.separate) {
      return Column(children: [
        Container(
          width: buttonWidth,
          margin: widget.margin,
          child: GestureDetector(
            onTapDown: (_) => _onTapDown(),
            onTapUp: (_) => _onTapUp(),
            onTapCancel: _onTapCancel,
            onTap: _onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: _buildDecoration(style),
              padding:
                  widget.padding ?? const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: _buildContent(style),
              ),
            ),
          ),
        ),
        // 添加文字
        if (widget.text != null) ...[
          SizedBox(height: widget.spacing),
          Text(
            widget.text ?? '',
            style: TextStyle(
              color: style.getTextColor(_status, buttonType: widget.type) ??
                  style.textColor,
              fontSize: widget.textSize,
              fontWeight: FontWeight.w500,
            ),
          )
        ]
      ]);
    }

    return Container(
      width: buttonWidth,
      margin: widget.margin,
      child: GestureDetector(
        onTapDown: (_) => _onTapDown(),
        onTapUp: (_) => _onTapUp(),
        onTapCancel: _onTapCancel,
        onTap: _onTap,
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
