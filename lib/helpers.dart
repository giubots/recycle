/*
 * Copyright (C) 2021 Giubots
 * This file is part of the project: recycle.
 *
 * This program is free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation, either version 3 of the License, or (at your option) any later
 * version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program. If not, see <https://www.gnu.org/licenses/>.
 */

import 'dart:typed_data';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recycle/types.dart';

/// A helper method to obtain an object from a provider without listening to
/// changes. Avoids forgetting to put `listen: false`.
T obtain<T>(BuildContext context) => Provider.of<T>(context, listen: false);

/// A utility function that defines a [PageRoute] with [SharedAxisTransition].
///
/// By default it uses [SharedAxisTransitionType.scaled].
/// This requires the animations package.
Route<T> sharedAxis<T>({
  required RoutePageBuilder pageBuilder,
  SharedAxisTransitionType? transitionType,
  Duration? duration,
  bool? dismissible,
}) {
  return PageRouteBuilder<T>(
    opaque: !(dismissible ?? true),
    barrierDismissible: dismissible ?? true,
    pageBuilder: pageBuilder,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SharedAxisTransition(
        fillColor: Colors.transparent,
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: transitionType ?? SharedAxisTransitionType.scaled,
        child: child,
      );
    },
  );
}

/// Pushes [route] on the navigation stack using a [SharedAxisTransition].
Future<T?> pushAxis<T>({
  required BuildContext context,
  required RoutePageBuilder pageBuilder,
  SharedAxisTransitionType? transitionType,
  Duration? duration,
  bool dismissible = false,
}) {
  return Navigator.of(context).push(sharedAxis(
    pageBuilder: pageBuilder,
    transitionType: transitionType,
    duration: duration,
    dismissible: dismissible,
  ));
}

/// Pops all the routes in the stack and pushes the one with the name provided.
Future<T?> replaceNamed<T>(BuildContext context, String newRouteName) {
  return Navigator.of(context).pushNamedAndRemoveUntil<T>(
    newRouteName,
    (route) => false,
  );
}

/// Allows to pick or take a photo and returns it in [Uint8List].
///
/// Shows a [BottomSheet] to choose whether to take a picture o select one from
/// the gallery, then allows to perform the chosen operation. If successful, it
/// returns the selected image in [Uint8List] encoding, otherwise returns null.
/// This requires the image_picker package.
Future<Uint8List?> getImage(BuildContext context) async {
  var fromCamera = await showModalBottomSheet<bool>(
    context: context,
    builder: (BuildContext context) {
      return SafeArea(
        child: Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('From library'),
                onTap: () => Navigator.pop(context, false),
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('From camera'),
                onTap: () => Navigator.pop(context, true),
              ),
            ],
          ),
        ),
      );
    },
  );
  if (fromCamera == null) return null;
  var file = await ImagePicker()
      .pickImage(source: fromCamera ? ImageSource.camera : ImageSource.gallery);
  return file?.readAsBytes();
}

/// Wait for a condition or timeout.
///
/// This function checks a [condition] repeatedly once every half second or what
/// specified in [checkEvery]. When the condition is satisfied (returns `True`)
/// this future resolves to `True`. After three seconds or what specified in
/// [timeout], the execution stops and this future returns `False`.
Future<bool> waitCondition(
  Condition condition, {
  Duration checkEvery = const Duration(milliseconds: 500),
  Duration timeout = const Duration(seconds: 3),
}) {
  assert(checkEvery < timeout);
  return Future.any([
    Future.delayed(timeout, () => false),
    Future.doWhile(() async {
      await Future.delayed(checkEvery);
      return !condition();
    }).then((value) => value == null),
  ]);
}

/// This functions returns a copy of [other] with time fields set to 0.
DateTime removeTimeFrom(DateTime other) =>
    DateTime(other.year, other.month, other.day);
