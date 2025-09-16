import 'package:flutter/material.dart';
import '../../theme/im_colors.dart';
import '../../theme/im_theme.dart';
import 'im_button_style.dart';

/// 定义按钮尺寸
enum IMButtonSize {
  /// 小尺寸按钮
  small,

  /// 中等尺寸按钮（默认）
  medium,

  /// 大尺寸按钮
  large,
}

/// 定义按钮的显示样式类型
enum ButtonType {
  /// 填充型按钮 - 背景色填充整个按钮区域
  fill,

  /// 描边型按钮 - 带边框，背景透明或半透明
  outline,

  /// 文字型按钮 - 仅显示文字，无背景和边框
  text,
}

/// 定义按钮的外观形状
enum ButtonShape {
  /// 矩形按钮 - 带有较小圆角的矩形
  rectangle,

  /// 圆角按钮 - 带有较大圆角的矩形（胶囊形状）
  round,

  /// 方形按钮 - 几乎无圆角的矩形
  square,

  /// 圆形按钮 - 完全圆形
  circle,

  /// 填充按钮 - 无圆角，通常用于填充容器
  filled,
}

/// 定义按钮的颜色主题风格
enum IMButtonTheme {
  /// 默认主题 - 使用默认的颜色方案
  defaultTheme,

  /// 主要主题 - 使用主要操作的颜色方案（通常为品牌色）
  primary,

  /// 危险主题 - 使用危险操作的颜色方案（通常为红色）
  danger,

  /// 浅色主题 - 使用浅色系的颜色方案
  light,
}

/// 定义按钮的不同交互状态
enum ButtonStatus {
  /// 默认状态 - 按钮处于正常未交互状态
  defaultState,

  /// 激活状态 - 按钮被按下或处于激活状态
  active,

  /// 禁用状态 - 按钮被禁用，无法交互
  disable,

  /// 加载状态 - 按钮正在执行异步操作
  loading,
}

/// 定义图标相对于文字的位置
enum ButtonIconPosition {
  /// 图标在左侧
  left,

  /// 图标在右侧
  right,

  /// 图标在上方
  top,

  /// 图标在下方
  bottom,
}

/// IMButton 常量定义
class IMButtonConstants {
  /// 默认内边距
  static const double defaultPadding = 10.0;

  /// 默认边框圆角
  static const double defaultBorderRadius = 10.0;

  /// 圆形按钮的圆角值
  static const double circleBorderRadius = 9999.0;

  /// 默认加载图标大小
  static const double defaultLoadingSize = 20.0;

  /// 默认加载图标线宽
  static const double defaultLoadingStrokeWidth = 2.0;

  /// 默认图标大小
  static const double defaultIconSize = 30.0;

  /// 默认图标与文本间距
  static const double defaultIconTextSpacing = 8.0;

  /// 默认字体大小
  static const double defaultFontSize = 16.0;

  /// 小按钮尺寸的缩放因子
  static const double smallSizeFactor = 0.8;

  /// 大按钮尺寸的缩放因子
  static const double largeSizeFactor = 1.2;
}

typedef ButtonEvent = Future<void> Function();

class IMButton extends StatefulWidget {
  const IMButton({
    super.key,
    this.text,
    this.type = ButtonType.fill,
    this.shape = ButtonShape.rectangle,
    this.theme,
    this.size = IMButtonSize.medium,
    this.child,
    this.disabled = false,
    this.style,
    this.activeStyle,
    this.disableStyle,
    this.textStyle,
    this.disableTextStyle,
    this.width,
    this.height,
    this.onTap,
    this.icon,
    this.iconWidget,
    this.iconTextSpacing,
    this.onLongPress,
    this.margin,
    this.padding,
    this.iconPosition = ButtonIconPosition.left,
    this.showLoading = false,
    this.loadingSize = IMButtonConstants.defaultLoadingSize,
    this.loading,
    this.useMaterialInk = false,
  });

  /// 自控件
  final Widget? child;

  /// 文本内容
  final String? text;

  /// 禁止点击
  final bool disabled;

  /// 自定义宽度
  final double? width;

  /// 自定义高度
  final double? height;

  /// 类型：填充，描边，文字
  final ButtonType type;

  /// 形状：圆角，胶囊，方形，圆形，填充
  final ButtonShape shape;

  /// 按钮尺寸：小、中、大
  final IMButtonSize size;

  /// 主题
  final IMButtonTheme? theme;

  /// 自定义样式，有则优先用它，没有则根据type和theme选取.
  /// 如果设置了style,则activeStyle和disableStyle也应该设置
  final IMButtonStyle? style;

  /// 自定义点击样式，有则优先用它，没有则根据type和theme选取
  final IMButtonStyle? activeStyle;

  /// 自定义禁用样式，有则优先用它，没有则根据type和theme选取
  final IMButtonStyle? disableStyle;

  /// 自定义可点击状态文本样式
  final TextStyle? textStyle;

