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
import 'package:intl/intl.dart';

/// This is the format in which the time is displayed.
final tF = DateFormat.Hm();

/// A [ListTile] with the time and details of a generic event.
///
/// The time is displayed in column at the beginning of the tile, first the
/// starting time, then the ending time. If the end time is not provided it
/// defaults to one hour after the beginning. The rest of the tile contains the
/// description of the event.
/// The tile can be clicked and dismissed.
class EventTile extends StatelessWidget {
  /// The time the event begins.
  final DateTime start;

  /// The time the event ends, by default one hour after [start].
  final DateTime end;

  /// A brief description of the event.
  final String description;

  /// An action that is called when the user taps the tile.
  final VoidCallback? onTap;

  /// An action that is called when the user dismisses the tile.
  final DismissDirectionCallback? onDismissed;

  EventTile({
    Key? key,
    required this.start,
    DateTime? end,
    required this.description,
    this.onTap,
    this.onDismissed,
  })  : this.end = end ?? start.add(const Duration(hours: 1)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var child = ListTile(
      leading: Column(
        children: [Text(tF.format(start)), Text(tF.format(end))],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      title: Text(description),
      onTap: onTap,
    );
    var dismissible = Dismissible(
      key: UniqueKey(),
      onDismissed: onDismissed,
      child: child,
      direction: DismissDirection.endToStart,
      background: ListTile(
        trailing: Icon(Icons.delete_rounded),
        tileColor: Theme.of(context).colorScheme.surface,
      ),
    );
    return (onDismissed == null) ? child : dismissible;
  }
}
