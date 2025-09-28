import 'package:flutter/material.dart';
import 'package:im_base_package/im_base_package.dart';
import 'package:im_record_list/im_record_list.dart';

class BaseList extends StatelessWidget {
  const BaseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: IMTheme.of(context).brand6,
        appBar: AppBar(
          title: const Text('基础列表示例'),
          backgroundColor: IMTheme.of(context).brand1,
        ),
      body: Column(
        children: [
          Expanded(
            child: IMRecordList.list(
              children: [
                IMRecordItem.base(
                  enableSwipe: true,
                  groupTag: '1',
                  extentRatio: 0.25,
                  swipeActions: [
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.zero,
                      label: '1',
                    ),
                  ],
                ),
                IMRecordItem.iconData(
                  enableSwipe: true,
                  groupTag: '1',
                  extentRatio: 0.25,
                  swipeActions: [
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.zero,
                      label: '1',
                    ),
                  ],
                ),
                IMRecordItem.avatarData(
                  enableSwipe: true,
                  groupTag: '1',
                  extentRatio: 0.25,
                  swipeActions: [
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.zero,
                      label: '1',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
