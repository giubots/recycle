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
import 'package:flutter/widgets.dart';
import 'package:recycle/round_button.dart';

/// A [ValueChanged] callback that also provides a [BuildContext] and an outcome.
typedef PerformAction<T> = Future<bool> Function(BuildContext context, T value);

/// A route with a single [TextField] and a [RoundButtonBar].
///
/// This route includes a [Scaffold] with an optional [appBar], then displays a
/// scrollable list of widgets that include the [header], the [mainText], a
/// [TextField] with [fieldHint] as a hint text, a [RoundButtonBar] with no
/// back button, the [footer]. When the button is pressed, the [onPressed]
/// callback is invoked, the returned value is used to pop this route.
class OneTextFieldRoute extends StatefulWidget {
  /// The appbar to display on top of the scaffold.
  final PreferredSizeWidget? appBar;

  /// The widget to display before the text.
  final Widget? header;

  /// The widget to display after the button.
  final Widget? footer;

  /// The text to display before the [TextField].
  final String mainText;

  /// The text that is displayed when the [TextField] is empty.
  final String? fieldHint;

  /// The text displayed on the button.
  final String buttonLabel;

  /// The callback that is invoked when the button is pressed.
  ///
  /// The arguments it receives are the context of this widget and the contents
  /// of the text field. It must return a bool future that will be then used
  /// to pop this route.
  final PerformAction<String>? onPressed;

  /// Whether this route pops when [onPressed] resolves to true.
  final bool autoPops;

  /// Whether a back button is visible.
  final bool allowBack;

  const OneTextFieldRoute({
    Key? key,
    this.appBar,
    this.header,
    this.footer,
    required this.mainText,
    this.fieldHint,
    required this.buttonLabel,
    this.onPressed,
    this.autoPops = true,
    this.allowBack = true,
  }) : super(key: key);

  @override
  _OneTextFieldRouteState createState() => _OneTextFieldRouteState();
}

class _OneTextFieldRouteState extends State<OneTextFieldRoute> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      appBar: widget.appBar,
      body: Center(
        child: SingleChildScrollView(
          // gap between lines
          child: Column(
            children: [
              if (widget.header != null) widget.header!,
              Text(widget.mainText, style: theme.textTheme.headline2),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(hintText: widget.fieldHint),
                ),
              ),
              if (widget.footer != null) widget.footer!,
              RoundButtonBar(
                title: widget.buttonLabel,
                onPressedFuture: _onPressed,
                allowBack: widget.allowBack,
                isExpanded: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _onPressed() async {
    var outcome = await widget.onPressed?.call(context, controller.text.trim());
    if (widget.autoPops) Navigator.pop(context, outcome ?? false);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
