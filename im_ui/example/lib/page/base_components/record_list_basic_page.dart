import 'package:flutter/material.dart';
import 'package:im_ui/im_ui.dart';

class RecordListBasicPage extends StatefulWidget {
  const RecordListBasicPage({super.key});

  @override
  State<RecordListBasicPage> createState() => _RecordListBasicPageState();
}

class _RecordListBasicPageState extends State<RecordListBasicPage> {
  // 普通列表数据
  final List<String> _normalListItems = List.generate(20, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    final theme = IMTheme.of(context);
    return Scaffold(
      backgroundColor: theme.colorMap['whiteColor1'],
      appBar: AppBar(
        title: const Text('Basic Record List'),
        backgroundColor: theme.brandColor6,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '普通列表（无刷新加载）',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorMap['grayColor3']!),
                ),
                child: IMRecordList.noLoading(
                  items: _normalListItems
                      .map((item) => IMRecordItem(
                            title: item,
                            hasArrow: true,
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('点击了 $item')),
                              );
                            },
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}