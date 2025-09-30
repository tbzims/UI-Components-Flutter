// import 'package:flutter/material.dart';
//
// import '../../../im_base_package.dart';
//
// /// 骨架图动画
// enum IMSkeletonAnimation {
//   /// 渐变
//   gradient,
//
//   /// 闪烁
//   flashed,
// }
//
// /// 骨架图风格
// enum IMSkeletonTheme {
//   /// 头像
//   avatar,
//
//   /// 图片
//   image,
//
//   /// 文本
//   text,
//
//   /// 段落
//   paragraph,
// }
//
// class IMSkeleton extends StatefulWidget {
//   /// 骨架屏
//   /// * [animation] - 动画效果
//   /// * [delay] - 延迟显示加载时间
//   /// * [theme] - 骨架图风格
//   factory IMSkeleton({
//     Key? key,
//     IMSkeletonAnimation? animation,
//     int delay = 0,
//     IMSkeletonTheme theme = IMSkeletonTheme.text,
//   }) {
//     assert(delay >= 0);
//
//     // 根据风格创建骨架图
//     switch (theme) {
//       case IMSkeletonTheme.avatar:
//         return IMSkeleton.fromRowCol(
//           key: key,
//           animation: animation,
//           delay: delay,
//           rowCol: IMSkeletonRowCol(
//             objects: const [
//               [IMSkeletonRowColObj.circle()]
//             ],
//           ),
//         );
//       case IMSkeletonTheme.image:
//         return IMSkeleton.fromRowCol(
//           key: key,
//           animation: animation,
//           delay: delay,
//           rowCol: IMSkeletonRowCol(
//             objects: const [
//               [
//                 IMSkeletonRowColObj.rect(
//                   width: 72,
//                   height: 72,
//                   flex: null,
//                 )
//               ]
//             ],
//           ),
//         );
//       case IMSkeletonTheme.text:
//         return IMSkeleton.fromRowCol(
//           key: key,
//           animation: animation,
//           delay: delay,
//           rowCol: IMSkeletonRowCol(objects: const [
//             [
//               IMSkeletonRowColObj.text(flex: 24),
//               IMSkeletonRowColObj.spacer(width: 16),
//               IMSkeletonRowColObj.text(flex: 76),
//             ],
//             [IMSkeletonRowColObj.text()],
//           ]),
//         );
//       case IMSkeletonTheme.paragraph:
//         return IMSkeleton.fromRowCol(
//           key: key,
//           animation: animation,
//           delay: delay,
//           rowCol: IMSkeletonRowCol(objects: [
//             for (int i = 0; i < 3; i++) [const IMSkeletonRowColObj.text()],
//             const [
//               IMSkeletonRowColObj.text(flex: 55),
//               IMSkeletonRowColObj.spacer(flex: 45),
//             ],
//           ]),
//         );
//     }
//   }
//
//   /// 从行列框架创建骨架屏
//   /// * [animation] - 动画效果
//   /// * [delay] - 延迟显示加载时间
//   /// * [rowCol] - 自定义行列数量、宽度高度、间距等
//   const IMSkeleton.fromRowCol({
//     super.key,
//     this.animation,
//     this.delay = 0,
//     required this.rowCol,
//   }) : assert(delay >= 0);
//
//   /// 动画效果
//   final IMSkeletonAnimation? animation;
//
//   /// 延迟显示加载时间
//   final int delay;
//
//   /// 自定义行列数量、宽度高度、间距等
//   final IMSkeletonRowCol rowCol;
//
//   @override
//   State<IMSkeleton> createState() => _IMSkeletonState();
// }
//
// class _IMSkeletonState extends State<IMSkeleton>
//     with SingleTickerProviderStateMixin {
//   /// 动画控制器
//   late final AnimationController? _controller;
//
//   /// 动画效果
//   late final Animation<double>? _animation;
//
//   /// 加载状态
//   bool _isLoading = true;
//
//   /// 加载控件
//   static final _loadingWidget = Container();
//
//   /// 闪烁透明度
//   static const _animationFlashed = .3;
//
//   /// 静态渐变
//   static LinearGradient _animationGradient(BuildContext context) =>
//       LinearGradient(
//         colors: [
//           Colors.transparent,
//           IMTheme.of(context).fill3,
//           Colors.transparent,
//         ],
//         // 15 deg
//         begin: const Alignment(-1, -0.268),
//         end: const Alignment(1, 0.268),
//         tileMode: TileMode.clamp,
//       );
//
//   @override
//   void initState() {
//     super.initState();
//
//     // 根据动画效果创建动画控制器
//     switch (widget.animation) {
//       case IMSkeletonAnimation.gradient:
//         _controller = AnimationController(
//           duration: const Duration(milliseconds: 1500),
//           vsync: this,
//         )..repeat();
//         _animation = Tween<double>(begin: -1, end: 1).animate(_controller!)
//           ..addListener(() => setState(() {}));
//         break;
//       case IMSkeletonAnimation.flashed:
//         _controller = AnimationController(
//           duration: const Duration(seconds: 1),
//           vsync: this,
//         )..repeat(reverse: true);
//         _animation = Tween<double>(begin: 1, end: _animationFlashed)
//             .animate(_controller!)
//           ..addListener(() => setState(() {}));
//         break;
//       default:
//         _controller = null;
//         _animation = null;
//     }
//
//     Future.delayed(Duration(milliseconds: widget.delay),
//         () => setState(() => _isLoading = false));
//   }
//
//   /// 构建骨架屏对象
//   Widget _buildObj(BuildContext context, IMSkeletonRowColObj obj) {
//     // 骨架图对象
//     Widget skeletonObj = Container(
//       width: obj.width,
//       height: obj.height,
//       margin: obj.margin,
//       decoration: BoxDecoration(
//         color: obj.style.background(context),
//         borderRadius: BorderRadius.circular(obj.style.borderRadius(context)),
//       ),
//     );
//
//     // 动画效果
//     switch (widget.animation) {
//       case IMSkeletonAnimation.gradient:
//         skeletonObj = ShaderMask(
//           blendMode: BlendMode.srcATop,
//           shaderCallback: (bounds) => _animationGradient(context).createShader(
//             Rect.fromLTWH(
//               bounds.width * _animation!.value,
//               0,
//               bounds.width,
//               bounds.height,
//             ),
//           ),
//           child: skeletonObj,
//         );
//         break;
//       case IMSkeletonAnimation.flashed:
//         skeletonObj = Opacity(
//           opacity: _animation!.value,
//           child: skeletonObj,
//         );
//         break;
//       default:
//     }
//
//     // 根据弹性因子创建弹性布局
//     return obj.flex == null
//         ? skeletonObj
//         : Flexible(flex: obj.flex!, child: skeletonObj);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // 加载状态返回空容器
//     if (_isLoading) {
//       return _loadingWidget;
//     }
//
//     if (widget.rowCol.objects.length == 1) {
//       return widget.rowCol.objects.first.length == 1
//           // 单个对象
//           ? _buildObj(context, widget.rowCol.objects.first.first)
//           // 单行多个对象
//           : Row(
//               children: widget.rowCol.objects.first
//                   .map((obj) => _buildObj(context, obj))
//                   .toList(),
//             );
//     }
//
//     // 多行多个对象
//     List<Widget> skeletonRows = widget.rowCol.objects
//         .map((row) =>
//             Row(children: row.map((obj) => _buildObj(context, obj)).toList()))
//         .toList();
//     if (widget.rowCol.style.rowSpacing(context) > 0) {
//       skeletonRows = skeletonRows
//           .expand((row) =>
//               [row, SizedBox(height: widget.rowCol.style.rowSpacing(context))])
//           .toList()
//         ..removeLast();
//     } // 添加行间距
//     var skeletonRowCol =
//         Column(mainAxisSize: MainAxisSize.min, children: skeletonRows); // 行列布局
//
//     // 检查祖先是否有无限制的高度约束（例如在 SingleChildScrollView 中）
//     bool isInUnboundedHeightContext = false;
//     // 查找最近的 Scrollable 祖先
//     final scrollable = Scrollable.maybeOf(context);
//     if (scrollable != null) {
//       // 如果在可滚动组件中，检查主轴方向
//       if (scrollable.widget.axis == Axis.vertical) {
//         isInUnboundedHeightContext = true;
//       }
//     }
//
//     // 只有在父组件支持且不在无界高度环境中时才使用 Flexible
//     bool useFlexible = widget.rowCol.objects
//             .any((row) => row.any((obj) => obj.flex != null)) &&
//         !isInUnboundedHeightContext &&
//         (context.findAncestorWidgetOfExactType<Row>() != null ||
//             context.findAncestorWidgetOfExactType<Column>() != null ||
//             context.findAncestorWidgetOfExactType<Flex>() != null);
//
//     return useFlexible
//         ? Flexible(
//             child: Container(
//                 constraints: BoxConstraints(
//                     maxHeight: widget.rowCol.visualHeight(context)),
//                 child: skeletonRowCol))
//         : skeletonRowCol;
//   }
//
//   @override
//   void dispose() {
//     _controller?.dispose();
//     super.dispose();
//   }
// }
