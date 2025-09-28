import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:im_base_package/im_base_package.dart';

import 'im_index_list/im_indexes.dart';
import 'im_loading_list/im_footer.dart';
import 'im_loading_list/im_header.dart';

/// 列表类型
enum IMListType {
  /// 纯列表
  list,

  /// 有数据加载的
  loading,

  /// 有索引的
  indexed,
}

class IMRecordList extends StatefulWidget {

  /// 记录列表 - 普通列表
  /// * [bgColor] - 背景色
  /// * [listType] - 列表类型
  /// * [children] - 直接传入的子组件列表
  /// * [listHeight] - 列表高度
  /// * [itemCount] - 列表项数量
  /// * [itemExtent] - 列表项高度
  /// * [itemBuilder] - 列表项构建器
  const IMRecordList.list({
    super.key,
    this.bgColor,
    this.listType = IMListType.list,
    this.children,
    this.listHeight,
    this.itemCount,
    this.itemExtent,
    this.itemBuilder,
  })  : onRefresh = null,
        onLoadMore = null,
        customHeader = null,
        customFooter = null,
        enablePullDown = false,
        enablePullUp = false,
        indexedItems = null,
        indexList = null,
        indexBarBuilder = null;

  /// 列表类型 - 加载列表
  /// * [bgColor] - 背景色
  /// * [listType] - 列表类型
  /// * [children] - 直接传入的子组件列表
  /// * [enablePullDown] - 启用刷新
  /// * [onRefresh] - 刷新方法
  /// * [enablePullUp] - 启用加载
  /// * [onLoadMore] - 加载方法
  /// * [customHeader] - 自定义刷新样式
  /// * [customFooter] - 自定义加载样式
  /// * [listHeight] - 列表高度
  /// * [itemCount] - 列表项数量
  /// * [itemExtent] - 列表项高度
  /// * [itemBuilder] - 列表项构建器
  const IMRecordList.loading({
    super.key,
    this.bgColor,
    this.listType = IMListType.loading,
    this.children,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.onRefresh,
    this.onLoadMore,
    this.customHeader,
    this.customFooter,
    this.itemBuilder,
    this.itemCount,
    this.listHeight,
    this.itemExtent,
  })  : indexedItems = null,
        indexList = null,
        indexBarBuilder = null;

  /// 列表类型 - 加载列表
  /// * [bgColor] - 背景色
  /// * [listType] - 列表类型
  /// * [listHeight] - 列表高度
  /// * [itemExtent] - 列表项高度
  /// * [indexedItems] - 索引列表数据(格式: {'A': [Widget1, Widget2], 'B': [Widget3, Widget4]})
  /// * [indexList] - 索引列表
  /// * [indexBarBuilder] - 索引栏构建器
  const IMRecordList.indexed({
    super.key,
    this.bgColor,
    this.listType = IMListType.indexed,
    this.listHeight,
    this.itemExtent,
    required this.indexedItems,
    required this.indexList,
    this.indexBarBuilder,
  })  : children = null,
        onRefresh = null,
        onLoadMore = null,
        customHeader = null,
        customFooter = null,
        enablePullDown = false,
        enablePullUp = false,
        itemBuilder = null,
        itemCount = null;

  /// 背景色
  final Color? bgColor;

  /// 列表高度
  final double? listHeight;

  /// 列表类型
  final IMListType listType;

  /// 启用刷新 (仅用于loading类型)
  final bool enablePullDown;

  /// 启用加载更多 (仅用于loading类型)
  final bool enablePullUp;

  /// 刷新方法 (仅用于loading类型)
  final Future<bool?> Function()? onRefresh;

  /// 加载更多方法 没有数据返回 null (仅用于loading类型)
  final Future<bool?> Function()? onLoadMore;

  /// 自定义刷新样式 (仅用于loading类型)
  final ImHeader? customHeader;

  /// 自定义加载样式 (仅用于loading类型)
  final ImFooter? customFooter;

  /// 直接传入的子组件列表
  final List<Widget>? children;

  /// 列表项数量
  final int? itemCount;

  /// 构建每个列表项的回调 (用于builder和separated)
  final Widget? Function(BuildContext, int)? itemBuilder;

  /// 每个列表项的高度 (用于builder和separated)
  final double? itemExtent;

  /// 索引列表数据（用于indexed类型）
  /// 格式: {'A': [Widget1, Widget2], 'B': [Widget3, Widget4]}
  final Map<String, List<Widget>>? indexedItems;

  /// 索引列表（用于indexed类型）
  final List<String>? indexList;

  /// 索引栏构建器（用于indexed类型）
  final Widget Function(BuildContext, List<String>)? indexBarBuilder;

  @override
  State<IMRecordList> createState() => _IMRecordListState();
}

