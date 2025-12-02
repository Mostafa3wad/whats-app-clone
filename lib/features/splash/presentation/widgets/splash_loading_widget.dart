import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'package:whats_app_clone/config/themes/app_colors.dart';

class SplashLoading extends StatefulWidget {
  const SplashLoading({super.key});

  @override
  State<SplashLoading> createState() => _SplashLoadingState();
}

class _SplashLoadingState extends State<SplashLoading>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildDot({
    required double fromSize,
    required double toSize,
    required double fromOpacity,
    required double toOpacity,
  }) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        final double rawT = _controller.value;
        final double t = Curves.easeInOut.transform(rawT);

        final double size = lerpDouble(fromSize, toSize, t)!;
        final double opacity = lerpDouble(fromOpacity, toOpacity, t)!;

        return Opacity(
          opacity: opacity,
          child: Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              color: AppColors.iconGreen,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const double big = 30;
    const double mid1 = 24;
    const double mid2 = 16;
    const double small1 = 8;
    const double small2 = 4;

    const double strong = 1.0;
    const double weak = 0.35;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: SizedBox(
        height: 20,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildDot(
              fromSize: big,
              toSize: small2,
              fromOpacity: strong,
              toOpacity: weak,
            ),
            const SizedBox(width: 5),

            _buildDot(
              fromSize: mid1,
              toSize: small1,
              fromOpacity: strong,
              toOpacity: weak,
            ),
            const SizedBox(width: 5),

            _buildDot(
              fromSize: mid2,
              toSize: mid2,
              fromOpacity: 0.8,
              toOpacity: 0.8,
            ),
            const SizedBox(width: 5),

            _buildDot(
              fromSize: small1,
              toSize: mid1,
              fromOpacity: weak,
              toOpacity: strong,
            ),
            const SizedBox(width: 8),

            _buildDot(
              fromSize: small2,
              toSize: big,
              fromOpacity: weak,
              toOpacity: strong,
            ),
          ],
        ),
      ),
    );
  }
}
