import 'dart:math';

import 'package:flutter/material.dart';

import '../../../im_base_package.dart';

enum IMAvatarType {
  /// 文字头像
  text,

  /// 图片头像
  image,

  /// 占位头像
  placeholder,

  /// 图标头像
  icon,

  /// 文件头像
  file,
}

class IMAvatar extends StatelessWidget {
  /// 文字头像
  /// * [text] - 头像文字(只能为单个字符)
  /// * [textStyle] - 头像文字样式
  /// * [gradient] - 自定义渐变色
  /// * [size] - 头像大小
  /// * [isCircle] - 是否为圆形头像(默认为[true])
  /// * [radius] - 圆角值(优先级高于[isCircle])
  const IMAvatar.text({
    super.key,
    this.gradient,
    required this.text,
    this.textStyle = const TextStyle(
      fontSize: 14,
      color: Colors.white,
      height: 0,
    ),
    this.bgSize = 60,
    this.isCircle = true,
    this.radius,
  })  : assert(text == null || text.length == 1, 'Text length can only be 1'),
        size = null,
        type = IMAvatarType.text,
        imagePath = null,
        iconPath = null,
        iconColor = null,
        bgColor = null;

  /// 图片头像
  /// * [imagePath] - 头像地址
  /// * [bgColor] - 头像背景
  /// * [size] - 头像大小
  /// * [isCircle] - 是否为圆形头像(默认为[true])
  /// * [radius] - 圆角值(优先级高于[isCircle])
  const IMAvatar.image({
    super.key,
    required this.imagePath,
    this.bgColor,
    this.size = 40,
    this.bgSize = 60,
    this.isCircle = true,
    this.radius,
  })  : assert(imagePath != null, 'imagePath can not be null'),
        type = IMAvatarType.image,
        text = null,
        gradient = null,
        iconPath = null,
        iconColor = null,
        textStyle = null;

  /// 图标头像
  /// * [iconPath] - 头像图标
  /// * [bgColor] - 头像背景
  /// * [size] - 头像大小
  /// * [isCircle] - 是否为圆形头像(默认为[true])
  /// * [radius] - 圆角值(优先级高于[isCircle])
  const IMAvatar.icon({
    super.key,
    required this.iconPath,
    this.iconColor,
    this.bgColor,
    this.size = 40,
    this.bgSize = 60,
    this.isCircle = true,
    this.radius,
  })  : assert(iconPath != null, 'imagePath can not be null'),
        type = IMAvatarType.icon,
        text = null,
        gradient = null,
        imagePath = null,
        textStyle = null;

  /// 文件头像
  /// * [imagePath] - 文件图片
  /// * [size] - 文件图宽度
  /// * [text] - 文件描述
  /// * [textStyle] - 文件描述样式
  const IMAvatar.file({
    super.key,
    required this.imagePath,
    this.size = 40,
    this.text,
    this.textStyle = const TextStyle(
      fontSize: 14,
      color: Colors.white,
      height: 0,
    ),
  })  : type = IMAvatarType.file,
        bgSize = null,
        isCircle = false,
        iconPath = null,
        iconColor = null,
        bgColor = null,
        radius = null,
        gradient = null;

  /// 占位头像
  /// * [bgColor] - 占位背景色
  /// * [size] - 头像大小
  /// * [isCircle] - 是否为圆形头像(默认为[true])
  /// * [radius] - 圆角值(优先级高于[isCircle])
  const IMAvatar.placeholder({
    super.key,
    this.bgColor,
    this.size = 40,
    this.isCircle = true,
    this.radius,
  })  : type = IMAvatarType.placeholder,
        text = null,
        bgSize = null,
        textStyle = null,
        imagePath = null,
        iconPath = null,
        iconColor = null,
        gradient = null;

  /// 头像背景色
  final Color? bgColor;

  /// 渐变色
  final Gradient? gradient;

  /// 头像类型
  final IMAvatarType type;

  /// 头像图片
  final String? imagePath;

  /// 头像图标
  final IconData? iconPath;

