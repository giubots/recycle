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

import 'package:flutter/material.dart';
import 'package:recycle/types.dart';

/// This widget shows its [child] until the future [work] is completed.
///
/// When the future is completed, this will call `runApp` and launch the widget
/// returned by the [nextWidget] provider.
/// This differs from a [FutureBuilder] in the fact that it uses `runApp`.
class LoadingScreen extends StatelessWidget {
  /// The widget that is shown while the [work] is not completed.
  /// By default it is a centered [CircularProgressIndicator].
  final Widget child;

  /// When this future completes, the [nextWidget] will be shown.
  final Future work;

  /// A function that returns the widget that will be shown on the future completion.
  final WidgetProvider nextWidget;

  /// The theme of the loading page, defaults to light.
  final ThemeData? theme;

  LoadingScreen({
    Key? key,
    this.child = const Center(child: const CircularProgressIndicator()),
    required this.work,
    required this.nextWidget,
    this.theme,
  }) : super(key: key) {
    work.then((_) => runApp(nextWidget()));
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Material(child: child),
        theme: theme ?? ThemeData.light(),
      );
}
