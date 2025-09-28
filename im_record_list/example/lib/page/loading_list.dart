import 'package:flutter/material.dart';
import 'package:im_record_list/im_record_list.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  // 普通列表数据
  List<String> _normalListItems = List.generate(20, (index) => 'Item $index');
  int _page = 0;
  bool _noMoreData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'IM 刷新列表示例',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
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
            Expanded(
              child: IMRecordList.loading(
                enablePullDown: true,
                enablePullUp: true,
                onRefresh: () async {
                  // 模拟网络请求
                  await Future.delayed(Duration(seconds: 2));
                  // 随机成功或失败（1/3概率失败）
                  bool success = DateTime.now().millisecond % 3 != 0;

                  if (success) {
                    // 刷新成功，重置数据
                    setState(() {
                      _normalListItems = List.generate(
                        20,
                        (index) => 'Item $index',
                      );
                      _page = 0;
                      _noMoreData = false;
                    });
                  }

                  return success;
                },
                onLoadMore: () async {
                  // 模拟网络请求
                  await Future.delayed(Duration(seconds: 2));

                  if (_noMoreData) {
                    return null; // 没有更多数据
                  }

                  setState(() {
                    _page++;
                    if (_page >= 3) {
                      _noMoreData = true;
                    }

                    // 添加新数据
                    for (int i = 0; i < 5; i++) {
                      _normalListItems.add('Item ${_normalListItems.length}');
                    }
                  });
                  return true;
                },
                itemCount: _normalListItems.length,
                itemBuilder: (context, index) {
                  return IMRecordItem(
                    titleWidget: Text(
                      _normalListItems[index],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
