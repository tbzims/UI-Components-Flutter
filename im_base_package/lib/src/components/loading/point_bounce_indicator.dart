import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

/// 点状弹跳加载指示器
class PointBounceIndicator extends StatefulWidget {
  final Color color;
  final double size;
  final int duration;

  const PointBounceIndicator({
    super.key,
    required this.color,
    required this.size,
    required this.duration,
  });

  @override
  State<PointBounceIndicator> createState() => _PointBounceIndicatorState();
}

class _PointBounceIndicatorState extends State<PointBounceIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    )..repeat();
  }

  @override
  void didUpdateWidget(covariant PointBounceIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller.duration = Duration(milliseconds: widget.duration);
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size * 2,
      height: widget.size,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(3, (i) {
          return ScaleTransition(
            scale: DelayTween(
              begin: 0.0,
              end: 1.0,
              delay: i * .2,
            ).animate(_controller),
            child: SizedBox.fromSize(
              size: Size.square(widget.size * 0.5),
              child: _itemBuilder(i),
            ),
          );
        }),
      ),
    );
  }

  Widget _itemBuilder(int index) {
    return DecoratedBox(
      decoration: BoxDecoration(color: widget.color, shape: BoxShape.circle),
    );
  }
}

class DelayTween extends Tween<double> {
  DelayTween({super.begin, super.end, required this.delay});

  final double delay;

  @override
  double lerp(double t) =>
      super.lerp((math.sin((t - delay) * 2 * math.pi) + 1) / 2);

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
