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

class RoundBottomTabBar extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final ValueChanged<int>? onTap;

  const RoundBottomTabBar({
    Key? key,
    required this.tabs,
    this.controller,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.elliptical(100, 3)),
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: 50,
          child: TabBar(
            controller: controller,
            tabs: tabs,
            onTap: onTap,
            labelColor: colorScheme.onSurface,
            indicator: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: colorScheme.primary,
                  width: 3,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
