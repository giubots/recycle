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

/// An eye icon that can be pressed invoking a callback.
class ToggleVisible extends StatefulWidget {
  /// The initial value, if `true` the icon will be 'show', otherwise 'hide'.
  final bool value;

  /// This function is invoked when the value is toggled by a tap.
  final ValueChanged<bool> onChanged;

  const ToggleVisible({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ToggleVisibleState createState() => _ToggleVisibleState();
}

class _ToggleVisibleState extends State<ToggleVisible> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _visible = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _visible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
      ),
      onPressed: () {
        setState(() {
          _visible = !_visible;
        });
        widget.onChanged(_visible);
      },
    );
  }
}
