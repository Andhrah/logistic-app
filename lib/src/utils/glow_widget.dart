import 'dart:async';

import 'package:flutter/material.dart';

class CircularGlow extends StatefulWidget {
  final Widget child;
  final double endRadius;
  final BoxShape shape;
  final Duration duration;
  final bool repeat;
  final bool reverse;
  final bool animate;
  final Duration repeatPauseDuration;
  final Curve curve;
  final bool showTwoGlows;
  final Color glowColor;
  final Duration? startDelay;

  const CircularGlow({
    Key? key,
    required this.child,
    required this.endRadius,
    this.shape = BoxShape.circle,
    this.duration = const Duration(milliseconds: 2000),
    this.repeat = true,
    this.reverse = false,
    this.animate = true,
    this.repeatPauseDuration = const Duration(milliseconds: 100),
    this.curve = Curves.fastOutSlowIn,
    this.showTwoGlows = true,
    this.glowColor = Colors.white,
    this.startDelay,
  }) : super(key: key);

  @override
  _CircularGlowState createState() => _CircularGlowState();
}

class _CircularGlowState extends State<CircularGlow>
    with SingleTickerProviderStateMixin {
  late final controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  );
  late final _curve = CurvedAnimation(
    parent: controller,
    curve: widget.curve,
  );
  late final Animation<double> _smallDiscAnimation = Tween(
    begin: (widget.endRadius * 2) / 2,
    end: (widget.endRadius * 2) * 0.7,
  ).animate(_curve);
  late final Animation<double> _bigDiscAnimation = Tween(
    begin: (widget.endRadius * 2) / 1.8,
    end: (widget.endRadius * 2) * 0.8,
  ).animate(_curve);
  late final Animation<double> _biggerDiscAnimation = Tween(
    begin: (widget.endRadius * 2) / 1.6,
    end: (widget.endRadius * 2) * 0.9,
  ).animate(_curve);
  late final Animation<double> _biggestDiscAnimation = Tween(
    begin: (widget.endRadius * 2) / 1.4,
    end: (widget.endRadius * 2),
  ).animate(_curve);
  late final Animation<double> _alphaAnimation = Tween(
    begin: 0.30,
    end: 0.0,
  ).animate(controller);

  late void Function(AnimationStatus status) _statusListener = (_) async {
    if (controller.status == AnimationStatus.completed) {
      // await Future.delayed(widget.repeatPauseDuration);
      if (mounted && widget.repeat && widget.animate) {
        if (widget.reverse) {
          controller.reverse();
        } else {
          controller.reset();
          controller.forward();
        }
      }
    } else if (widget.reverse &&
        controller.status == AnimationStatus.dismissed) {
      // await Future.delayed(widget.repeatPauseDuration);
      if (mounted && widget.repeat && widget.animate) {
        controller.forward();
      }
    }
  };

  @override
  void initState() {
    super.initState();
    if (widget.animate) {
      _startAnimation();
    }
  }

  @override
  void didUpdateWidget(CircularGlow oldWidget) {
    if (widget.animate != oldWidget.animate) {
      if (widget.animate) {
        _startAnimation();
      } else {
        _stopAnimation();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  void _startAnimation() async {
    controller.addStatusListener(_statusListener);
    if (widget.startDelay != null) {
      await Future.delayed(widget.startDelay!);
    }
    if (mounted) {
      controller.reset();
      controller.forward();
    }
  }

  void _stopAnimation() async {
    controller.removeStatusListener(_statusListener);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _alphaAnimation,
      child: widget.child,
      builder: (context, widgetChild) {
        final decoration = BoxDecoration(
          shape: widget.shape,
          // If the user picks a curve that goes below 0 or above 1
          // this opacity will have unexpected effects without clamping
          color: widget.glowColor.withOpacity(
            _alphaAnimation.value.clamp(
              0.05,
              1.0,
            ),
          ),
        );
        return SizedBox(
          height: widget.endRadius * 2,
          width: widget.endRadius * 2,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              widget.animate
                  ? AnimatedBuilder(
                      animation: _biggestDiscAnimation,
                      builder: (context, widget) {
                        // If the user picks a curve that goes below 0,
                        // this will throw without clamping
                        final num size = _biggestDiscAnimation.value.clamp(
                          0.0,
                          double.infinity,
                        );
                        return Container(
                          height: size as double?,
                          width: size as double?,
                          decoration: decoration,
                        );
                      },
                    )
                  : const SizedBox(height: 0.0, width: 0.0),
              widget.animate
                  ? AnimatedBuilder(
                      animation: _biggerDiscAnimation,
                      builder: (context, widget) {
                        // If the user picks a curve that goes below 0,
                        // this will throw without clamping
                        final num size = _biggerDiscAnimation.value.clamp(
                          0.0,
                          double.infinity,
                        );
                        return Container(
                          height: size as double?,
                          width: size as double?,
                          decoration: decoration,
                        );
                      },
                    )
                  : const SizedBox(height: 0.0, width: 0.0),
              widget.animate
                  ? AnimatedBuilder(
                      animation: _bigDiscAnimation,
                      builder: (context, widget) {
                        // If the user picks a curve that goes below 0,
                        // this will throw without clamping
                        final num size = _bigDiscAnimation.value.clamp(
                          0.0,
                          double.infinity,
                        );
                        return Container(
                          height: size as double?,
                          width: size as double?,
                          decoration: decoration,
                        );
                      },
                    )
                  : const SizedBox(height: 0.0, width: 0.0),
              widget.animate && widget.showTwoGlows
                  ? AnimatedBuilder(
                      animation: _smallDiscAnimation,
                      builder: (context, widget) {
                        final num size = _smallDiscAnimation.value.clamp(
                          0.0,
                          double.infinity,
                        );

                        return Container(
                          height: size as double?,
                          width: size as double?,
                          decoration: decoration,
                        );
                      },
                    )
                  : const SizedBox(height: 0.0, width: 0.0),
              widgetChild!,
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
