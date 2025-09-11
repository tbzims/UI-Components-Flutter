import 'package:flutter/material.dart';
import '../theme/snto_colors.dart';
import '../theme/snto_theme.dart';
import 'snto_button_style.dart';

enum ButtonSize { large, medium, small, extraSmall }

enum ButtonType { fill, outline, text }

enum ButtonShape { rectangle, round, square, circle, filled }

enum SNTOButtonTheme { defaultTheme, primary, danger, light }

enum ButtonStatus { defaultState, active, disable }

enum ButtonIconPosition { left, right, top, bottom }

typedef ButtonEvent = void Function();

class SNTOButton extends StatefulWidget {
  const SNTOButton({
    super.key,
    this.text,
    this.type = ButtonType.fill,
    this.shape = ButtonShape.rectangle,
    this.theme,
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

  /// 主题
  final SNTOButtonTheme? theme;

  /// 自定义样式，有则优先用它，没有则根据type和theme选取.如果设置了style,则activeStyle和disableStyle也应该设置
  final SNTOButtonStyle? style;

  /// 自定义点击样式，有则优先用它，没有则根据type和theme选取
  final SNTOButtonStyle? activeStyle;

  /// 自定义禁用样式，有则优先用它，没有则根据type和theme选取
  final SNTOButtonStyle? disableStyle;

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

  @override
  State<SNTOButton> createState() => _SNTOButtonState();
}

class _SNTOButtonState extends State<SNTOButton> {
  ButtonStatus _buttonStatus = ButtonStatus.defaultState;

  /// 默认样式
  SNTOButtonStyle? _innerDefaultStyle;

  /// 按下时候的样式
  SNTOButtonStyle? _innerActiveStyle;

  /// 被禁用的样式
  SNTOButtonStyle? _innerDisableStyle;

  /// 文字样式
  TextStyle? _textStyle;

  /// 对齐方式
  Alignment? _alignment;

  /// 更新参数
  void _updateParams() async {
    _buttonStatus = widget.disabled
        ? ButtonStatus.disable
        : ButtonStatus.defaultState;
    _innerDefaultStyle = widget.style;
    _innerActiveStyle = widget.activeStyle;
    _innerDisableStyle = widget.disableStyle;
    _alignment = widget.shape == ButtonShape.filled ? Alignment.center : null;
    if (widget.text != null) {
      _textStyle = widget.disabled ? widget.disableTextStyle : widget.textStyle;
    }
  }

  SNTOButtonStyle get style {
    switch (_buttonStatus) {
      case ButtonStatus.defaultState:
        return _defaultStyle;
      case ButtonStatus.active:
        return _activeStyle;
      case ButtonStatus.disable:
        return _disableStyle;
    }
  }

  @override
  void initState() {
    super.initState();
    _updateParams();
  }

  @override
  didUpdateWidget(covariant SNTOButton oldWidget) {
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
      padding: widget.padding ?? EdgeInsets.all(20),
      margin: widget.margin,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        border: _getBorder(context),
        borderRadius: style.radius ?? BorderRadius.all(_getRadius()),
      ),
      child: widget.child ?? _getChild(),
    );
    if (widget.disabled) {
      return display;
    }
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: display,
    );
  }

  SNTOButtonStyle get _defaultStyle {
    if (_innerDefaultStyle != null) {
      return _innerDefaultStyle!;
    }
    _innerDefaultStyle = widget.style ?? _generateInnerStyle();
    return _innerDefaultStyle!;
  }

  SNTOButtonStyle get _activeStyle {
    if (_innerActiveStyle != null) {
      return _innerActiveStyle!;
    }
    _innerActiveStyle = widget.style ?? _generateInnerStyle();
    return _innerActiveStyle!;
  }

  SNTOButtonStyle get _disableStyle {
    if (_innerDisableStyle != null) {
      return _innerDisableStyle!;
    }
    _innerDisableStyle = widget.style ?? _generateInnerStyle();
    return _innerDisableStyle!;
  }

  Border? _getBorder(BuildContext context) {
    if (style.frameWidth != null && style.frameWidth != 0) {
      return Border.all(
        color: style.frameColor ?? SNTOTheme.of(context).grayColor3,
        width: style.frameWidth!,
      );
    }
    return null;
  }

  SNTOButtonStyle _generateInnerStyle() {
    switch (widget.type) {
      case ButtonType.fill:
        return SNTOButtonStyle.generateFillStyleByTheme(
          context,
          widget.theme,
          _buttonStatus,
        );
      case ButtonType.outline:
        return SNTOButtonStyle.generateOutlineStyleByTheme(
          context,
          widget.theme,
          _buttonStatus,
        );
      case ButtonType.text:
        return SNTOButtonStyle.generateTextStyleByTheme(
          context,
          widget.theme,
          _buttonStatus,
        );
    }
  }

  Radius _getRadius() {
    switch (widget.shape) {
      case ButtonShape.rectangle:
      case ButtonShape.square:
        return Radius.circular(10);
      case ButtonShape.round:
      case ButtonShape.circle:
        return Radius.circular(9999);
      case ButtonShape.filled:
        return Radius.zero;
    }
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
              fontSize: 16,
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
      children.insert(1, SizedBox(width: widget.iconTextSpacing ?? 8));
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
            fontSize: 30,
            fontFamily: widget.icon!.fontFamily,
            package: widget.icon!.fontPackage,
          ),
        ),
      );
    }
    return null;
  }
}
