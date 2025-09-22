import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../im_ui.dart';
import 'point_bounce_indicator.dart';

/// 加载图标
enum LoadingIcon {
  /// 圆形 (Android 样式)
  circle,

  /// 点状
  point,

  /// 菊花形 (iOS 样式)
  activity,
}

class IMLoading extends StatelessWidget {
  const IMLoading({
    super.key,
    this.size = 20,
    this.icon = LoadingIcon.circle,
    this.iconColor,
    this.text,
    this.refreshWidget,
    this.textStyle,
    this.axis = Axis.vertical,
    this.customIcon,
    this.duration = 2000,
    this.paddingWidth,
  });

  /// 加载图标大小
  final double size;

  /// 加载图标
  final LoadingIcon? icon;

  /// 加载图标颜色
  final Color? iconColor;

  /// 文案
  final String? text;

  /// 失败刷新组件
  final Widget? refreshWidget;

  /// 文案样式
  final TextStyle? textStyle;

  /// 文案和图标相对方向
  final Axis axis;

  /// 自定义图标，优先级高于icon
  final Widget? customIcon;

  /// 一次刷新的时间，控制动画速度
  final int duration;

  /// 文本和图标之间的间距
  final double? paddingWidth;

  int get _innerDuration => duration > 0 ? duration : 1;

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [_contentWidget(context)]);
  }

  Widget _contentWidget(BuildContext context) {
    // 从主题中获取主色调颜色作为默认颜色
    Color color = _getPrimaryColor(context);
    if (icon == null) {
      return textWidget(context);
    } else {
      Widget? indicator;
      if (customIcon != null) {
        indicator = customIcon!;
      } else {
        switch (icon) {
          // iOS 菊花样式
          case LoadingIcon.activity:
            indicator = _getCupertinoIndicator(color);
            break;
          // Android 圆形样式
          case LoadingIcon.circle:
            indicator = _getMaterialIndicator(color);
            break;
          // 点状弹跳加载指示器
          case LoadingIcon.point:
            indicator = PointBounceIndicator(
              color: iconColor ?? color,
              size: size,
              duration: _innerDuration,
            );
            break;
          default:
            // 默认使用 Android 圆形样式
            indicator = _getMaterialIndicator(color);
            break;
        }
      }

      if (text == null && refreshWidget == null) {
        return indicator;
      } else if (axis == Axis.vertical) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            indicator,
            SizedBox(height: paddingWidth ?? 12),
            if (text != null || refreshWidget != null) textWidget(context),
          ],
        );
      } else {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            indicator,
            SizedBox(width: paddingWidth ?? 8),
            if (text != null || refreshWidget != null) textWidget(context),
          ],
        );
      }
    }
  }

  /// 获取主题主色调颜色
  Color _getPrimaryColor(BuildContext context) {
    try {
      // 尝试从IMTheme获取主色调
      return IMTheme.of(context).brand1;
    } catch (e) {
      // 如果获取失败，使用Material主题的主色调
      try {
        return Theme.of(context).primaryColor;
      } catch (e) {
        // 如果都失败了，使用蓝色作为默认颜色
        return Colors.blue;
      }
    }
  }

  /// 获取 Material Design 风格的圆形加载指示器 (Android 样式)
  Widget _getMaterialIndicator(Color defaultColor) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(iconColor ?? defaultColor),
        strokeWidth: 2.0,
      ),
    );
  }

  /// 获取 Cupertino 风格的加载指示器 (iOS 样式)
  Widget _getCupertinoIndicator(Color defaultColor) {
    return CupertinoActivityIndicator(
      color: iconColor ?? defaultColor,
      radius: size,
      animating: true,
    );
  }

  /// 获取文本组件
  Widget textWidget(BuildContext context) {
    if (refreshWidget != null) {
      return refreshWidget!;
    }

    return Text(
      text ?? '',
      style:
          textStyle ??
          TextStyle(fontSize: 14, color: IMTheme.of(context).fontGyColor1),
    );
  }
}
