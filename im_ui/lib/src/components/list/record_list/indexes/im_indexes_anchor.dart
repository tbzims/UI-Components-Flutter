import 'package:flutter/material.dart';

/// 索引锚点
/// 移除了特定的字体、大小、颜色和圆角样式，使用默认值代替
class IMIndexesAnchor extends StatelessWidget {
  const IMIndexesAnchor({
    super.key,
    required this.sticky,
    required this.text,
    required this.capsuleTheme,
    this.builderAnchor,
    required this.activeIndex,
  });

  /// 索引是否吸顶
  final bool sticky;

  /// 锚点文本
  final String text;

  /// 是否为胶囊式样式
  final bool capsuleTheme;

  /// 选中索引
  final ValueNotifier<String> activeIndex;

  /// 索引锚点构建
  final Widget? Function(BuildContext context, String index, bool isPinnedToTop)? builderAnchor;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: activeIndex,
      builder: (context, value, child) {
        final isPinned = value == text;
        final customAnchor = builderAnchor?.call(context, text, isPinned);
        return customAnchor ??
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16), // 原EdgeInsets.symmetric(vertical: TDTheme.of(context).spacer4, horizontal: TDTheme.of(context).spacer16)
              margin: capsuleTheme ? const EdgeInsets.symmetric(horizontal: 12) : null, // 原TDTheme.of(context).spacer8
              decoration: BoxDecoration(
                color: isPinned ? Colors.white : const Color(0xFFf3f3f3), // 原isPinned ? TDTheme.of(context).whiteColor1 : TDTheme.of(context).grayColor1
                borderRadius: capsuleTheme ? const BorderRadius.all(Radius.circular(24)) : null, // 原BorderRadius.circular(TDTheme.of(context).radiusCircle)
                border: isPinned
                    ? capsuleTheme
                        ? Border.all(color: const Color(0xFFEEEEEE)) // 原TDTheme.of(context).grayColor1
                        : const Border(bottom: BorderSide(color: Color(0xFFEEEEEE))) // 原TDTheme.of(context).grayColor1
                    : null,
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: isPinned ? 16 : 14, // 原isPinned ? TDTheme.of(context).fontMarkMedium : TDTheme.of(context).fontTitleSmall
                  color: isPinned ? const Color(0xFF0052D9) : Colors.black54, // 原isPinned ? TDTheme.of(context).brandColor7 : TDTheme.of(context).fontGyColor1
                  fontWeight: isPinned ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            );
      },
    );
  }
}