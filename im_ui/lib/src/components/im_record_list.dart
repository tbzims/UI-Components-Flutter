import 'package:flutter/material.dart';
import 'package:im_ui/generated/intl/app_localizations.dart';

/// 记录列表组件
class RecordList extends StatefulWidget {
  const RecordList({super.key});

  @override
  State<RecordList> createState() => _RecordListState();
}

class _RecordListState extends State<RecordList> {
  @override
  Widget build(BuildContext context) {
    final S = ImUiLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(color: Colors.yellowAccent),
      child: Text(
        S.appTitle + S.appCount("909-001"),
        style: TextStyle(color: Colors.red),
      ),
    );
  }
}
