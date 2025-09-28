import 'package:flutter/material.dart';
import 'package:im_record_list/im_record_list.dart';

class BaseList extends StatelessWidget {
  const BaseList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'IM 基础列表示例',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
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
