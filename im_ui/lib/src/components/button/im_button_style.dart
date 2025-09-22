import 'package:flutter/material.dart' hide ButtonTheme;
import '../../theme/im_colors.dart';
import '../../theme/im_theme.dart';
import 'im_button.dart';

class IMButtonStyle {
  /// 背景颜色
  Color? backgroundColor;

  /// 边框颜色
  Color? borderColor;

  /// 文字颜色
  Color? textColor;

  /// 边框宽度
  double? borderWidth;

  /// 自定义圆角
  BorderRadiusGeometry? borderRadius;

  IMButtonStyle({
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.borderWidth,
    this.borderRadius,
  });

  /// 创建填充样式
  static IMButtonStyle fill({
    Color? backgroundColor,
    Color? textColor,
    BorderRadiusGeometry? borderRadius,
  }) {
    return IMButtonStyle(
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderRadius: borderRadius,
    );
  }

  /// 创建边框样式
  static IMButtonStyle border({
    Color? borderColor,
    Color? textColor,
    double? borderWidth,
    BorderRadiusGeometry? borderRadius,
  }) {
    return IMButtonStyle(
      borderColor: borderColor,
      textColor: textColor,
      borderWidth: borderWidth ?? 1.0,
      borderRadius: borderRadius,
    );
  }

  /// 创建文本样式
  static IMButtonStyle text({
    Color? textColor,
  }) {
    return IMButtonStyle(
      textColor: textColor,
    );
  }

  /// 根据主题和按钮类型生成默认样式
  static IMButtonStyle generateStyleByTheme(
    BuildContext context,
    IMButtonType type,
    IMButtonStatus status,
  ) {
    final theme = IMTheme.of(context);

    switch (type) {
      case IMButtonType.fill:
        switch (status) {
          case IMButtonStatus.normal:
            return IMButtonStyle.fill(
              backgroundColor: theme.brand1,
              textColor: theme.fontGyColor6,
              borderRadius: BorderRadius.circular(6),
            );
          case IMButtonStatus.pressed:
            return IMButtonStyle.fill(
              backgroundColor: theme.brand2,
              textColor: theme.fontGyColor6,
              borderRadius: BorderRadius.circular(6),
            );
          default: // disabled, loading
            return IMButtonStyle.fill(
              backgroundColor: theme.brand4,
              textColor: theme.fontGyColor6,
              borderRadius: BorderRadius.circular(6),
            );
        }
      case IMButtonType.border:
        switch (status) {
          case IMButtonStatus.normal:
            return IMButtonStyle.border(
              borderColor: theme.brand1,
              textColor: theme.brand1,
              borderRadius: BorderRadius.circular(6),
            );
          case IMButtonStatus.pressed:
            return IMButtonStyle.border(
              borderColor: theme.brand2,
              textColor: theme.brand2,
              borderRadius: BorderRadius.circular(6),
            );
          default: // disabled, loading
            return IMButtonStyle.border(
              borderColor: theme.brand4,
              textColor: theme.brand4,
              borderRadius: BorderRadius.circular(6),
            );
        }
      case IMButtonType.text:
        switch (status) {
          case IMButtonStatus.normal:
            return IMButtonStyle.text(
              textColor: theme.brand1,
            );
          case IMButtonStatus.pressed:
            return IMButtonStyle.text(
              textColor: theme.brand2,
            );
          default: // disabled, loading
            return IMButtonStyle.text(
              textColor: theme.brand4,
            );
        }
    }
  }
}
