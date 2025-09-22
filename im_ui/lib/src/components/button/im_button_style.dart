import 'package:flutter/material.dart' hide ButtonTheme;
import '../../theme/im_colors.dart';
import '../../theme/im_theme.dart';
import 'im_button.dart';

class IMButtonStyle {
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

  IMButtonStyle({
    this.backgroundColor,
    this.frameColor,
    this.textColor,
    this.frameWidth,
    this.radius,
  });

  /// 生成不同主题的填充按钮样式
  IMButtonStyle.generateFillStyleByTheme(
    BuildContext context,
    IMButtonTheme? theme,
    ButtonStatus status,
  ) {
    switch (theme) {
      case IMButtonTheme.primary:
        textColor = IMTheme.of(context).brand1;
        backgroundColor = _getBrandColor(context, status);
        break;
      case IMButtonTheme.danger:
        textColor = IMTheme.of(context).brand1;
        backgroundColor = _getErrorColor(context, status);
        break;
      case IMButtonTheme.light:
        textColor = _getBrandColor(context, status);
        backgroundColor = _getLightColor(context, status);
        break;
      case IMButtonTheme.defaultTheme:
      default:
        textColor = _getDefaultTextColor(context, status);
        backgroundColor = _getDefaultBgColor(context, status);
    }
    frameColor = backgroundColor;
  }

  /// 生成不同主题的描边按钮样式
  IMButtonStyle.generateOutlineStyleByTheme(
    BuildContext context,
    IMButtonTheme? theme,
    ButtonStatus status,
  ) {
    switch (theme) {
      case IMButtonTheme.primary:
        textColor = _getBrandColor(context, status);
        backgroundColor =
            status == ButtonStatus.active
                ? IMTheme.of(context).fontGyColor1
                : IMTheme.of(context).fontGyColor1;
        frameColor = textColor;
        break;
      case IMButtonTheme.danger:
        textColor = _getErrorColor(context, status);
        backgroundColor =
            status == ButtonStatus.active
                ? IMTheme.of(context).fontGyColor1
                : IMTheme.of(context).fontGyColor1;
        frameColor = textColor;
        break;
      case IMButtonTheme.light:
        textColor = _getBrandColor(context, status);
        backgroundColor = _getLightColor(context, status);
        frameColor = textColor;
        break;
      case IMButtonTheme.defaultTheme:
      default:
        textColor = _getDefaultTextColor(context, status);
        backgroundColor = _getOutlineDefaultBgColor(context, status);
        frameColor = IMTheme.of(context).fontGyColor1;
    }
    frameWidth = 1;
  }

  /// 生成不同主题的文本按钮样式
  IMButtonStyle.generateTextStyleByTheme(
    BuildContext context,
    IMButtonTheme? theme,
    ButtonStatus status,
  ) {
    switch (theme) {
      case IMButtonTheme.primary:
        textColor = _getBrandColor(context, status);
        backgroundColor =
            status == ButtonStatus.active
                ? IMTheme.of(context).fontGyColor1
                : Colors.transparent;
        break;
      case IMButtonTheme.danger:
        textColor = _getErrorColor(context, status);
        backgroundColor =
            status == ButtonStatus.active
                ? IMTheme.of(context).fontGyColor1
                : Colors.transparent;
        break;
      case IMButtonTheme.light:
        textColor = _getBrandColor(context, status);
        backgroundColor =
            status == ButtonStatus.active
                ? IMTheme.of(context).fontGyColor1
                : Colors.transparent;
        break;
      case IMButtonTheme.defaultTheme:
      default:
        textColor = _getDefaultTextColor(context, status);
        backgroundColor =
            status == ButtonStatus.active
                ? IMTheme.of(context).fontGyColor1
                : Colors.transparent;
    }
    frameColor = backgroundColor;
  }

  Color _getBrandColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
        return IMTheme.of(context).brand1;
      case ButtonStatus.active:
        return IMTheme.of(context).brand1;
      case ButtonStatus.disable:
      case ButtonStatus.loading:
        return IMTheme.of(context).brand1;
    }
  }

  Color _getLightColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
      case ButtonStatus.disable:
      case ButtonStatus.loading:
        return IMTheme.of(context).brand1;
      case ButtonStatus.active:
        return IMTheme.of(context).brand1;
    }
  }

  Color _getErrorColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
        return IMTheme.of(context).brand1;
      case ButtonStatus.active:
        return IMTheme.of(context).brand1;
      case ButtonStatus.disable:
      case ButtonStatus.loading:
        return IMTheme.of(context).brand1;
    }
  }

  Color _getDefaultBgColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
        return IMTheme.of(context).fontGyColor1;
      case ButtonStatus.active:
        return IMTheme.of(context).fontGyColor1;
      case ButtonStatus.disable:
      case ButtonStatus.loading:
        return IMTheme.of(context).fontGyColor1;
    }
  }

  Color _getDefaultTextColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
      case ButtonStatus.active:
        return IMTheme.of(context).fontGyColor1;
      case ButtonStatus.disable:
      case ButtonStatus.loading:
        return IMTheme.of(context).fontGyColor4;
    }
  }

  Color _getOutlineDefaultBgColor(BuildContext context, ButtonStatus status) {
    switch (status) {
      case ButtonStatus.defaultState:
        return IMTheme.of(context).fontGyColor1;
      case ButtonStatus.active:
        return IMTheme.of(context).fontGyColor1;
      case ButtonStatus.disable:
      case ButtonStatus.loading:
        return IMTheme.of(context).fontGyColor1;
    }
  }
}
