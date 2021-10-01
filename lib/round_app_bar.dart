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

/// A rounded AppBar with a centered [title] string and optional [actions].
class RoundAppBar extends AppBar {
  RoundAppBar({
    Key? key,
    @Deprecated('Use titleStr instead') String? title,
    String? titleStr,
    Widget? child,
    List<Widget>? actions,
  })  : assert(titleStr == null || child == null,
            'Provide titleStr OR child, not both'),
        super(
          key: key,
          shape: const RoundedRectangleBorder(
            borderRadius: const BorderRadius.vertical(
              bottom: const Radius.elliptical(1000, 25),
            ),
          ),
          centerTitle: actions?.isEmpty,
          title: child ?? Text(title ?? ''),
          actions: actions,
        );
}
