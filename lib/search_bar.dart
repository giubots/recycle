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

class SearchBar extends StatefulWidget {
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSuffix;
  final Color? fillColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? iconColor;

  const SearchBar({
    Key? key,
    this.fillColor,
    this.hintColor,
    this.textColor,
    this.iconColor,
    this.onSubmitted,
    this.onSuffix,
    this.onChanged,
  }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final fillColor = widget.fillColor ?? colorScheme.surface;
    final textColor = widget.textColor ?? colorScheme.onSurface;
    final hintColor = widget.hintColor ?? colorScheme.onSurface;
    final iconColor = widget.iconColor ?? colorScheme.onSurface;

    final suffix = controller.value.text.trim().isEmpty
        ? null
        : IconButton(
            icon: Icon(Icons.cancel_outlined, color: iconColor),
            onPressed: _onSuffix,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(minHeight: 10, minWidth: 40),
          );

    return TextField(
      controller: controller,
      style: TextStyle(color: textColor),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(0),
        filled: true,
        fillColor: fillColor,
        isDense: true,
        hintText: 'Filter results...',
        hintStyle: TextStyle(color: hintColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Icon(Icons.search, color: iconColor),
        prefixIconConstraints: BoxConstraints(minHeight: 30, minWidth: 40),
        suffixIcon: suffix,
        suffixIconConstraints: BoxConstraints(minHeight: 30, minWidth: 40),
      ),
      onSubmitted: widget.onSubmitted,
      onChanged: (value) => setState(() => widget.onChanged?.call(value)),
    );
  }

  _onSuffix() {
    widget.onSuffix?.call();
    setState(() => controller.clear());
    widget.onSubmitted?.call('');
    widget.onChanged?.call('');
  }
}
