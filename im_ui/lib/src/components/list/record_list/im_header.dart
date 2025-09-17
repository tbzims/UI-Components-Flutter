import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

import '../../../../im_ui.dart';

class ImHeader extends Header {
  ImHeader({
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
    this.enableInfiniteRefresh = false,
    bool? infiniteHitOver,
    this.overScroll = true,
    this.loadingIcon,
    this.backgroundColor,
    this.pullToRefreshText,
    this.releaseToRefreshText,
    this.refreshingText,
    this.refreshSuccessText,
    this.refreshFailedText,
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
       assert(
         extent != null &&
             ((clamping ?? float) ||
                 (triggerOffset ?? triggerDistance) >= extent),
         'The refresh indicator cannot take more space in its final state '
         'than the amount initially created by overscrolling.',
       ),
       super(
         triggerOffset: triggerOffset ?? triggerDistance,
         clamping: clamping ?? float,
         processedDuration:
             processedDuration ??
             completeDuration ??
             const Duration(seconds: 1),
         hapticFeedback: hapticFeedback ?? enableHapticFeedback,
         infiniteOffset: enableInfiniteRefresh ? infiniteOffset : null,
         infiniteHitOver: infiniteHitOver ?? overScroll,
       );

  /// Key
  final Key? key;

  /// 自定义loading样式
  final IMLoading? loadingIcon;

  /// 背景颜色
  final Color? backgroundColor;

  /// 下拉刷新文本
  final String? pullToRefreshText;

  /// 松手刷新文本
  final String? releaseToRefreshText;

  /// 刷新中文本
  final String? refreshingText;

  /// 刷新成功文本
  final String? refreshSuccessText;

  /// 刷新失败文本
  final String? refreshFailedText;

  /// 自定义文本样式
  final TextStyle? textStyle;

  /// 自定义图标类型
  final LoadingIcon? icon;

  /// 自定义图标颜色
  final Color? iconColor;

  /// Header容器高度
  final double? extent;

  /// 触发刷新任务的偏移量，同[triggerOffset]
  final double triggerDistance;

  /// 是否悬浮
  final bool float;

  /// 完成延时
  final Duration? completeDuration;

  /// 开启震动反馈
  final bool enableHapticFeedback;

  /// 是否开启无限刷新
  final bool enableInfiniteRefresh;

  /// 无限刷新偏移量
  @override
  final double? infiniteOffset;

  /// 越界滚动([enableInfiniteRefresh]为true或[infiniteOffset]有值时生效)
  final bool overScroll;

  @override
  Widget build(BuildContext context, IndicatorState state) {
    // 不能为水平方向
    assert(
      state.axisDirection == AxisDirection.down ||
          state.axisDirection == AxisDirection.up,
      'Widget cannot be horizontal',
    );
    return IMHeaderWidget(
      key: key,
      loadingIcon: loadingIcon,
      backgroundColor: backgroundColor,
      pullToRefreshText: pullToRefreshText,
      releaseToRefreshText: releaseToRefreshText,
      refreshingText: refreshingText,
      refreshSuccessText: refreshSuccessText,
      refreshFailedText: refreshFailedText,
      textStyle: textStyle,
      icon: icon,
      iconColor: iconColor,
      state: state,
      refreshIndicatorExtent: extent ?? state.triggerOffset,
    );
  }
}

/// 刷新头部组件
class IMHeaderWidget extends StatefulWidget {
  /// 自定义loading样式
  final IMLoading? loadingIcon;

  /// 背景颜色
  final Color? backgroundColor;

  /// 下拉刷新文本
  final String? pullToRefreshText;

  /// 松手刷新文本
  final String? releaseToRefreshText;

  /// 刷新中文本
  final String? refreshingText;

  /// 刷新成功文本
  final String? refreshSuccessText;

  /// 刷新失败文本
  final String? refreshFailedText;

  /// 自定义文本样式
  final TextStyle? textStyle;

  /// 自定义图标类型
  final LoadingIcon? icon;

  /// 自定义图标颜色
  final Color? iconColor;

  /// Indicator properties and state.
  final IndicatorState state;

  /// header高度
  final double refreshIndicatorExtent;

  const IMHeaderWidget({
    super.key,
    this.backgroundColor,
    this.pullToRefreshText,
    this.releaseToRefreshText,
    this.refreshingText,
    this.refreshSuccessText,
    this.refreshFailedText,
    this.textStyle,
    this.icon,
    this.iconColor,
    required this.state,
    required this.refreshIndicatorExtent,
    required this.loadingIcon,
  });

  @override
  IMHeaderWidgetState createState() {
    return IMHeaderWidgetState();
  }
}

class IMHeaderWidgetState extends State<IMHeaderWidget>
    with TickerProviderStateMixin {
  IndicatorMode get _refreshState => widget.state.mode;

  double get _offset => widget.state.offset;

  double get _actualTriggerOffset => widget.state.actualTriggerOffset;

  bool get _reverse => widget.state.reverse;

  double get _safeOffset => widget.state.safeOffset;

  Widget _buildLoading() {
    return IMLoading(
      icon: widget.icon ?? LoadingIcon.circle,
      iconColor: widget.iconColor ?? _getDefaultIconColor(),
      axis: Axis.horizontal,
      text: _getDefaultRefreshingText(),
      textStyle: widget.textStyle,
    );
  }

  /// 获取默认图标颜色
  Color _getDefaultIconColor() {
    try {
      return IMTheme.of(context).primary;
    } catch (e) {
      try {
        return Theme.of(context).primaryColor;
      } catch (e) {
        return Colors.blue;
      }
    }
  }

  /// 获取默认下拉刷新文本
  String _getDefaultPullToRefreshText() {
    try {
      return ImUiLocalizations.of(context).pullToRefresh;
    } catch (e) {
      return 'Pull to refresh';
    }
  }

  /// 获取默认松手刷新文本
  String _getDefaultReleaseToRefreshText() {
    try {
      return ImUiLocalizations.of(context).releaseToRefresh;
    } catch (e) {
      return 'Release to refresh';
    }
  }

  /// 获取默认刷新成功文本
  String _getDefaultRefreshSuccessText() {
    try {
      return ImUiLocalizations.of(context).refreshSuccess;
    } catch (e) {
      return 'Refresh completed';
    }
  }

  /// 获取正在刷新文本
  String _getDefaultRefreshingText() {
    try {
      return ImUiLocalizations.of(context).refreshing;
    } catch (e) {
      return 'Refreshing...';
    }
  }

  String _getString() {
    if (_refreshState == IndicatorMode.drag) {
      return _getDefaultPullToRefreshText();
    } else if (_refreshState == IndicatorMode.processed ||
        _refreshState == IndicatorMode.done) {
      return _getDefaultRefreshSuccessText();
    } else {
      return _getDefaultReleaseToRefreshText();
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
              height: widget.refreshIndicatorExtent,
              color: widget.backgroundColor,
              child: Visibility(
                visible:
                    _refreshState == IndicatorMode.processing ||
                    _refreshState == IndicatorMode.ready,
                replacement: Visibility(
                  visible: _refreshState != IndicatorMode.inactive,
                  child: Text(
                    _getString(),
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
