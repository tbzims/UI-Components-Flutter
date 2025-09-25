import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'basic.dart';
import 'im_theme.dart';

/// 字体大小扩展
extension ImFonts on IMThemeData {
  /// 判断是否为移动端平台
  bool get _isMobile {
    if (kIsWeb) return false;
    return Platform.isIOS || Platform.isAndroid;
  }

  /// 获取标题超大号字体 (移动端和PC端自动区分)
  Font? get headlineSuperLargeX => _isMobile
      ? fontMap['mobile_headlineSuperLargeX']
      : fontMap['pc_headlineSuperLargeX'];

  /// 获取标题超大号字体
  Font? get headlineSuperLarge => _isMobile
      ? fontMap['mobile_headlineSuperLarge']
      : fontMap['pc_headlineSuperLarge'];

  /// 获取标题大号字体
  Font? get headlineLarge => _isMobile
      ? fontMap['mobile_headlineLarge']
      : fontMap['pc_headlineLarge'];

  /// 获取标题中号字体
  Font? get headlineMedium => _isMobile
      ? fontMap['mobile_headlineMedium']
      : fontMap['pc_headlineMedium'];

  /// 获取标题小号字体
  Font? get headlineSmall => _isMobile
      ? fontMap['mobile_headlineSmall']
      : fontMap['pc_headlineSmall'];

  /// 获取标题最小号字体
  Font? get headlineMin => _isMobile
      ? fontMap['mobile_headlineMin']
      : fontMap['pc_headlineMin'];

  /// 获取标题大号字体
  Font? get titleLarge => _isMobile
      ? fontMap['mobile_titleLarge']
      : fontMap['pc_titleLarge'];

  /// 获取标题中号字体
  Font? get titleMedium => _isMobile
      ? fontMap['mobile_titleMedium']
      : fontMap['pc_titleMedium'];

  /// 获取标题小号字体
  Font? get titleSmall => _isMobile
      ? fontMap['mobile_titleSmall']
      : fontMap['pc_titleSmall'];

  /// 获取标题最小号字体
  Font? get titleMin => _isMobile
      ? fontMap['mobile_titleMin']
      : fontMap['pc_titleMin'];

  /// 获取正文大号字体
  Font? get bodyContentLarge => _isMobile
      ? fontMap['mobile_bodyContentLarge']
      : fontMap['pc_bodyContentLarge'];

  /// 获取正文内容字体
  Font? get bodyContent => _isMobile
      ? fontMap['mobile_bodyContent']
      : fontMap['pc_bodyContent'];

  /// 获取辅助文字字体
  Font? get auxiliaryText => _isMobile
      ? fontMap['mobile_auxiliaryText']
      : fontMap['pc_auxiliaryText'];

  /// 获取小号辅助文字字体 (移动端特有)
  Font? get auxiliaryTextSmall => fontMap['mobile_auxiliaryTextSmall'];

  /// 获取说明文字字体
  Font? get captionText => _isMobile
      ? fontMap['mobile_captionText']
      : fontMap['pc_captionText'];
}