  /// 自定义不可点击状态文本样式
  final TextStyle? disableTextStyle;

  /// 点击事件
  final ButtonEvent? onTap;

  /// 长按事件
  final ButtonEvent? onLongPress;

  /// 图标icon
  final IconData? icon;

  /// 自定义图标icon控件
  final Widget? iconWidget;

  /// 自定义图标与文本之间距离
  final double? iconTextSpacing;

  /// 图标位置
  final ButtonIconPosition? iconPosition;

  /// 自定义padding
  final EdgeInsets? padding;

  /// 自定义margin
  final EdgeInsets? margin;

  /// 是否展示加载中
  final bool showLoading;

  /// 加载中图标大小
  final double loadingSize;

  /// 自定义Loading
  final Widget? loading;

  //TODO 是否使用 Material Design 的水波纹效果
  final bool useMaterialInk;

  @override
  State<IMButton> createState() => _IMButtonState();
}

class _IMButtonState extends State<IMButton> {
  ButtonStatus _buttonStatus = ButtonStatus.defaultState;

  bool _isLoading = false;

  /// 默认样式
  IMButtonStyle? _innerDefaultStyle;

  /// 按下时候的样式
  IMButtonStyle? _innerActiveStyle;

  /// 被禁用的样式
  IMButtonStyle? _innerDisableStyle;

  /// 文字样式
  TextStyle? _textStyle;

  /// 对齐方式
  Alignment? _alignment;

  /// 缓存的样式
  IMButtonStyle? _cachedStyle;

  /// 缓存的样式状态
  ButtonStatus? _cachedStatus;

  /// 更新参数
  void _updateParams() async {
    _buttonStatus =
        widget.disabled ? ButtonStatus.disable : ButtonStatus.defaultState;
    _innerDefaultStyle = widget.style;
    _innerActiveStyle = widget.activeStyle;
    _innerDisableStyle = widget.disableStyle;
    _alignment = widget.shape == ButtonShape.filled ? Alignment.center : null;
    if (widget.text != null) {
      _textStyle = widget.disabled ? widget.disableTextStyle : widget.textStyle;
    }

    // 清除缓存样式
    _cachedStyle = null;
    _cachedStatus = null;
  }

  /// 获取当前状态下的样式，使用缓存优化性能
  IMButtonStyle get style {
    // 如果缓存的样式与当前状态一致，则直接返回缓存的样式
    if (_cachedStyle != null && _cachedStatus == _buttonStatus) {
      return _cachedStyle!;
    }

    // 根据状态获取对应样式
    IMButtonStyle result;
    switch (_buttonStatus) {
      case ButtonStatus.defaultState:
        result = _defaultStyle;
        break;
      case ButtonStatus.active:
        result = _activeStyle;
        break;
      case ButtonStatus.disable:
      case ButtonStatus.loading:
        result = _disableStyle;
        break;
    }

    // 缓存结果
    _cachedStyle = result;
    _cachedStatus = _buttonStatus;

    return result;
  }

  @override
  void initState() {
    super.initState();
    _updateParams();
  }

  @override
  didUpdateWidget(covariant IMButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateParams();
  }