class _IMRecordListState extends State<IMRecordList> {
  late EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    // 只有在需要刷新和加载功能时才创建控制器
    if (_shouldUseEasyRefresh()) {
      _controller = EasyRefreshController(
          controlFinishRefresh: true, controlFinishLoad: true);
    }
  }

  // @override
  // void didUpdateWidget(covariant IMRecordList oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  // }

  @override
  void dispose() {
    // 只有在创建了控制器时才销毁它
    if (_shouldUseEasyRefresh()) {
      _controller.dispose();
    }
    super.dispose();
  }

  /// 判断是否应该使用EasyRefresh
  bool _shouldUseEasyRefresh() {
    return widget.listType == IMListType.loading &&
        (widget.enablePullDown || widget.enablePullUp);
  }

  /// 处理刷新逻辑
  Future<void> _handleRefresh() async {
    try {
      bool? refreshResult;
      if (widget.onRefresh != null) {
        refreshResult = await widget.onRefresh!();
      }

      // 根据结果完成刷新
      if (refreshResult == true) {
        // 刷新成功
        _controller.finishRefresh(IndicatorResult.success);
      } else if (refreshResult == false) {
        // 刷新失败
        _controller.finishRefresh(IndicatorResult.fail);
      } else {
        // 空数据或其他情况
        _controller.finishRefresh(IndicatorResult.noMore);
      }
    } catch (e) {
      // 刷新失败
      _controller.finishRefresh(IndicatorResult.fail);
    }
  }

  /// 处理加载更多逻辑
  Future<void> _handleLoadMore() async {
    try {
      bool? loadResult;
      if (widget.onLoadMore != null) {
        loadResult = await widget.onLoadMore!();
      }
      // 根据结果完成加载
      if (loadResult == true) {
        // 加载成功
        _controller.finishLoad(IndicatorResult.success);
      } else if (loadResult == false) {
        // 加载失败
        _controller.finishLoad(IndicatorResult.fail);
      } else {
        // 没有更多数据或其他情况
        _controller.finishLoad(IndicatorResult.noMore);
      }
    } catch (e) {
      // 加载失败
      _controller.finishLoad(IndicatorResult.fail);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 根据列表类型显示不同的内容
    Widget content;
    switch (widget.listType) {
      case IMListType.list:
      case IMListType.loading:
        content = _buildNormalList();
        break;
      case IMListType.indexed:
        content = _buildIndexedList();
        break;
    }
    return Container(
      height: widget.listHeight,
      color: widget.bgColor,
      child: content,
    );
  }

  /// 构建普通列表 (list和loading类型)
  Widget _buildNormalList() {
    ListView listView = ListView();

    if (widget.itemBuilder != null) {
      listView = ListView.builder(
        itemCount: widget.itemCount,
        itemExtent: widget.itemExtent,
        itemBuilder: (BuildContext context, int index) {
          return widget.itemBuilder!(context, index);
        },
      );
    }
    List<Widget> children = [];
    if (widget.children != null && widget.children!.isNotEmpty) {
      children.addAll(widget.children!);
      listView = ListView.builder(
        itemCount: children.length,
        itemExtent: widget.itemExtent,
        itemBuilder: (BuildContext context, int index) {
          return children[index];
        },
      );
    }

    // 如果没有数据，显示空状态
    if (children.isEmpty && widget.itemBuilder == null) {
      return _buildEmptyState();
    }

    // 只有在需要刷新或加载时才使用EasyRefresh (仅用于loading类型)
    if (widget.listType == IMListType.loading && _shouldUseEasyRefresh()) {
      return EasyRefresh(
        controller: _controller,
        header: widget.customHeader ?? ImHeader(),
        footer: widget.customFooter ?? ImFooter(),
        onRefresh: widget.enablePullDown && widget.onRefresh != null
            ? _handleRefresh
            : null,
        onLoad: widget.enablePullUp && widget.onLoadMore != null
            ? _handleLoadMore
            : null,
        child: listView,
      );
    } else {
      return listView;
    }
  }

  /// 构建空状态
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_dissatisfied,
            size: 64,
            color: IMTheme.of(context).brand1,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无数据',
            style: TextStyle(
              fontSize: 16,
              color: IMTheme.of(context).fontGyColor1,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建索引列表 (仅用于indexed类型)
  Widget _buildIndexedList() {
    // 检查必要的indexed类型参数
    if (widget.indexedItems == null || widget.indexList == null) {
      return _buildEmptyState();
    }

    return IMIndexes(
      indexList: widget.indexList,
      builderContent: (context, index) {
        if (widget.indexedItems!.containsKey(index)) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.indexedItems![index]!,
          );
        }
        return Container();
      },
    );
  }
}
