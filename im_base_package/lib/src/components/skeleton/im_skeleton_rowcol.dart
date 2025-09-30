import 'package:flutter/material.dart';
import '../../../im_base_package.dart';

/// 骨架屏样式
class IMSkeletonRowColStyle {
  /// 骨架屏样式
  /// * [rowSpacing] - 行间距
  const IMSkeletonRowColStyle({
    this.rowSpacing = _defaultRowSpacing,
  });

  /// 行间距
  final double Function(BuildContext) rowSpacing;

  /// 默认行间距
  static double _defaultRowSpacing(BuildContext context) => 8;
}

/// 骨架屏行列框架
class IMSkeletonRowCol {
  /// 骨架屏行列框架
  /// * [objects] - 行列对象
  /// * [style] - 样式
  IMSkeletonRowCol({
    required this.objects,
    this.style = const IMSkeletonRowColStyle(),
  }) : assert(objects.isNotEmpty && objects.every((row) => row.isNotEmpty));

  /// 行列对象
  final List<List<IMSkeletonRowColObj>> objects;

  /// 样式
  final IMSkeletonRowColStyle style;

  /// 视觉高度
  double visualHeight(BuildContext context) {
    var rowSpacing = style.rowSpacing(context);
    assert(rowSpacing >= 0);
    if (rowSpacing < 0) {
      rowSpacing = 0;
    }

    return objects
        .map((row) =>
        row.fold(.0, (a, b) => a > b.visualHeight ? a : b.visualHeight))
        .fold(.0, (a, b) => a + b) +
        rowSpacing * (objects.length - 1);
  }
}

/// 骨架屏元素样式
class IMSkeletonRowColObjStyle {
  /// 骨架屏元素样式
  /// * [background] - 背景颜色
  /// * [borderRadius] - 圆角
  const IMSkeletonRowColObjStyle({
    this.background = _defaultBackground,
    this.borderRadius = _textBorderRadius,
  });

  /// 圆形
  /// * [background] - 背景颜色
  const IMSkeletonRowColObjStyle.circle({this.background = _defaultBackground})
      : borderRadius = _circleBorderRadius;

  /// 矩形
  /// * [background] - 背景颜色
  const IMSkeletonRowColObjStyle.rect({this.background = _defaultBackground})
      : borderRadius = _rectBorderRadius;

  /// 文本
  /// * [background] - 背景颜色
  const IMSkeletonRowColObjStyle.text({this.background = _defaultBackground})
      : borderRadius = _textBorderRadius;

  /// 空白占位符
  const IMSkeletonRowColObjStyle.spacer()
      : background = _transparentBackground,
        borderRadius = _textBorderRadius;

  /// 背景颜色
  final Color Function(BuildContext) background;

  /// 圆角
  final double Function(BuildContext) borderRadius;

  /// 默认背景颜色
  static Color _defaultBackground(BuildContext context) =>
      IMTheme.of(context).fill3;

  /// 透明背景颜色
  static Color _transparentBackground(BuildContext context) =>
      Colors.transparent;

  /// 圆形圆角
  static double _circleBorderRadius(BuildContext context) => 4;

  /// 矩形圆角
  static double _rectBorderRadius(BuildContext context) => 4;

  /// 文本圆角
  static double _textBorderRadius(BuildContext context) => 4;
}

/// 骨架屏元素
class IMSkeletonRowColObj {
  /// 骨架屏元素
  /// * [width] - 宽度
  /// * [height] - 高度
  /// * [flex] - 弹性因子
  /// * [margin] - 间距
  /// * [style] - 样式
  const IMSkeletonRowColObj({
    this.width,
    this.height = 16,
    this.flex = 1,
    this.margin = EdgeInsets.zero,
    this.style = const IMSkeletonRowColObjStyle(),
  });

  /// 圆形
  /// * [width] - 宽度
  /// * [height] - 高度
  /// * [flex] - 弹性因子
  /// * [margin] - 间距
  /// * [style] - 样式
  const IMSkeletonRowColObj.circle({
    this.width = 48,
    this.height = 48,
    this.flex,
    this.margin = EdgeInsets.zero,
    this.style = const IMSkeletonRowColObjStyle.circle(),
  });

  /// 矩形
  /// * [width] - 宽度
  /// * [height] - 高度
  /// * [flex] - 弹性因子
  /// * [margin] - 间距
  /// * [style] - 样式
  const IMSkeletonRowColObj.rect({
    this.width,
    this.height = 16,
    this.flex = 1,
    this.margin = EdgeInsets.zero,
    this.style = const IMSkeletonRowColObjStyle.rect(),
  });

  /// 文本
  /// * [width] - 宽度
  /// * [height] - 高度
  /// * [flex] - 弹性因子
  /// * [margin] - 间距
  /// * [style] - 样式
  const IMSkeletonRowColObj.text({
    this.width,
    this.height = 16,
    this.flex = 1,
    this.margin = EdgeInsets.zero,
    this.style = const IMSkeletonRowColObjStyle.text(),
  });

  /// 空白占位符
  /// * [width] - 宽度
  /// * [height] - 高度
  /// * [flex] - 弹性因子
  /// * [margin] - 间距
  const IMSkeletonRowColObj.spacer({
    this.width,
    this.height,
    this.flex,
    this.margin = EdgeInsets.zero,
  }) : style = const IMSkeletonRowColObjStyle.spacer();

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 弹性因子
  final int? flex;

  /// 间距
  final EdgeInsets margin;

  /// 样式
  final IMSkeletonRowColObjStyle style;

  /// 视觉高度
  double get visualHeight => (height ?? 0) + margin.top + margin.bottom;
}
