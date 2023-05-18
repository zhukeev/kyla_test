import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kyla_test/modules/main/ui/widgets/bottom_animation_clipper.dart';

typedef DropAnimationControllerCallback = void Function(DropAnimationController controller);

class DropAnimationController {
  final ValueNotifier<double> height;
  final Duration? dropDuration;
  final VoidCallback onDropComplete;
  final VoidCallback onReset;

  const DropAnimationController({
    required this.height,
    this.dropDuration,
    required this.onDropComplete,
    required this.onReset,
  });
}

class BottomAnimation extends StatefulWidget {
  final double height;
  final double limit;
  final DropAnimationControllerCallback onDropAnimationController;

  const BottomAnimation({
    super.key,
    required this.onDropAnimationController,
    required this.height,
    required this.limit,
  });

  @override
  State<BottomAnimation> createState() => _BottomAnimationState();
}

class _BottomAnimationState extends State<BottomAnimation> with TickerProviderStateMixin {
  final _heightNotifier = ValueNotifier<double>(16.0);

  late final AnimationController _curveAnimationController;
  late final AnimationController _circleAnimationController;

  late final DropAnimationController _dropAnimationController;

  @override
  void initState() {
    _dropAnimationController = DropAnimationController(
      height: _heightNotifier,
      dropDuration: const Duration(milliseconds: 1000),
      onDropComplete: () {
        debugPrint('onDropComplete');

        final reachedLimit = widget.limit <= _heightNotifier.value;

        if (reachedLimit) {
          _circleAnimationController.value = widget.limit;

          _curveAnimationController.reverse();
        } else {
          _reverseAnimation();
        }
      },
      onReset: () {
        debugPrint('onReset');

        _circleAnimationController.reverse();
      },
    );

    _curveAnimationController = AnimationController(
      duration: _dropAnimationController.dropDuration,
      vsync: this,
      upperBound: widget.height,
      lowerBound: 16,
      reverseDuration: const Duration(milliseconds: 300),
    );
    _circleAnimationController = AnimationController(
      duration: _dropAnimationController.dropDuration,
      vsync: this,
      lowerBound: 16,
      upperBound: widget.limit,
    );
    _circleAnimationController.forward();
    _heightNotifier.addListener(_sizeListener);
    widget.onDropAnimationController(_dropAnimationController);

    _circleAnimationController.addListener(_circleAnimationListener);

    super.initState();
  }

  void _circleAnimationListener() {
    if (_circleAnimationController.status == AnimationStatus.reverse) {
      _heightNotifier.value = _circleAnimationController.value;
    }
  }

  void _sizeListener() {
    if (_circleAnimationController.isAnimating) return;

    final val = (_heightNotifier.value).toDouble();
    final reachedLimit = widget.limit <= (val);

    if (reachedLimit) {
      _dropAnimationController.onDropComplete();
    } else {
      _curveAnimationController.value = val + (56 * 2);
    }
  }

  void _reverseAnimation() {
    _heightNotifier.removeListener(_sizeListener);
    _curveAnimationController.addListener(_animationListener);
    _curveAnimationController.reverse().whenComplete(() {
      _curveAnimationController.removeListener(_animationListener);
      _heightNotifier.addListener(_sizeListener);
    });
  }

  void _animationListener() {
    _heightNotifier.value = max(16, _curveAnimationController.value - (56 * 2));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox.fromSize(
      size: size,
      child: AnimatedBuilder(
          animation: _curveAnimationController,
          builder: (context, child) {
            return ClipPath(
              clipper: BottomAnimationClipper(
                curveHeight: size.height - _curveAnimationController.value,
                topCircleSize: 36,
              ),
              child: const ColoredBox(color: Colors.white),
            );
          }),
    );
  }

  @override
  void dispose() {
    _heightNotifier.removeListener(_sizeListener);
    _circleAnimationController.removeListener(_circleAnimationListener);

    _curveAnimationController.dispose();
    _heightNotifier.dispose();
    super.dispose();
  }
}
