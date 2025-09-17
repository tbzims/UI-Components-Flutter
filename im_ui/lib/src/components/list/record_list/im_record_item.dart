import 'package:flutter/material.dart';
import 'package:im_ui/im_ui.dart';

class IMRecordItem extends StatefulWidget {
  const IMRecordItem({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.hasArrow = false,
    this.onTap,
    this.customWidget,
  });

  /// 标题
  final String? title;

  /// 副标题
  final String? subtitle;

  /// 左侧widget
  final Widget? leading;

  /// 右侧widget
  final Widget? trailing;

  /// 是否有箭头
  final bool hasArrow;

  /// 点击事件
  final VoidCallback? onTap;

  /// 自定义widget
  final Widget? customWidget;

  @override
  State<IMRecordItem> createState() => _IMRecordItemState();
}

class _IMRecordItemState extends State<IMRecordItem> {
  @override
  Widget build(BuildContext context) {
    // 如果有自定义widget，直接返回
    if (widget.customWidget != null) {
      return widget.customWidget!;
    }

    final theme = IMTheme.of(context);
    
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.colorMap['grayColor3']!,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            // 左侧widget
            if (widget.leading != null) ...[
              widget.leading!,
              SizedBox(width: 12),
            ],
            
            // 中间内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.title != null)
                    Text(
                      widget.title!,
                      style: TextStyle(
                        fontSize: 16,
                        color: theme.colorMap['fontGyColor1'],
                      ),
                    ),
                  if (widget.subtitle != null)
                    Text(
                      widget.subtitle!,
                      style: TextStyle(
                        fontSize: 14,
                        color: theme.colorMap['fontGyColor2'],
                      ),
                    ),
                ],
              ),
            ),
            
            // 右侧widget
            if (widget.trailing != null) ...[
              widget.trailing!,
              SizedBox(width: 8),
            ],
            
            // 箭头图标
            if (widget.hasArrow)
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: theme.colorMap['fontGyColor3'],
              ),
          ],
        ),
      ),
    );
  }
}