import 'package:flutter/material.dart';

import 'appearing_and_disappearing_face_widget.dart';
import 'face_holder.dart';

class FacePile extends StatefulWidget {
  /// List of user profile image.
  final List<FaceHolder> faces;

  ///avatar size, deafult -> 48
  final double faceSize;

  ///avatar percent overlap, deafult -> 0.1 or (10%)
  final double facePercentOverlap;

  ///color of name lable
  final Color nameLabelColor;

  ///background color of the avatar, deafult -> #222222
  final Color backgroundColor;

  ///name lable font size, deafult [8.0]
  final double nameFontSize;

  ///name lable font width, deafult -> bold
  final FontWeight nameFontWeight;

  ///avatar border width, deafult -> 0.0
  final double borderWidth;

  ///avatar border color, deafult -> white
  final Color borderColor;

  ///animation duration, deafult -> 250 microseconds
  final Duration animationDuration;

  ///A group of overlapping round avatars are called face piles,
  ///[FacePile] displays a stacked list of avatars,
  ///Each circle represents a person and contains their image.
  const FacePile({
    Key? key,
    required this.faces,
    this.facePercentOverlap = .1,
    this.faceSize = 48,
    this.nameLabelColor = const Color(0xFF222222),
    this.backgroundColor = const Color(0xFF888888),
    this.nameFontSize = 8.0,
    this.nameFontWeight = FontWeight.bold,
    this.borderColor = Colors.white,
    this.borderWidth = 0.0,
    this.animationDuration = const Duration(milliseconds: 250),
  }) : super(key: key);

  @override
  State<FacePile> createState() => _FacePileState();
}

class _FacePileState extends State<FacePile> {
  final _visibleFaces = <FaceHolder>[];

  void _syncFacesWithPile() {
    setState(() {
      final newFaces = widget.faces.where(
        (face) =>
            _visibleFaces.where((visibleFace) => visibleFace == face).isEmpty,
      );

      for (final newFace in newFaces) {
        _visibleFaces.add(newFace);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _syncFacesWithPile();
    });
  }

  @override
  void didUpdateWidget(covariant FacePile oldWidget) {
    super.didUpdateWidget(oldWidget);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _syncFacesWithPile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final facesCount = _visibleFaces.length;

        double facePercentVisible = 1.0 - widget.facePercentOverlap;
        final maxIntrinsicWidth = facesCount > 1
            ? (1 + (facePercentVisible * (facesCount - 1))) * widget.faceSize
            : widget.faceSize;

        late double leftOffset;
        if (maxIntrinsicWidth > constraints.maxWidth) {
          leftOffset = 0;
          facePercentVisible =
              ((constraints.maxWidth / widget.faceSize) - 1) / (facesCount - 1);
        } else {
          leftOffset = (constraints.maxWidth - maxIntrinsicWidth) / 2;
        }

        if (constraints.maxWidth < widget.faceSize) {
          // There isn't room for a single face. Show nothing.
          return const SizedBox();
        }

        return SizedBox(
          height: widget.faceSize,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              for (var i = 0; i < facesCount; i += 1)
                AnimatedPositioned(
                  key: ValueKey(_visibleFaces[i].id), // or use an id!
                  top: 0,
                  left: leftOffset + (i * facePercentVisible * widget.faceSize),
                  width: widget.faceSize,
                  height: widget.faceSize,
                  duration: widget.animationDuration,
                  curve: Curves.easeInOut,
                  child: AppearingAndDisappearingFace(
                    face: _visibleFaces[i],
                    faceSize: widget.faceSize,
                    showFace: widget.faces.contains(_visibleFaces[i]),
                    backgroundColor: widget.backgroundColor,
                    nameLabelColor: widget.nameLabelColor,
                    onDisappear: () {
                      setState(() {
                        _visibleFaces.removeAt(i);
                      });
                    },
                    borderColor: widget.borderColor,
                    borderWidth: widget.borderWidth,
                    animationDuration: widget.animationDuration,
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
