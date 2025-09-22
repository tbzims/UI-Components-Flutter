// import 'package:flutter/material.dart';
// import 'package:im_ui/im_ui.dart';
//
// class RecordItem extends StatelessWidget {
//   const RecordItem({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Record Item')),
//       body: IMRecordList.noLoading(
//         items: [
//           IMRecordItem(
//             title: '基础列表项',
//             subtitle: '这是一个基础的列表项，没有边框和特殊样式',
//             onTap: () {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(const SnackBar(content: Text('点击了基础列表项')));
//             },
//           ),
//           IMRecordItem(
//             title: '带边框的列表项',
//             subtitle: '这个列表项有自定义边框',
//             hasBorder: true,
//             borderColor: Colors.blue,
//             borderWidth: 2.0,
//             onTap: () {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(const SnackBar(content: Text('点击了带边框的列表项')));
//             },
//           ),
//           IMRecordItem(
//             title: '自定义分割线',
//             subtitle: '这个列表项有自定义分割线样式',
//             hasDivider: true,
//             dividerColor: Colors.red,
//             dividerThickness: 2.0,
//             dividerIndent: 20.0,
//             dividerEndIndent: 20.0,
//             onTap: () {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(const SnackBar(content: Text('点击了自定义分割线的列表项')));
//             },
//           ),
//           IMRecordItem.slidable(
//             title: '左侧滑动项',
//             subtitle: '向右滑动显示操作按钮',
//             swipeDirection: SwipeDirection.left,
//             swipeActions: [
//               SlidableAction(
//                 onPressed: (context) {
//                   ScaffoldMessenger.of(
//                     context,
//                   ).showSnackBar(const SnackBar(content: Text('点击了删除按钮')));
//                 },
//                 backgroundColor: Colors.red,
//                 foregroundColor: Colors.white,
//                 icon: Icons.delete,
//                 label: '删除',
//               ),
//               SlidableAction(
//                 onPressed: (context) {
//                   ScaffoldMessenger.of(
//                     context,
//                   ).showSnackBar(const SnackBar(content: Text('点击了编辑按钮')));
//                 },
//                 backgroundColor: Colors.blue,
//                 foregroundColor: Colors.white,
//                 icon: Icons.edit,
//                 label: '编辑',
//               ),
//             ],
//             onTap: () {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(const SnackBar(content: Text('点击了左侧滑动项')));
//             },
//           ),
//           IMRecordItem.slidable(
//             title: '右侧滑动项',
//             subtitle: '向左滑动显示操作按钮',
//             swipeDirection: SwipeDirection.right,
//             swipeActions: [
//               SlidableAction(
//                 onPressed: (context) {
//                   ScaffoldMessenger.of(
//                     context,
//                   ).showSnackBar(const SnackBar(content: Text('点击了收藏按钮')));
//                 },
//                 backgroundColor: Colors.orange,
//                 foregroundColor: Colors.white,
//                 icon: Icons.star,
//                 label: '收藏',
//               ),
//               SlidableAction(
//                 onPressed: (context) {
//                   ScaffoldMessenger.of(
//                     context,
//                   ).showSnackBar(const SnackBar(content: Text('点击了分享按钮')));
//                 },
//                 backgroundColor: Colors.green,
//                 foregroundColor: Colors.white,
//                 icon: Icons.share,
//                 label: '分享',
//               ),
//             ],
//             onTap: () {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(const SnackBar(content: Text('点击了右侧滑动项')));
//             },
//           ),
//           IMRecordItem.slidable(
//             title: '左右侧滑动项',
//             subtitle: '左右滑动显示不同的操作按钮',
//             swipeDirection: SwipeDirection.both,
//             swipeActions: [
//               SlidableAction(
//                 onPressed: (context) {
//                   ScaffoldMessenger.of(
//                     context,
//                   ).showSnackBar(const SnackBar(content: Text('左侧：点击了归档按钮')));
//                 },
//                 backgroundColor: Colors.grey,
//                 foregroundColor: Colors.white,
//                 icon: Icons.archive,
//                 label: '归档',
//               ),
//               SlidableAction(
//                 onPressed: (context) {
//                   ScaffoldMessenger.of(
//                     context,
//                   ).showSnackBar(const SnackBar(content: Text('右侧：点击了删除按钮')));
//                 },
//                 backgroundColor: Colors.red,
//                 foregroundColor: Colors.white,
//                 icon: Icons.delete,
//                 label: '删除',
//               ),
//               SlidableAction(
//                 onPressed: (context) {
//                   ScaffoldMessenger.of(
//                     context,
//                   ).showSnackBar(const SnackBar(content: Text('右侧：点击了编辑按钮')));
//                 },
//                 backgroundColor: Colors.blue,
//                 foregroundColor: Colors.white,
//                 icon: Icons.edit,
//                 label: '编辑',
//               ),
//             ],
//             onTap: () {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(const SnackBar(content: Text('点击了左右侧滑动项')));
//             },
//           ),
//           IMRecordItem(
//             customWidget: Container(
//               padding: const EdgeInsets.all(16),
//               color: Colors.yellow.withOpacity(0.3),
//               child: const Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(Icons.warning, color: Colors.orange),
//                   SizedBox(width: 12),
//                   Expanded(
//                     child: Text(
//                       '这是一个完全自定义的列表项',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             hasDivider: false,
//             onTap: () {
//               ScaffoldMessenger.of(
//                 context,
//               ).showSnackBar(const SnackBar(content: Text('点击了自定义Widget的列表项')));
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
