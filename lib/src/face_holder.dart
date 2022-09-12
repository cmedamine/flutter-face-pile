import 'package:flutter/material.dart';

class FaceHolder {
  final String id;
  final ImageProvider<Object> avatar;
  final String name;

  FaceHolder({required this.avatar, required this.name, required this.id});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FaceHolder && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
