import 'package:flutter/material.dart';
import 'package:snto_im_ui/generated/intl/app_localizations.dart';

/// 记录列表组件
class SntoRecordList extends StatefulWidget {
  const SntoRecordList({super.key});

  @override
  State<SntoRecordList> createState() => _SntoRecordListState();
}

class _SntoRecordListState extends State<SntoRecordList> {
  @override
  Widget build(BuildContext context) {
    final S = SntoImUiLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(color: Colors.yellowAccent),
      child: Text(
        S.appTitle + S.appCount("909-001"),
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
