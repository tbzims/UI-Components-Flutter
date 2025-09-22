import 'package:flutter/material.dart';
import 'package:im_ui/im_ui.dart';

class RecordListRefreshPage extends StatefulWidget {
  const RecordListRefreshPage({super.key});

  @override
  State<RecordListRefreshPage> createState() => _RecordListRefreshPageState();
}

class _RecordListRefreshPageState extends State<RecordListRefreshPage> {
  // 普通列表数据
  List<String> _normalListItems = List.generate(20, (index) => 'Item $index');
  int _page = 0;
  bool _noMoreData = false;

  @override
  Widget build(BuildContext context) {
    final theme = IMTheme.of(context);
    return Scaffold(
      backgroundColor: theme.colorMap['whiteColor1'],
      appBar: AppBar(
        title: const Text('Refresh Record List'),
        backgroundColor: theme.fontGyColor1,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '支持刷新和加载的列表',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            // Expanded(
            //   child: Container(
            //     decoration: BoxDecoration(
            //       border: Border.all(color: theme.colorMap['grayColor3']!),
            //     ),
            //     child: IMRecordList.loading(
            //       enablePullDown: true,
            //       enablePullUp: true,
            //       onRefresh: () async {
            //         // 模拟网络请求
            //         await Future.delayed(Duration(seconds: 2));
            //         // 随机成功或失败（1/3概率失败）
            //         bool success = DateTime.now().millisecond % 3 != 0;
            //
            //         if (success) {
            //           // 刷新成功，重置数据
            //           setState(() {
            //             _normalListItems = List.generate(
            //               20,
            //               (index) => 'Item $index',
            //             );
            //             _page = 0;
            //             _noMoreData = false;
            //           });
            //         }
            //
            //         return success;
            //       },
            //       onLoadMore: () async {
            //         // 模拟网络请求
            //         await Future.delayed(Duration(seconds: 2));
            //
            //         if (_noMoreData) {
            //           return null; // 没有更多数据
            //         }
            //
            //         setState(() {
            //           _page++;
            //           if (_page >= 3) {
            //             _noMoreData = true;
            //           }
            //
            //           // 添加新数据
            //           for (int i = 0; i < 5; i++) {
            //             _normalListItems.add('Item ${_normalListItems.length}');
            //           }
            //         });
            //         return true;
            //       },
            //       items: _normalListItems
            //           .map(
            //             (item) => IMRecordItem(
            //               title: item,
            //               hasArrow: true,
            //               onTap: () {
            //                 ScaffoldMessenger.of(context).showSnackBar(
            //                   SnackBar(content: Text('点击了 $item')),
            //                 );
            //               },
            //             ),
            //           )
            //           .toList(),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
