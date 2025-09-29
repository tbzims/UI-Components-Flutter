import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:im_base_package/im_base_package.dart';


/// 上拉加载更多组件
class ImFooter extends Footer {
  ImFooter({
    this.key,
    this.extent = 48.0,
    double? triggerOffset,
    this.triggerDistance = 48.0,
    bool? clamping,
    this.float = false,
    Duration? processedDuration,
    this.completeDuration,
    bool? hapticFeedback,
    this.enableHapticFeedback = true,
    this.infiniteOffset,
    this.enableInfiniteLoad = true,
    bool? infiniteHitOver,
    this.overScroll = true,
    this.loadingIcon,
    this.backgroundColor,
    this.pullToLoadText,
    this.releaseToLoadText,
    this.loadingText,
    this.loadSuccessText,
    this.loadFailedText,
    this.noMoreText,
    this.textStyle,
    this.icon,
    this.iconColor,
    super.spring,
    super.horizontalSpring,
    super.readySpringBuilder,
    super.horizontalReadySpringBuilder,
    super.springRebound,
    super.frictionFactor,
    super.horizontalFrictionFactor,
    super.safeArea = false,
    super.hitOver,
    super.position,
    super.secondaryTriggerOffset,
    super.secondaryVelocity,
    super.secondaryDimension,
    super.secondaryCloseTriggerOffset,
    super.notifyWhenInvisible,
    super.listenable,
    super.triggerWhenReach,
    super.triggerWhenRelease,
    super.triggerWhenReleaseNoWait,
    super.maxOverOffset,
  }) : assert((triggerOffset ?? triggerDistance) > 0.0),
       assert(extent != null && extent >= 0.0),
       super(
         triggerOffset: triggerOffset ?? triggerDistance,
         clamping: clamping ?? float,
         processedDuration:
             processedDuration ??
             completeDuration ??
             const Duration(seconds: 1),
         hapticFeedback: hapticFeedback ?? enableHapticFeedback,
         infiniteOffset: enableInfiniteLoad ? infiniteOffset : null,
         infiniteHitOver: infiniteHitOver ?? overScroll,
       );

  /// Key
  final Key? key;

  /// 自定义loading样式
  final IMLoading? loadingIcon;

  /// 背景颜色
  final Color? backgroundColor;

  /// 上拉加载文本
  final String? pullToLoadText;

  /// 松手加载文本
  final String? releaseToLoadText;

  /// 加载中文本
  final String? loadingText;

  /// 加载成功文本
  final String? loadSuccessText;

  /// 加载失败文本
  final String? loadFailedText;

  /// 没有更多数据文本
  final String? noMoreText;

  /// 自定义文本样式
  final TextStyle? textStyle;

  /// 自定义图标类型
  final LoadingStyle? icon;

  /// 自定义图标颜色
  final Color? iconColor;

  /// Footer容器高度
  final double? extent;

  /// 触发加载任务的偏移量，同[triggerOffset]
  final double triggerDistance;

  /// 是否悬浮
  final bool float;

  /// 完成延时
  final Duration? completeDuration;

  /// 开启震动反馈
  final bool enableHapticFeedback;

  /// 是否开启无限加载
  final bool enableInfiniteLoad;

  /// 无限加载偏移量
  @override
  final double? infiniteOffset;

  /// 越界滚动
  final bool overScroll;

  @override
  Widget build(BuildContext context, IndicatorState state) {
    // 不能为水平方向
    assert(
      state.axisDirection == AxisDirection.down ||
          state.axisDirection == AxisDirection.up,
      'Widget cannot be horizontal',
    );
    return IMFooterWidget(
      key: key,
      loadingIcon: loadingIcon,
      backgroundColor: backgroundColor,
      pullToLoadText: pullToLoadText,
      releaseToLoadText: releaseToLoadText,
      loadingText: loadingText,
      loadSuccessText: loadSuccessText,
      loadFailedText: loadFailedText,
      noMoreText: noMoreText,
      textStyle: textStyle,
      icon: icon,
      iconColor: iconColor,
      state: state,
      loadIndicatorExtent: extent ?? state.triggerOffset,
    );
  }
}

/// 加载底部组件
class IMFooterWidget extends StatefulWidget {
  /// 自定义loading样式
  final IMLoading? loadingIcon;

  /// 背景颜色
  final Color? backgroundColor;

  /// 上拉加载文本
  final String? pullToLoadText;

  /// 松手加载文本
  final String? releaseToLoadText;

  /// 加载中文本
  final String? loadingText;

  /// 加载成功文本
  final String? loadSuccessText;

  /// 加载失败文本
  final String? loadFailedText;

  /// 没有更多数据文本
  final String? noMoreText;

  /// 自定义文本样式
  final TextStyle? textStyle;

  /// 自定义图标类型
  final LoadingStyle? icon;

  /// 自定义图标颜色
  final Color? iconColor;

