/* (C) Copyright 2021 Giulio Antonio Abbo, Gianmarco Accordi.
 * All rights reserved.
 * This file is part of hopoint project.
 * 
 * Author: Giulio Antonio Abbo
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Adds a Material ancestor with a theme and localization support.
Widget addMaterial(Widget widget) {
  return MaterialApp(
    home: Material(child: widget),
    theme: ThemeData.light(),
  );
}

/// Adds a provider ancestor of a given type to a widget.
/// Other methods are available to add multiple providers at the same time.
Widget addProvider<T>(Widget widget, T provided) {
  return Provider<T>.value(
    value: provided,
    builder: (context, _) => widget,
  );
}

Widget addProvider2<T, S>(Widget widget, T provided1, S provided2) {
  return MultiProvider(
    providers: [
      Provider<T>.value(value: provided1),
      Provider<S>.value(value: provided2),
    ],
    builder: (context, _) => widget,
  );
}

Widget addProvider3<T, S, R>(
    Widget widget, T provided1, S provided2, R provided3) {
  return MultiProvider(
    providers: [
      Provider<T>.value(value: provided1),
      Provider<S>.value(value: provided2),
      Provider<R>.value(value: provided3),
    ],
    builder: (context, _) => widget,
  );
}
