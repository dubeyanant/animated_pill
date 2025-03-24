import 'dart:ui' show Color;

import 'package:flutter/material.dart';

class AnimatedPill extends StatefulWidget {
  final String text;
  final int animationLoops;
  final EdgeInsets padding, margin;
  final double fontSize, borderRadius, leftPadding, rightPadding;
  final Color backgroundColor, textColor;
  final Duration animationDuration, pauseDuration;

  const AnimatedPill._({
    required this.text,
    required this.animationLoops,
    required this.padding,
    required this.margin,
    required this.fontSize,
    required this.borderRadius,
    required this.leftPadding,
    required this.rightPadding,
    required this.backgroundColor,
    required this.textColor,
    required this.animationDuration,
    required this.pauseDuration,
  });

  /// [animationLoops] accepted values
  ///
  /// case -1: loop infinite times
  ///
  /// case 0: directly show widget without any animation
  ///
  /// case n(n > 0): loop n times
  ///
  /// case n(n < -1): not allowed
  factory AnimatedPill(
    text, {
    animationLoops = -1,
    backgroundColor = const Color(0xFF4CAF50),
    textColor = const Color(0xFFFFFFFF),
    fontSize = 9.0,
    animationDuration = const Duration(milliseconds: 1000),
    pauseDuration = const Duration(milliseconds: 800),
    padding = const EdgeInsets.fromLTRB(8, 2, 8, 3),
    margin = const EdgeInsets.only(left: 8),
    borderRadius = 50.0,
  }) {
    assert(
        animationLoops >= -1, "\n\n[animationLoops] cannot be less than -1\n");
    return AnimatedPill._(
      text: text,
      animationLoops: animationLoops,
      animationDuration: animationDuration,
      backgroundColor: backgroundColor,
      borderRadius: borderRadius,
      fontSize: fontSize,
      padding: padding,
      leftPadding: padding.left,
      rightPadding: padding.right,
      margin: margin,
      pauseDuration: pauseDuration,
      textColor: textColor,
    );
  }

  @override
  State<AnimatedPill> createState() => _AnimatedPillState();
}

class _AnimatedPillState extends State<AnimatedPill>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final GlobalKey _textKey = GlobalKey();
  double _textWidth = 0.0;
  bool _measured = false;
  bool _disposed = false;
  late Animation<double> scaleAnimation;
  late int loops;
  @override
  void initState() {
    super.initState();
    loops = widget.animationLoops;
    if (loops != 0) {
      // Create animation controller
      _controller = AnimationController(
        vsync: this,
        duration: widget.animationDuration,
      );

      _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.7, curve: Curves.easeOutExpo),
        ),
      );

      scaleAnimation = TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.4, end: 1.0),
          weight: 1,
        ),
      ]).animate(
        CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.0, 0.7, curve: Curves.easeOutExpo),
        ),
      );

      // Start animation after a frame to measure text width
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _measureTextWidth();
      });
    }
  }

  void _measureTextWidth() {
    final RenderBox? renderBox =
        _textKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _textWidth = renderBox.size.width;
        _measured = true;
      });
      _startAnimation();
    }
  }

  void _startAnimation() async {
    if (_disposed) return;

    while (mounted && !_disposed) {
      try {
        // Start with a pause
        await Future.delayed(widget.pauseDuration);
        if (_disposed) return;

        // Run animation (appear and disappear)
        await _controller.forward();
        await Future.delayed(widget.pauseDuration);
        if (_disposed) return;

        if (loops != -1) {
          loops--;
          if (loops <= 0) break;
        }

        // Reset for next cycle
        await _controller.reverse();
      } catch (e) {
        break;
      }
    }
  }

  @override
  void dispose() {
    if (loops != 0) {
      _disposed = true;
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // First render to measure text
    if (loops == 0 || !_measured) {
      return Container(
        margin: widget.margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: widget.backgroundColor,
        ),
        padding: widget.padding,
        child: Text(
          widget.text,
          key: _textKey,
          style: TextStyle(
            color: widget.textColor,
            fontSize: widget.fontSize,
          ),
          softWrap: false,
          overflow: TextOverflow.clip,
        ),
      );
    }

    // After measurement, render animated version
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final width = (_textWidth + widget.leftPadding + widget.rightPadding) *
            _animation.value;
        return Transform(
          transform: Matrix4.identity()..scale(scaleAnimation.value),
          alignment: Alignment.centerLeft,
          child: AnimatedOpacity(
            duration:
                Duration(milliseconds: widget.animationDuration.inMilliseconds),
            curve: Curves.easeOutExpo,
            opacity: _animation.value,
            child: Container(
              margin: widget.margin,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: widget.backgroundColor,
              ),
              width: width.clamp(0.0, double.infinity),
              clipBehavior: Clip.hardEdge,
              padding: widget.padding,
              child: Text(
                widget.text,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                ),
                softWrap: false,
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        );
      },
    );
  }
}
