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

/// A bar with a rounded button that fills the horizontal space.
///
/// Has an optional back button.
/// When the button is pressed the callback is executed and the button text is
/// replaced by another widget.
class RoundButtonBar extends StatefulWidget {
  /// The text displayed on the button.
  final String title;

  /// The action performed when the button is pressed.
  final Future Function()? onPressedFuture;

  /// Can be used to change the button expansion through [isExpanded].
  final BoxConstraints constraints;

  /// A margin around the button bar. Defaults to 8.
  final EdgeInsetsGeometry margin;

  /// Whether a back button should be displayed, not visible by default.
  final bool allowBack;

  /// Whether this button has a border. Defaults to false.
  final bool hasBorder;

  /// The widget shown while the callback is executing.
  final Widget working;

  const RoundButtonBar({
    Key? key,
    required this.title,
    isExpanded = true,
    this.margin = const EdgeInsets.all(8),
    this.allowBack = false,
    this.working = const CircularProgressIndicator.adaptive(),
    this.onPressedFuture,
  })  : constraints = isExpanded
            ? const BoxConstraints.expand(height: 50)
            : const BoxConstraints(minWidth: double.infinity, maxHeight: 35),
        hasBorder = false,
        super(key: key);

  const RoundButtonBar.border({
    Key? key,
    required this.title,
    isExpanded = true,
    this.margin = const EdgeInsets.all(8),
    this.allowBack = false,
    this.working = const CircularProgressIndicator.adaptive(),
    this.onPressedFuture,
  })  : constraints = isExpanded
            ? const BoxConstraints.expand(height: 50)
            : const BoxConstraints(minWidth: double.infinity, maxHeight: 35),
        hasBorder = true,
        super(key: key);

  @override
  _RoundButtonBarState createState() => _RoundButtonBarState();
}

class _RoundButtonBarState extends State<RoundButtonBar> {
  var isWorking = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.allowBack) BackButton(),
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              border: widget.hasBorder
                  ? Border.all(
                      color: Theme.of(context).colorScheme.onPrimary,
                      width: 1.0,
                    )
                  : Border(),
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).colorScheme.primary,
            ),
            constraints: widget.constraints,
            margin: widget.margin,
            child: RawMaterialButton(
              child: isWorking ? widget.working : Text(widget.title),
              onPressed: runOnPressed,
            ),
          ),
        ),
      ],
    );
  }

  runOnPressed() async {
    setState(() => isWorking = true);
    await widget.onPressedFuture?.call();
    setState(() => isWorking = false);
  }
}
