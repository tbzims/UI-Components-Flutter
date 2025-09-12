import 'package:flutter/material.dart' hide ButtonTheme;
import '../../theme/snto_colors.dart';
import '../../theme/snto_theme.dart';
import 'snto_button.dart';

class SntoButtonStyle {
  /// 背景颜色
  Color? backgroundColor;

  /// 边框颜色
  Color? frameColor;

  /// 文字颜色
  Color? textColor;

  /// 边框宽度
  double? frameWidth;

  /// 自定义圆角
  BorderRadiusGeometry? radius;

  SntoButtonStyle({
    this.backgroundColor,
    this.frameColor,
    this.textColor,
    this.frameWidth,
    this.radius,
  });

  /// 生成不同主题的填充按钮样式
  SntoButtonStyle.generateFillStyleByTheme(
    BuildContext context,
    SntoButtonTheme? theme,
    ButtonStatus status,
  ) {
    switch (theme) {
      case SntoButtonTheme.primary:
        textColor = SntoTheme.of(context).fontWhColor1;
        backgroundColor = _getBrandColor(context, status);
        break;
      case SntoButtonTheme.danger:
        textColor = SntoTheme.of(context).fontWhColor1;
        backgroundColor = _getErrorColor(context, status);
        break;
      case SntoButtonTheme.light:
        textColor = _getBrandColor(context, status);
        backgroundColor = _getLightColor(context, status);
        break;
      case SntoButtonTheme.defaultTheme:
      default:
        textColor = _getDefaultTextColor(context, status);
        backgroundColor = _getDefaultBgColor(context, status);
    }
    frameColor = backgroundColor;
  }

  /// 生成不同主题的描边按钮样式
  SntoButtonStyle.generateOutlineStyleByTheme(
    BuildContext context,
    SntoButtonTheme? theme,
    ButtonStatus status,
  ) {
    switch (theme) {
      case SntoButtonTheme.primary:
        textColor = _getBrandColor(context, status);
        backgroundColor =
            status == ButtonStatus.active
                ? SntoTheme.of(context).grayColor3
                : SntoTheme.of(context).whiteColor1;
        frameColor = textColor;
        break;
      case SntoButtonTheme.danger:
        textColor = _getErrorColor(context, status);
        backgroundColor =
            status == ButtonStatus.active
                ? SntoTheme.of(context).grayColor3
                : SntoTheme.of(context).whiteColor1;
        frameColor = textColor;
        break;
      case SntoButtonTheme.light:
        textColor = _getBrandColor(context, status);
        backgroundColor = _getLightColor(context, status);
        frameColor = textColor;
        break;
      case SntoButtonTheme.defaultTheme:
      default:
        textColor = _getDefaultTextColor(context, status);
        backgroundColor = _getOutlineDefaultBgColor(context, status);
        frameColor = SntoTheme.of(context).grayColor4;
    }
    frameWidth = 1;
  }

  /// 生成不同主题的文本按钮样式
  SntoButtonStyle.generateTextStyleByTheme(
    BuildContext context,
    SntoButtonTheme? theme,
    ButtonStatus status,
  ) {
    switch (theme) {
      case SntoButtonTheme.primary:
        textColor = _getBrandColor(context, status);
        backgroundColor =
            status == ButtonStatus.active
                ? SntoTheme.of(context).grayColor3
                : Colors.transparent;
        break;
      case SntoButtonTheme.danger:
        textColor = _getErrorColor(context, status);
        backgroundColor =
            status == ButtonStatus.active
                ? SntoTheme.of(context).grayColor3
                : Colors.transparent;
        break;
      case SntoButtonTheme.light:
        textColor = _getBrandColor(context, status);
        backgroundColor =
            status == ButtonStatus.active
                ? SntoTheme.of(context).grayColor3
                : Colors.transparent;
        break;
      case SntoButtonTheme.defaultTheme:
      default:
        textColor = _getDefaultTextColor(context, status);
        backgroundColor =
            status == ButtonStatus.active
                ? SntoTheme.of(context).grayColor3
                : Colors.transparent;
    }
    frameColor = backgroundColor;
  }

  Color _getBrandColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
        return SntoTheme.of(context).brandNormalColor;
      case ButtonStatus.active:
        return SntoTheme.of(context).brandClickColor;
      case ButtonStatus.disable:
      case ButtonStatus.loading:
        return SntoTheme.of(context).brandDisabledColor;
    }
  }

  Color _getLightColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
      case ButtonStatus.disable:
      case ButtonStatus.loading:
        return SntoTheme.of(context).brandLightColor;
      case ButtonStatus.active:
        return SntoTheme.of(context).brandFocusColor;
    }
  }

  Color _getErrorColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
        return SntoTheme.of(context).errorNormalColor;
      case ButtonStatus.active:
        return SntoTheme.of(context).errorClickColor;
      case ButtonStatus.disable:
      case ButtonStatus.loading:
        return SntoTheme.of(context).errorDisabledColor;
    }
  }

  Color _getDefaultBgColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
        return SntoTheme.of(context).grayColor3;
      case ButtonStatus.active:
        return SntoTheme.of(context).grayColor5;
      case ButtonStatus.disable:
      case ButtonStatus.loading:
        return SntoTheme.of(context).grayColor2;
    }
  }

  Color _getDefaultTextColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
      case ButtonStatus.active:
        return SntoTheme.of(context).fontGyColor1;
      case ButtonStatus.disable:
      case ButtonStatus.loading:
        return SntoTheme.of(context).fontGyColor4;
    }
  }

  Color _getOutlineDefaultBgColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
        return SntoTheme.of(context).whiteColor1;
      case ButtonStatus.active:
        return SntoTheme.of(context).grayColor3;
      case ButtonStatus.disable:
      case ButtonStatus.loading:
        return SntoTheme.of(context).grayColor2;
    }
  }
}
