## Flutter Face Pile

A group of overlapping round avatars are called face piles.

A face pile is a series of overlapping avatar images that come and go as users join and leave a given group.

this packages was originated from [@SuperDeclarative!](https://github.com/matthew-carroll/widget_workshops/blob/main/lib/face_pile/main_face_pile.dart)

[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)


<img src="https://github.com/cmedamine/flutter-face-pile/blob/main/screenshots/flutter-face-pile-screenshot.png?raw=true" width="80%" alt="Flutter Face Pile">

## Getting started

Add this to your package's `pubspec.yaml` file:

```
dependencies:
  flutter_face_pile: ^0.0.3
```

Now in your Dart code, you can use:

```dart
import 'package:flutter_face_pile/flutter_face_pile.dart';
```

## Usage

```dart

import 'package:flutter_face_pile/flutter_face_pile.dart';


FacePile(
    faces: [
        FaceHolder(
            id: '1',
            name: 'user 1',
            avatar: NetworkImage('https://i.pravatar.cc/300?img=1'),
          ),
          FaceHolder(
            id: '2',
            name: 'user 2',
            avatar: NetworkImage('https://i.pravatar.cc/300?img=2'),
          ),
          FaceHolder(
            id: '3',
            name: 'user 3',
            avatar: NetworkImage('https://i.pravatar.cc/300?img=3'),
          ),
    ],
    faceSize: 50,
    facePercentOverlap: .4,
    borderColor: Colors.white,
),



```

## Contribute

Contributions are welcome, if you have a issue or any problem with this packages please file issues, or make pull-requests.
