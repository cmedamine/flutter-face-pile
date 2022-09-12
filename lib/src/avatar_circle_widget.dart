import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'face_holder.dart';

class AvatarCircle extends StatelessWidget {
  final FaceHolder faceHolder;
  final double size;
  final Color nameLabelColor;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final Duration animationDuration;

  const AvatarCircle({
    Key? key,
    required this.faceHolder,
    required this.size,
    required this.nameLabelColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.animationDuration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: borderWidth,
          color: borderColor,
        ),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          )
        ],
      ),
      clipBehavior: Clip.none,
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                faceHolder.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: nameLabelColor,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: FadeInImage(
              width: size,
              height: size,
              placeholder: MemoryImage(kTransparentImage),
              image: faceHolder.avatar,
              fit: BoxFit.contain,
              fadeInDuration: animationDuration,
            ),
          )
        ],
      ),
    );
  }
}
