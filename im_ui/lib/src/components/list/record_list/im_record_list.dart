import 'package:flutter/material.dart';
import 'package:im_ui/im_ui.dart';
import 'package:easy_refresh/easy_refresh.dart';

import 'indexes/im_indexes.dart';

/// 列表类型
enum ListType {
  /// 有数据加载的
  loading,

  /// 无数据加载的
  noLoading,

  /// 有索引的
  indexed,
}

class IMRecordList extends StatefulWidget {
  const IMRecordList({
    super.key,
    this.listType = ListType.loading,
    this.enablePullDown = false,
    this.enablePullUp = false,
    this.onRefresh,
    this.customHeader,
    this.onLoadMore,
    this.customFooter,
    this.items,
    this.customItems,
    this.hasBorder = false,
    this.customBorder,
    this.indexedItems,
    this.indexList,
    this.indexBarBuilder,
  });

  /// 用于loading类型的构造函数
  const IMRecordList.loading({
    super.key,
    this.enablePullDown = false,
    this.enablePullUp = false,
    this.onRefresh,
    this.customHeader,
    this.onLoadMore,
    this.customFooter,
    this.items,
    this.customItems,
    this.hasBorder = false,
    this.customBorder,
    this.indexedItems,
    this.indexList,
    this.indexBarBuilder,
  }) : listType = ListType.loading;

  /// 用于noLoading类型的构造函数
  const IMRecordList.noLoading({
    super.key,
    this.items,
    this.customItems,
    this.hasBorder = false,
    this.customBorder,
    this.indexedItems,
    this.indexList,
    this.indexBarBuilder,
    this.enablePullDown = false,
    this.enablePullUp = false,
    this.onRefresh,
    this.customHeader,
    this.onLoadMore,
    this.customFooter,
  }) : listType = ListType.noLoading;

  /// 用于indexed类型的构造函数
  const IMRecordList.indexed({
    super.key,
    this.indexedItems,
    this.indexList,
    this.indexBarBuilder,
    this.items,
    this.customItems,
    this.hasBorder = false,
    this.customBorder,
    this.enablePullDown = false,
    this.enablePullUp = false,
    this.onRefresh,
    this.customHeader,
    this.onLoadMore,
    this.customFooter,
  }) : listType = ListType.indexed;

  /// 列表类型
  final ListType listType;

  /// 启用刷新 (仅用于loading类型)
  final bool enablePullDown;

  /// 启用加载更多 (仅用于loading类型)
  final bool enablePullUp;

  /// 刷新方法 (仅用于loading类型)
  final Future<bool?> Function()? onRefresh;

  /// 自定义刷新样式 (仅用于loading类型)
  final ImHeader? customHeader;

  /// 加载更多方法 没有数据返回 null (仅用于loading类型)
  final Future<bool?> Function()? onLoadMore;

  /// 自定义加载样式 (仅用于loading类型)
  final ImFooter? customFooter;

  /// 列表子类 (用于loading和noLoading类型)
  final List<IMRecordItem>? items;

  /// 自定义Item (用于loading和noLoading类型)
  final List<Widget>? customItems;

  /// 是否有边框 (用于loading和noLoading类型)
  final bool hasBorder;

  /// 自定义边框样式 (用于loading和noLoading类型)
  final BoxBorder? customBorder;

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
      _controller = EasyRefreshController(controlFinishRefresh: true, controlFinishLoad: true);
    }
  }

  @override
  void didUpdateWidget(covariant IMRecordList oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

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
    return widget.listType == ListType.loading &&
        (widget.enablePullDown || widget.enablePullUp);
  }

  get _boxBorder {
    if (widget.customBorder != null) {
      return widget.customBorder;
    }
    if (widget.hasBorder) {
      return Border.all(
        color: IMTheme.of(context).colorMap['brandColor7']!,
        width: 1,
      );
    }
    return null;
  }

  /// 构建普通列表 (loading和noLoading类型)
  Widget _buildNormalList() {
    List<Widget> children = [];
    if (widget.items != null) {
      children.addAll(widget.items!);
    }
    if (widget.customItems != null) {
      children.addAll(widget.customItems!);
    }

    // 如果没有数据，显示空状态
    if (children.isEmpty) {
      return _buildEmptyState();
    }

    // 只有在需要刷新或加载时才使用EasyRefresh (仅用于loading类型)
    if (widget.listType == ListType.loading && _shouldUseEasyRefresh()) {
      return EasyRefresh(
        controller: _controller,
        header: widget.customHeader ?? ImHeader(),
        footer: widget.customFooter ?? ImFooter(),
        onRefresh:
            widget.enablePullDown && widget.onRefresh != null
                ? _handleRefresh
                : null,
        onLoad:
            widget.enablePullUp && widget.onLoadMore != null
                ? _handleLoadMore
                : null,
        child: ListView.builder(
          itemCount: children.length,
          itemBuilder: (BuildContext context, int index) {
            return children[index];
          },
        ),
      );
    } else {
      // 不需要刷新和加载时直接使用ListView (用于noLoading类型)
      return ListView.builder(
        itemCount: children.length,
        itemBuilder: (BuildContext context, int index) {
          return children[index];
        },
      );
    }
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

  /// 构建空状态
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sentiment_dissatisfied,
            size: 64,
            color: IMTheme.of(context).colorMap['fontGyColor2'],
          ),
          const SizedBox(height: 16),
          Text(
            '暂无数据',
            style: TextStyle(
              fontSize: 16,
              color: IMTheme.of(context).colorMap['fontGyColor2'],
            ),
          ),
        ],
      ),
    );
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
      print(e.toString());
      // 加载失败
      _controller.finishLoad(IndicatorResult.fail);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 根据列表类型显示不同的内容
    Widget content;
    switch (widget.listType) {
      case ListType.loading:
      case ListType.noLoading:
        content = _buildNormalList();
        break;
      case ListType.indexed:
        content = _buildIndexedList();
        break;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(border: _boxBorder),
      child: content,
    );
  }
}