  /// 更新按钮
  void upDate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Widget display = Container(
      width: widget.width,
      height: widget.height,
      alignment: _alignment,
      padding:
          widget.padding ?? EdgeInsets.all(IMButtonConstants.defaultPadding),
      margin: widget.margin,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        border: _getBorder(context),
        shape:
            widget.shape == ButtonShape.circle
                ? BoxShape.circle
                : BoxShape.rectangle,
        borderRadius:
            widget.shape == ButtonShape.circle
                ? null
                : style.radius ?? BorderRadius.all(_getRadius()),
      ),
      child:
          _isLoading
              ? UnconstrainedBox(
                child: SizedBox(
                  width: widget.loadingSize,
                  height: widget.loadingSize,
                  child: widget.loading ?? _getLoading(),
                ),
              )
              : widget.child ?? _getChild(),
    );
    // 使用 GestureDetector 处理手势
    return GestureDetector(
      onTap: () => onTap(widget.onTap),
      onLongPress: () => onTap(widget.onLongPress),
      onTapDown: (_) {
        if (widget.disabled || _isLoading) {
          return;
        }
        setState(() {
          _buttonStatus = ButtonStatus.active;
        });
      },
      onTapUp: (_) {
        if (widget.showLoading) return;
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted && (!widget.disabled || _isLoading)) {
            setState(() {
              _buttonStatus = ButtonStatus.defaultState;
            });
          }
        });
      },
      onTapCancel: () {
        if (widget.disabled || widget.showLoading) return;
        if (mounted) {
          setState(() {
            _buttonStatus = ButtonStatus.defaultState;
          });
        }
      },
      child: display,
    );
  }

  /// 点击方法，添加错误处理确保状态正确恢复
  Future<void> onTap(ButtonEvent? onTap) async {
    if (_isLoading || widget.disabled) return;
    if (widget.showLoading && mounted) {
      setState(() {
        _buttonStatus = ButtonStatus.loading;
        _isLoading = true;
      });
    }

    try {
      if (onTap != null) await onTap();
    } finally {
      // 确保即使异步操作出错也能正确恢复状态
      if (widget.showLoading && mounted) {
        setState(() {
          _buttonStatus = ButtonStatus.defaultState;
          _isLoading = false;
        });
      }
    }
  }

  IMButtonStyle get _defaultStyle {
    if (_innerDefaultStyle != null) {
      return _innerDefaultStyle!;
    }
    _innerDefaultStyle = widget.style ?? _generateInnerStyle();
    return _innerDefaultStyle!;
  }

  IMButtonStyle get _activeStyle {
    if (_innerActiveStyle != null) {
      return _innerActiveStyle!;
    }
    _innerActiveStyle = widget.style ?? _generateInnerStyle();
    return _innerActiveStyle!;
  }

  IMButtonStyle get _disableStyle {
    if (_innerDisableStyle != null) {
      return _innerDisableStyle!;
    }
    _innerDisableStyle = widget.style ?? _generateInnerStyle();
    return _innerDisableStyle!;
  }

  Border? _getBorder(BuildContext context) {
    if (style.frameWidth != null && style.frameWidth != 0) {
      return Border.all(
        color: style.frameColor ?? IMTheme.of(context).grayColor3,
        width: style.frameWidth!,
      );
    }
    return null;
  }

  /// 生成内部样式，添加默认返回值提高代码健壮性
  IMButtonStyle _generateInnerStyle() {
    switch (widget.type) {
      case ButtonType.fill:
        return IMButtonStyle.generateFillStyleByTheme(
          context,
          widget.theme,
          _buttonStatus,
        );
      case ButtonType.outline:
        return IMButtonStyle.generateOutlineStyleByTheme(
          context,
          widget.theme,
          _buttonStatus,
        );
      case ButtonType.text:
        return IMButtonStyle.generateTextStyleByTheme(
          context,
          widget.theme,
          _buttonStatus,
        );
    }
  }

  /// 获取圆角半径，使用常量替代魔法数字
  Radius _getRadius() {
    switch (widget.shape) {
      case ButtonShape.rectangle:
        return Radius.circular(IMButtonConstants.defaultBorderRadius);
      case ButtonShape.round:
      case ButtonShape.circle:
        return Radius.circular(IMButtonConstants.circleBorderRadius);
      case ButtonShape.filled:
      case ButtonShape.square:
        return Radius.zero;
    }
  }

  /// 获取加载指示器，使用常量
  Widget _getLoading() {
    return CircularProgressIndicator(
      color: style.textColor,
      strokeWidth: IMButtonConstants.defaultLoadingStrokeWidth,
    );
  }

  Widget _getChild() {
    var icon = getIcon();
    if (widget.text == null && icon == null) {
      return Container();
    }
    var children = <Widget>[];
    // 系统Icon会导致不居中，因此自绘icon指定height
    if (icon != null &&
        (widget.iconPosition == ButtonIconPosition.left ||
            widget.iconPosition == ButtonIconPosition.top)) {
      children.add(icon);
    }
    if (widget.text != null) {
      var text = Text(
        widget.text ?? '',
        style:
            _textStyle ??
            TextStyle(
              color: style.textColor,
              fontSize: IMButtonConstants.defaultFontSize * _getSizeFactor(),
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
            ),
      );
      children.add(text);
    }
    if (icon != null &&
        (widget.iconPosition == ButtonIconPosition.right ||
            widget.iconPosition == ButtonIconPosition.bottom)) {
      children.add(icon);
    }

    if (children.length == 2) {
      children.insert(
        1,
        SizedBox(
          width:
              widget.iconTextSpacing ??
              IMButtonConstants.defaultIconTextSpacing,
        ),
      );
    }
    return widget.iconPosition == ButtonIconPosition.left ||
            widget.iconPosition == ButtonIconPosition.right
        ? Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        )
        : Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        );
  }

  /// 根据按钮尺寸获取缩放因子
  double _getSizeFactor() {
    switch (widget.size) {
      case IMButtonSize.small:
        return IMButtonConstants.smallSizeFactor;
      case IMButtonSize.large:
        return IMButtonConstants.largeSizeFactor;
      case IMButtonSize.medium:
        return 1.0;
    }
  }

  Widget? getIcon() {
    if (widget.iconWidget != null) {
      return widget.iconWidget;
    }
    if (widget.icon != null) {
      return RichText(
        overflow: TextOverflow.visible,
        text: TextSpan(
          text: String.fromCharCode(widget.icon!.codePoint),
          style: TextStyle(
            inherit: false,
            color: style.textColor,
            height: 1,
            fontSize: IMButtonConstants.defaultIconSize * _getSizeFactor(),
            fontFamily: widget.icon!.fontFamily,
            package: widget.icon!.fontPackage,
          ),
        ),
      );
    }
    return null;
  }
}
