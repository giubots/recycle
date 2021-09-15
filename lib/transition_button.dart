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
import 'package:recycle/helpers.dart';

class TransitionButton extends StatelessWidget {
  final WidgetBuilder builder;
  final Object heroTag;
  final Color? backgroundColor;
  final Widget child;

  const TransitionButton({
    Key? key,
    required this.builder,
    this.heroTag = '<Default TransitionButton tag>',
    this.backgroundColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bColor = backgroundColor ?? Theme.of(context).colorScheme.background;

    var cContainer = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bColor,
      ),
    );

    var rContainer = Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(50),
        color: bColor,
      ),
    );

    return FittedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
            icon: child,
            onPressed: () => pushFade(context, _builder(context, bColor)),
          ),
          Hero(
            tag: heroTag,
            child: ClipOval(child: cContainer),
            // flightShuttleBuilder: (
            //   flightContext,
            //   animation,
            //   flightDirection,
            //   fromHeroContext,
            //   toHeroContext,
            // ) =>
            //     (flightDirection == HeroFlightDirection.push)
            //         ? rContainer
            //         : cContainer,
          ),
        ],
      ),
    );
  }

  Widget _builder(BuildContext context, Color bColor) {
    return Stack(
      children: [
        Material(
          child: Hero(
            tag: heroTag,
            child: ClipRRect(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: bColor.withAlpha(0),
                ),
              ),
            ),
          ),
        ),
        builder(context),
      ],
    );
  }
}
