import 'package:flutter/material.dart' hide ButtonTheme;
import '../theme/snto_colors.dart';
import '../theme/snto_theme.dart';
import 'snto_button.dart';

class SNTOButtonStyle{

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

  SNTOButtonStyle({this.backgroundColor, this.frameColor, this.textColor, this.frameWidth, this.radius});

  /// 生成不同主题的填充按钮样式
  SNTOButtonStyle.generateFillStyleByTheme(BuildContext context, SNTOButtonTheme? theme, ButtonStatus status) {
    switch (theme) {
      case SNTOButtonTheme.primary:
        textColor = SNTOTheme.of(context).fontWhColor1;
        backgroundColor = _getBrandColor(context, status);
        break;
      case SNTOButtonTheme.danger:
        textColor = SNTOTheme.of(context).fontWhColor1;
        backgroundColor = _getErrorColor(context, status);
        break;
      case SNTOButtonTheme.light:
        textColor = _getBrandColor(context, status);
        backgroundColor = _getLightColor(context, status);
        break;
      case SNTOButtonTheme.defaultTheme:
      default:
        textColor = _getDefaultTextColor(context, status);
        backgroundColor = _getDefaultBgColor(context, status);
    }
    frameColor = backgroundColor;
  }

  /// 生成不同主题的描边按钮样式
  SNTOButtonStyle.generateOutlineStyleByTheme(BuildContext context, SNTOButtonTheme? theme, ButtonStatus status) {
    switch (theme) {
      case SNTOButtonTheme.primary:
        textColor = _getBrandColor(context, status);
        backgroundColor =
        status == ButtonStatus.active ? SNTOTheme.of(context).grayColor3 : SNTOTheme.of(context).whiteColor1;
        frameColor = textColor;
        break;
      case SNTOButtonTheme.danger:
        textColor = _getErrorColor(context, status);
        backgroundColor =
        status == ButtonStatus.active ? SNTOTheme.of(context).grayColor3 : SNTOTheme.of(context).whiteColor1;
        frameColor = textColor;
        break;
      case SNTOButtonTheme.light:
        textColor = _getBrandColor(context, status);
        backgroundColor = _getLightColor(context, status);
        frameColor = textColor;
        break;
      case SNTOButtonTheme.defaultTheme:
      default:
        textColor = _getDefaultTextColor(context, status);
        backgroundColor = _getOutlineDefaultBgColor(context, status);
        frameColor = SNTOTheme.of(context).grayColor4;
    }
    frameWidth = 1;
  }

  /// 生成不同主题的文本按钮样式
  SNTOButtonStyle.generateTextStyleByTheme(BuildContext context, SNTOButtonTheme? theme, ButtonStatus status) {
    switch (theme) {
      case SNTOButtonTheme.primary:
        textColor = _getBrandColor(context, status);
        backgroundColor = status == ButtonStatus.active ? SNTOTheme.of(context).grayColor3 : Colors.transparent;
        break;
      case SNTOButtonTheme.danger:
        textColor = _getErrorColor(context, status);
        backgroundColor = status == ButtonStatus.active ? SNTOTheme.of(context).grayColor3 : Colors.transparent;
        break;
      case SNTOButtonTheme.light:
        textColor = _getBrandColor(context, status);
        backgroundColor = status == ButtonStatus.active ? SNTOTheme.of(context).grayColor3 : Colors.transparent;
        break;
      case SNTOButtonTheme.defaultTheme:
      default:
        textColor = _getDefaultTextColor(context, status);
        backgroundColor = status == ButtonStatus.active ? SNTOTheme.of(context).grayColor3 : Colors.transparent;
    }
    frameColor = backgroundColor;
  }

  Color _getBrandColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
        return SNTOTheme.of(context).brandNormalColor;
      case ButtonStatus.active:
        return SNTOTheme.of(context).brandClickColor;
      case ButtonStatus.disable:
        return SNTOTheme.of(context).brandDisabledColor;
    }
  }

  Color _getLightColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
      case ButtonStatus.disable:
        return SNTOTheme.of(context).brandLightColor;
      case ButtonStatus.active:
        return SNTOTheme.of(context).brandFocusColor;
    }
  }

  Color _getErrorColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
        return SNTOTheme.of(context).errorNormalColor;
      case ButtonStatus.active:
        return SNTOTheme.of(context).errorClickColor;
      case ButtonStatus.disable:
        return SNTOTheme.of(context).errorDisabledColor;
    }
  }

  Color _getDefaultBgColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
        return SNTOTheme.of(context).grayColor3;
      case ButtonStatus.active:
        return SNTOTheme.of(context).grayColor5;
      case ButtonStatus.disable:
        return SNTOTheme.of(context).grayColor2;
    }
  }

  Color _getDefaultTextColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
      case ButtonStatus.active:
        return SNTOTheme.of(context).fontGyColor1;
      case ButtonStatus.disable:
        return SNTOTheme.of(context).fontGyColor4;
    }
  }

  Color _getOutlineDefaultBgColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
        return SNTOTheme.of(context).whiteColor1;
      case ButtonStatus.active:
        return SNTOTheme.of(context).grayColor3;
      case ButtonStatus.disable:
        return SNTOTheme.of(context).grayColor2;
    }
  }
}
