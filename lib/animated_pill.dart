import 'package:flutter/material.dart';

/// A Flutter widget that creates an animated pill-shaped container with customizable
/// appearance and animation properties.
///
/// The [AnimatedPill] widget displays text in a pill-shaped container that can animate
/// its appearance and disappearance. It's perfect for displaying tags, labels, or badges
/// with smooth animations.
///
/// Example usage:
/// ```dart
/// AnimatedPill(
///   text: 'New Feature',
///   backgroundColor: Colors.green,
///   textColor: Colors.white,
/// )
/// ```
class AnimatedPill extends StatefulWidget {
  /// The text to display in the pill.
  final String text;

  /// The number of times the animation should loop.
  ///
  /// - `-1`: Infinite animation loops (default)
  /// - `0`: No animation, just shows the widget
  /// - `n > 0`: Animates n times
  /// - `n < -1`: Not allowed (throws assertion error)
  final int animationLoops;

  /// The padding around the text content.
  final EdgeInsets padding;

  /// The margin around the pill container.
  final EdgeInsets margin;

  /// The size of the text.
  final double fontSize;

  /// The border radius of the pill container.
  final double borderRadius;

  /// The left padding of the container.
  final double leftPadding;

  /// The right padding of the container.
  final double rightPadding;

  /// The background color of the pill.
  final Color backgroundColor;

  /// The color of the text.
  final Color textColor;

  /// The duration of each animation cycle.
  final Duration animationDuration;

  /// The duration to pause between animations.
  final Duration pauseDuration;

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

  /// Creates an [AnimatedPill] widget.
  ///
  /// The [text] parameter is required and specifies the text to display.
  /// All other parameters are optional and have default values.
  ///
  /// The [animationLoops] parameter controls the animation behavior:
  /// - `-1`: Infinite animation loops (default)
  /// - `0`: No animation, just shows the widget
  /// - `n > 0`: Animates n times
  /// - `n < -1`: Not allowed (throws assertion error)
  ///
  /// Example:
  /// ```dart
  /// AnimatedPill(
  ///   text: 'New Feature',
  ///   backgroundColor: Colors.green,
  ///   textColor: Colors.white,
  /// )
  /// ```
  factory AnimatedPill(
    String text, {
    int animationLoops = -1,
    Color backgroundColor = const Color(0xFF4CAF50),
    Color textColor = const Color(0xFFFFFFFF),
    double fontSize = 9.0,
    Duration animationDuration = const Duration(milliseconds: 1000),
    Duration pauseDuration = const Duration(milliseconds: 800),
    EdgeInsets padding = const EdgeInsets.fromLTRB(8, 2, 8, 3),
    EdgeInsets margin = const EdgeInsets.only(left: 8),
    double borderRadius = 50.0,
  }) {
    assert(
      animationLoops >= -1,
      "\n\n[animationLoops] cannot be less than -1\n",
    );
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

/// The state class for [AnimatedPill].
class _AnimatedPillState extends State<AnimatedPill>
    with SingleTickerProviderStateMixin {
  /// The controller that manages the animation.
  late AnimationController _controller;

  /// The animation that controls the width of the pill.
  late Animation<double> _animation;

  /// A key to identify the text widget for measuring its width.
  final GlobalKey _textKey = GlobalKey();

  /// The measured width of the text.
  double _textWidth = 0.0;

  /// Whether the text width has been measured.
  bool _measured = false;

  /// Whether the widget has been disposed.
  bool _disposed = false;

  /// The animation that controls the scale of the pill.
  late Animation<double> scaleAnimation;

  /// The number of animation loops remaining.
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

  /// Measures the width of the text widget.
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

  /// Starts the animation sequence.
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
          style: TextStyle(color: widget.textColor, fontSize: widget.fontSize),
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
            duration: Duration(
              milliseconds: widget.animationDuration.inMilliseconds,
            ),
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
