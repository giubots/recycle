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

const EmptyPadding = [const Padding(padding: const EdgeInsets.only(left: 50))];

class RoundBottomAppBar extends StatelessWidget {
  final Object heroTag;
  final Widget? title;
  final List<Widget>? actions;

  RoundBottomAppBar({
    Key? key,
    this.heroTag = '<Default RoundBottomAppBar tag>',
    List<Widget>? actions,
    this.title,
  })  : actions = (title != null && (actions?.isEmpty ?? true))
            ? EmptyPadding
            : actions,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tColor = theme.colorScheme.onPrimary;

    var obj = ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.elliptical(100, 3)),
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        clipBehavior: Clip.antiAlias,
        child: DefaultTextStyle(
          style: theme.textTheme.headline6!.copyWith(color: tColor),
          child: Container(
              color: Theme.of(context).colorScheme.primary,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButton(),
                  if (title != null) title!,
                  if (actions != null) ...actions!,
                ],
              )),
        ),
      ),
    );

    return Hero(
      tag: heroTag,
      child: obj,
      flightShuttleBuilder: (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) => Scaffold(bottomNavigationBar: obj),
    );
  }
}
