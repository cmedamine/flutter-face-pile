import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_random_user/flutter_random_user.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:flutter_face_pile/flutter_face_pile.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Face Pile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const FacePileDemoScreen(),
    ),
  );
}

class FacePileDemoScreen extends StatefulWidget {
  const FacePileDemoScreen({Key? key}) : super(key: key);

  @override
  State<FacePileDemoScreen> createState() => _FacePileDemoScreenState();
}

class _FacePileDemoScreenState extends State<FacePileDemoScreen> {
  late List<FaceHolder> _availableUsers;
  final _facePileUsers = <FaceHolder>[];

  @override
  void initState() {
    super.initState();

    _populateFakeUsers();
  }

  Future<void> _populateFakeUsers() async {
    final randomUsers = userGenerator(
      max: 20,
      loremIpsumParagraphs: 1,
      loremIpsumWords: 100,
    );

    _availableUsers = randomUsers
        .map(
          (randomUser) => FaceHolder(
            id: randomUser.userName,
            name: randomUser.firstName,
            avatar: NetworkImage(randomUser.thumbNail),
          ),
        )
        .toList();
  }

  void _addUserToPile() {
    if (_availableUsers.isNotEmpty) {
      final user = _availableUsers.removeLast();
      setState(() {
        _facePileUsers.add(user);
      });
    }
  }

  void _removeUserFromPile() {
    if (_facePileUsers.isNotEmpty) {
      final randomIndex = Random().nextInt(_facePileUsers.length);
      setState(() {
        final user = _facePileUsers.removeAt(randomIndex);
        _availableUsers.insert(0, user);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Face Pile')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200),
          child: FacePile(
            faces: _facePileUsers,
            faceSize: 50,
            facePercentOverlap: .4, // 40% face overlap.
            borderColor: Colors.white,
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _removeUserFromPile,
            mini: true,
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 24),
          FloatingActionButton(
            onPressed: _addUserToPile,
            mini: true,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}