  /// Indicator properties and state.
  final IndicatorState state;

  /// footer高度
  final double loadIndicatorExtent;

  const IMFooterWidget({
    super.key,
    this.backgroundColor,
    this.pullToLoadText,
    this.releaseToLoadText,
    this.loadingText,
    this.loadSuccessText,
    this.loadFailedText,
    this.noMoreText,
    this.textStyle,
    this.icon,
    this.iconColor,
    required this.state,
    required this.loadIndicatorExtent,
    required this.loadingIcon,
  });

  @override
  IMFooterWidgetState createState() {
    return IMFooterWidgetState();
  }
}

class IMFooterWidgetState extends State<IMFooterWidget>
    with TickerProviderStateMixin {
  IndicatorMode get _loadState => widget.state.mode;

  IndicatorResult get _result => widget.state.result;

  double get _offset => widget.state.offset;

  double get _actualTriggerOffset => widget.state.actualTriggerOffset;

  bool get _reverse => widget.state.reverse;

  double get _safeOffset => widget.state.safeOffset;

  Widget _buildLoading() {
    return IMLoading(
      iconType: widget.icon ?? LoadingStyle.point,
      iconColor: widget.iconColor ?? _getDefaultIconColor(),
      axis: Axis.horizontal,
      text: widget.loadingText,
      textStyle: widget.textStyle,
    );
  }

  /// 获取默认上拉加载文本
  String _getDefaultPullToLoadText() {
    try {
      return ImUiLocalizations.of(context).pullToLoad;
    } catch (e) {
      return 'Pull to load more';
    }
  }

  /// 获取默认松手加载文本
  String _getDefaultReleaseToLoadText() {
    try {
      return ImUiLocalizations.of(context).releaseToLoad;
    } catch (e) {
      return 'Release to load more';
    }
  }

  /// 获取默认加载成功文本
  String _getDefaultLoadSuccessText() {
    try {
      return ImUiLocalizations.of(context).loadSuccess;
    } catch (e) {
      return 'Load success';
    }
  }

  /// 获取默认加载失败文本
  String _getDefaultLoadFailedText() {
    try {
      return ImUiLocalizations.of(context).loadFailed;
    } catch (e) {
      return 'Load failed';
    }
  }

  String _getDefaultNoMoreText() {
    try {
      return ImUiLocalizations.of(context).noMore;
    } catch (e) {
      return 'No more data';
    }
  }

  String _getText() {
    // 根据IndicatorResult显示对应文本
    switch (_result) {
      case IndicatorResult.success:
        return widget.loadSuccessText ?? _getDefaultLoadSuccessText();
      case IndicatorResult.fail:
        return widget.loadFailedText ?? _getDefaultLoadFailedText();
      case IndicatorResult.noMore:
        return widget.noMoreText ?? _getDefaultNoMoreText();
      case IndicatorResult.none:
        if (_loadState == IndicatorMode.drag) {
          return _getDefaultPullToLoadText();
        } else if (_loadState == IndicatorMode.processed ||
            _loadState == IndicatorMode.done) {
          return _getDefaultLoadSuccessText();
        } else {
          return _getDefaultReleaseToLoadText();
        }
    }
  }

  /// 获取默认图标颜色
  Color _getDefaultIconColor() {
    try {
      return IMTheme.of(context).brand1;
    } catch (e) {
      try {
        return Theme.of(context).primaryColor;
      } catch (e) {
        return Colors.blue;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _offset,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: _getTopPosition(),
            bottom: _getBottomPosition(),
            height: _getHeight(),
            child: Container(
              alignment: Alignment.center,
              height: widget.loadIndicatorExtent,
              color: widget.backgroundColor,
              child: Visibility(
                visible:
                    _loadState == IndicatorMode.processing ||
                    _loadState == IndicatorMode.ready,
                replacement: Visibility(
                  visible: _loadState != IndicatorMode.inactive,
                  child: Text(
                    _getText(),
                    style:
                        widget.textStyle ??
                        TextStyle(color: _getDefaultIconColor(), fontSize: 16),
                  ),
                ),
                child: Container(child: _buildLoading()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 获取Positioned组件的top值
  double _getTopPosition() {
    if (_offset < _actualTriggerOffset) {
      return -(_actualTriggerOffset -
              _offset +
              (_reverse ? _safeOffset : -_safeOffset)) /
          2;
    } else {
      return !_reverse ? _safeOffset : 0;
    }
  }

  /// 获取Positioned组件的bottom值
  double? _getBottomPosition() {
    if (_offset < _actualTriggerOffset) {
      return null;
    } else {
      return _reverse ? _safeOffset : 0;
    }
  }

  /// 获取Positioned组件的height值
  double? _getHeight() {
    if (_offset < _actualTriggerOffset) {
      return _actualTriggerOffset;
    } else {
      return null;
    }
  }
}
