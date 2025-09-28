import 'package:flutter/material.dart' hide ButtonTheme;
import '../../theme/im_colors.dart';
import '../../theme/im_theme.dart';
import 'im_button.dart';

class IMButtonStyle {

  /// 按钮样式
  /// * [backgroundColor] - 默认背景颜色
  /// * [borderColor] - 默认边框颜色
  /// * [textColor] - 默认文字颜色
  /// * [backgroundColors] - 不同状态下的背景颜色映射表
  /// * [borderColors] - 不同状态下的边框颜色映射表
  /// * [textColors] - 不同状态下的文字颜色映射表
  /// * [borderWidth] - 边框宽度
  /// * [borderRadius] - 圆角半径
  IMButtonStyle({
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.backgroundColors,
    this.borderColors,
    this.textColors,
    this.borderWidth,
    this.borderRadius,
  });

  /// 背景颜色 (不同状态)
  Map<IMButtonStatus, Color?>? backgroundColors;

  /// 边框颜色 (不同状态)
  Map<IMButtonStatus, Color?>? borderColors;

  /// 文字颜色 (不同状态)
  Map<IMButtonStatus, Color?>? textColors;

  /// 边框宽度
  double? borderWidth;

  /// 自定义圆角
  BorderRadiusGeometry? borderRadius;

  /// 默认背景颜色
  Color? backgroundColor;

  /// 默认边框颜色
  Color? borderColor;

  /// 默认文字颜色
  Color? textColor;



  /// 创建填充样式
  static IMButtonStyle fill({
    Color? backgroundColor,
    Color? textColor,
    Map<IMButtonStatus, Color?>? backgroundColors,
    Map<IMButtonStatus, Color?>? textColors,
    BorderRadiusGeometry? borderRadius,
  }) {
    return IMButtonStyle(
      backgroundColor: backgroundColor,
      textColor: textColor,
      backgroundColors: backgroundColors,
      textColors: textColors,
      borderRadius: borderRadius,
    );
  }

  /// 创建边框样式
  static IMButtonStyle border({
    Color? borderColor,
    Color? textColor,
    Map<IMButtonStatus, Color?>? borderColors,
    Map<IMButtonStatus, Color?>? textColors,
    double? borderWidth,
    BorderRadiusGeometry? borderRadius,
  }) {
    return IMButtonStyle(
      borderColor: borderColor,
      textColor: textColor,
      borderColors: borderColors,
      textColors: textColors,
      borderWidth: borderWidth ?? 1.0,
      borderRadius: borderRadius,
    );
  }

  /// 创建文本样式
  static IMButtonStyle text({
    Color? textColor,
    Map<IMButtonStatus, Color?>? textColors,
  }) {
    return IMButtonStyle(
      textColor: textColor,
      textColors: textColors,
    );
  }

  /// 获取指定状态的背景颜色
  Color? getBackgroundColor(IMButtonStatus status) {
    return backgroundColors?[status] ?? backgroundColor;
  }

  /// 获取指定状态的边框颜色
  Color? getBorderColor(IMButtonStatus status) {
    return borderColors?[status] ?? borderColor;
  }

  /// 获取指定状态的文字颜色
  Color? getTextColor(IMButtonStatus status, {IMButtonType? buttonType}) {
    // 对于边框类型按钮，如果没有指定文字颜色，则使用边框颜色
    if (buttonType == IMButtonType.border) {
      // 检查是否为特定状态指定了文字颜色
      if (textColors != null && textColors!.containsKey(status)) {
        return textColors![status];
      }
      // 检查是否指定了默认文字颜色
      if (textColor != null) {
        return textColor;
      }
      // 否则使用对应状态的边框颜色
      return getBorderColor(status) ?? borderColor;
    }
    // 对于其他类型按钮，使用指定的文字颜色
    return textColors?[status] ?? textColor;
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
              // 不设置textColor，这样getTextColor方法会返回borderColor
              borderRadius: BorderRadius.circular(6),
            );
          case IMButtonStatus.pressed:
            return IMButtonStyle.border(
              borderColor: theme.brand2,
              // 不设置textColor，这样getTextColor方法会返回borderColor
              borderRadius: BorderRadius.circular(6),
            );
          default: // disabled, loading
            return IMButtonStyle.border(
              borderColor: theme.brand4,
              // 不设置textColor，这样getTextColor方法会返回borderColor
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
  
  /// 创建一个新样式，该样式基于当前样式但允许覆盖特定属性
  IMButtonStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? textColor,
    Map<IMButtonStatus, Color?>? backgroundColors,
    Map<IMButtonStatus, Color?>? borderColors,
    Map<IMButtonStatus, Color?>? textColors,
    double? borderWidth,
    BorderRadiusGeometry? borderRadius,
  }) {
    return IMButtonStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      textColor: textColor ?? this.textColor,
      backgroundColors: backgroundColors ?? this.backgroundColors,
      borderColors: borderColors ?? this.borderColors,
      textColors: textColors ?? this.textColors,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }
  
  /// 合并样式，如果当前样式中某个属性为null，则使用默认样式中的对应属性
  IMButtonStyle mergeWithDefaults(
    BuildContext context,
    IMButtonType type,
    IMButtonStatus status,
  ) {
    final defaultStyle = generateStyleByTheme(context, type, status);
    
    return IMButtonStyle(
      backgroundColor: backgroundColor ?? defaultStyle.backgroundColor,
      borderColor: borderColor ?? defaultStyle.borderColor,
      textColor: textColor ?? defaultStyle.textColor,
      backgroundColors: backgroundColors ?? defaultStyle.backgroundColors,
      borderColors: borderColors ?? defaultStyle.borderColors,
      textColors: textColors ?? defaultStyle.textColors,
      borderWidth: borderWidth ?? defaultStyle.borderWidth,
      borderRadius: borderRadius ?? defaultStyle.borderRadius,
    );
  }
}
