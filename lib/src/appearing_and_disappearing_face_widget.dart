import 'package:flutter/material.dart';

import 'avatar_circle_widget.dart';
import 'face_holder.dart';

class AppearingAndDisappearingFace extends StatefulWidget {
  final FaceHolder face;
  final double faceSize;
  final bool showFace;
  final Color nameLabelColor;
  final Color backgroundColor;
  final VoidCallback onDisappear;
  final Color borderColor;
  final double borderWidth;
  final Duration animationDuration;

  const AppearingAndDisappearingFace({
    Key? key,
    required this.face,
    required this.faceSize,
    required this.showFace,
    required this.onDisappear,
    required this.nameLabelColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.animationDuration,
  }) : super(key: key);

  @override
  State<AppearingAndDisappearingFace> createState() =>
      _AppearingAndDisappearingFaceState();
}

class _AppearingAndDisappearingFaceState
    extends State<AppearingAndDisappearingFace>
    with SingleTickerProviderStateMixin {
  void _syncScaleAnimationWithWidget() {
    if (widget.showFace &&
        !_scaleController.isCompleted &&
        _scaleController.status != AnimationStatus.forward) {
      _scaleController.forward();
    } else if (!widget.showFace &&
        !_scaleController.isDismissed &&
        _scaleController.status != AnimationStatus.reverse) {
      _scaleController.reverse();
    }
  }

  late AnimationController _scaleController;
  late Animation _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          widget.onDisappear();
        }
      });
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    _syncScaleAnimationWithWidget();
  }

  @override
  void didUpdateWidget(AppearingAndDisappearingFace oldWidget) {
    super.didUpdateWidget(oldWidget);

    _syncScaleAnimationWithWidget();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.faceSize,
      height: widget.faceSize,
      child: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AvatarCircle(
                faceHolder: widget.face,
                size: widget.faceSize,
                nameLabelColor: widget.nameLabelColor,
                backgroundColor: widget.backgroundColor,
                borderColor: widget.borderColor,
                borderWidth: widget.borderWidth,
                animationDuration: widget.animationDuration,
              ),
            );
          },
        ),
      ),
    );
  }
}
