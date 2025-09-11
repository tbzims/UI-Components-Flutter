import 'package:flutter/material.dart' hide ButtonTheme;
import '../theme/st_colors.dart';
import '../theme/st_theme.dart';
import 'st_button.dart';

class STButtonStyle{

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

  STButtonStyle({this.backgroundColor, this.frameColor, this.textColor, this.frameWidth, this.radius});

  /// 生成不同主题的填充按钮样式
  STButtonStyle.generateFillStyleByTheme(BuildContext context, STButtonTheme? theme, ButtonStatus status) {
    switch (theme) {
      case STButtonTheme.primary:
        textColor = STTheme.of(context).fontWhColor1;
        backgroundColor = _getBrandColor(context, status);
        break;
      case STButtonTheme.danger:
        textColor = STTheme.of(context).fontWhColor1;
        backgroundColor = _getErrorColor(context, status);
        break;
      case STButtonTheme.light:
        textColor = _getBrandColor(context, status);
        backgroundColor = _getLightColor(context, status);
        break;
      case STButtonTheme.defaultTheme:
      default:
        textColor = _getDefaultTextColor(context, status);
        backgroundColor = _getDefaultBgColor(context, status);
    }
    frameColor = backgroundColor;
  }

  /// 生成不同主题的描边按钮样式
  STButtonStyle.generateOutlineStyleByTheme(BuildContext context, STButtonTheme? theme, ButtonStatus status) {
    switch (theme) {
      case STButtonTheme.primary:
        textColor = _getBrandColor(context, status);
        backgroundColor =
        status == ButtonStatus.active ? STTheme.of(context).grayColor3 : STTheme.of(context).whiteColor1;
        frameColor = textColor;
        break;
      case STButtonTheme.danger:
        textColor = _getErrorColor(context, status);
        backgroundColor =
        status == ButtonStatus.active ? STTheme.of(context).grayColor3 : STTheme.of(context).whiteColor1;
        frameColor = textColor;
        break;
      case STButtonTheme.light:
        textColor = _getBrandColor(context, status);
        backgroundColor = _getLightColor(context, status);
        frameColor = textColor;
        break;
      case STButtonTheme.defaultTheme:
      default:
        textColor = _getDefaultTextColor(context, status);
        backgroundColor = _getOutlineDefaultBgColor(context, status);
        frameColor = STTheme.of(context).grayColor4;
    }
    frameWidth = 1;
  }

  /// 生成不同主题的文本按钮样式
  STButtonStyle.generateTextStyleByTheme(BuildContext context, STButtonTheme? theme, ButtonStatus status) {
    switch (theme) {
      case STButtonTheme.primary:
        textColor = _getBrandColor(context, status);
        backgroundColor = status == ButtonStatus.active ? STTheme.of(context).grayColor3 : Colors.transparent;
        break;
      case STButtonTheme.danger:
        textColor = _getErrorColor(context, status);
        backgroundColor = status == ButtonStatus.active ? STTheme.of(context).grayColor3 : Colors.transparent;
        break;
      case STButtonTheme.light:
        textColor = _getBrandColor(context, status);
        backgroundColor = status == ButtonStatus.active ? STTheme.of(context).grayColor3 : Colors.transparent;
        break;
      case STButtonTheme.defaultTheme:
      default:
        textColor = _getDefaultTextColor(context, status);
        backgroundColor = status == ButtonStatus.active ? STTheme.of(context).grayColor3 : Colors.transparent;
    }
    frameColor = backgroundColor;
  }

  Color _getBrandColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
        return STTheme.of(context).brandNormalColor;
      case ButtonStatus.active:
        return STTheme.of(context).brandClickColor;
      case ButtonStatus.disable:
        return STTheme.of(context).brandDisabledColor;
    }
  }

  Color _getLightColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
      case ButtonStatus.disable:
        return STTheme.of(context).brandLightColor;
      case ButtonStatus.active:
        return STTheme.of(context).brandFocusColor;
    }
  }

  Color _getErrorColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
        return STTheme.of(context).errorNormalColor;
      case ButtonStatus.active:
        return STTheme.of(context).errorClickColor;
      case ButtonStatus.disable:
        return STTheme.of(context).errorDisabledColor;
    }
  }

  Color _getDefaultBgColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
        return STTheme.of(context).grayColor3;
      case ButtonStatus.active:
        return STTheme.of(context).grayColor5;
      case ButtonStatus.disable:
        return STTheme.of(context).grayColor2;
    }
  }

  Color _getDefaultTextColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
      case ButtonStatus.active:
        return STTheme.of(context).fontGyColor1;
      case ButtonStatus.disable:
        return STTheme.of(context).fontGyColor4;
    }
  }

  Color _getOutlineDefaultBgColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
        return STTheme.of(context).whiteColor1;
      case ButtonStatus.active:
        return STTheme.of(context).grayColor3;
      case ButtonStatus.disable:
        return STTheme.of(context).grayColor2;
    }
  }
}
