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

/// A tile with a text field and a trailing icon.
class TextFieldIcon extends StatefulWidget {
  /// The label to be displayed on the text field.
  final String? label;

  /// The icon that is shown after the text field.
  final Icon icon;

  /// An optional initial value for the text field.
  final String? initialValue;

  /// This function is called when the icon is pressed, with the field's text.
  final ValueChanged<String>? onChanged;

  /// Whether the input is cleared when the icon is pressed. Defaults to false.
  final bool clearInput;

  const TextFieldIcon({
    Key? key,
    this.label,
    required this.icon,
    this.initialValue,
    this.onChanged,
    this.clearInput = false,
  }) : super(key: key);

  @override
  _TextFieldIconState createState() => _TextFieldIconState();
}

class _TextFieldIconState extends State<TextFieldIcon> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.initialValue ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextField(
        controller: _controller,
        decoration: InputDecoration(labelText: widget.label),
      ),
      trailing: IconButton(
        icon: widget.icon,
        onPressed: _onPressed,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPressed() {
    widget.onChanged?.call(_controller.text);
    if (widget.clearInput) _controller.clear();
  }
}
