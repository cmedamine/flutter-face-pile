## Flutter Face Pile

A group of overlapping round avatars are called face piles.

this packages was originated from [@SuperDeclarative!](https://github.com/matthew-carroll/widget_workshops/blob/main/lib/face_pile/main_face_pile.dart)

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

<img src="screenshots/flutter-face-pile-screenshot.png" width = 70%></img>

## Getting started

Add this to your package's `pubspec.yaml` file:

```
...
dependencies:
  flutter_face_pile: ^0.0.1

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