  /// 图标颜色
  final Color? iconColor;

  /// 头像文字
  final String? text;

  /// 头像文字样式
  final TextStyle? textStyle;

  /// 头像大小
  final double? size;

  /// 背景大小
  final double? bgSize;

  /// 是否为圆形头像
  final bool? isCircle;

  /// 圆角值
  final double? radius;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case IMAvatarType.text:
        return _buildTextAvatar();
      case IMAvatarType.image:
        return _buildImageAvatar();
      case IMAvatarType.icon:
        return _buildIconAvatar(context);
      case IMAvatarType.file:
        return _buildFileAvatar();
      case IMAvatarType.placeholder:
        return _buildPlaceholderAvatar();
    }
  }

  /// 构建文字头像
  Widget _buildTextAvatar() {
    return Container(
      width: bgSize,
      height: bgSize,
      decoration: BoxDecoration(
        gradient: _getGradient(),
        shape: _getShape(),
        borderRadius: _getBorderRadius(),
      ),
      child: Center(
        child: Text(
          text ?? '',
          style: textStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  /// 构建图片头像
  Widget _buildImageAvatar() {
    return Container(
      width: bgSize,
      height: bgSize,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: bgColor,
        shape: _getShape(),
        borderRadius: _getBorderRadius(),
      ),
      child: Image.asset(
        imagePath!,
        width: size,
        height: size,
        fit: BoxFit.cover,
      ),
    );
  }

  /// 构建图标头像
  Widget _buildIconAvatar(BuildContext context) {
    return Container(
      width: bgSize,
      height: bgSize,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: bgColor,
        shape: _getShape(),
        borderRadius: _getBorderRadius(),
      ),
      child: Icon(
        iconPath!,
        size: size,
        color: IMTheme.of(context).brand1,
      ),
    );
  }

  /// 构建文件头像
  Widget _buildFileAvatar() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          imagePath!,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
        if (text != null) Text(text ?? '', style: textStyle)
      ],
    );
  }

  /// 构建占位头像
  Widget _buildPlaceholderAvatar() {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor ?? Color(0x1A121212),
        shape: _getShape(),
        borderRadius: _getBorderRadius(),
      ),
    );
  }

  /// 获取形状类型
  BoxShape _getShape() {
    if (radius != null) {
      return BoxShape.rectangle;
    }
    return isCircle == true ? BoxShape.circle : BoxShape.rectangle;
  }

  /// 获取边框圆角
  BorderRadius? _getBorderRadius() {
    if (radius != null) {
      return BorderRadius.circular(radius!);
    }
    if (isCircle == false) {
      return BorderRadius.circular(4.0);
    }
    return null;
  }

  /// 获取渐变
  Gradient _getGradient() {
    /// 预制的渐变色
    final List<Gradient> gradients = [
      LinearGradient(
          colors: [
            Color(0xFFFE9D7F),
            Color(0xFFF44545),
          ],
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter),
      LinearGradient(
          colors: [
            Color(0xFFFFE37F),
            Color(0xFFED940E),
          ],
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter),
      LinearGradient(
          colors: [
            Color(0xFFFFCE84),
            Color(0xFFEC6A21),
          ],
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter),
      LinearGradient(
          colors: [
            Color(0xFFAAF490),
            Color(0xFF35CF45),
          ],
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter),
      LinearGradient(
          colors: [
            Color(0xFF6BF0F9),
            Color(0xFF1EAECD),
          ],
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter),
      LinearGradient(
          colors: [
            Color(0xFF8DCFFF),
            Color(0xFF1C86E7),
          ],
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter),
      LinearGradient(
          colors: [
            Color(0xFF99B3FF),
            Color(0xFF5D5FF9),
          ],
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter),
      LinearGradient(
          colors: [
            Color(0xFFE69BF8),
            Color(0xFFAE4BD0),
          ],
          begin: AlignmentGeometry.topCenter,
          end: AlignmentGeometry.bottomCenter),
    ];

    return gradient ?? gradients[Random().nextInt(gradients.length - 1)];
  }
}
