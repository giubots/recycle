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

/// A [CircleAvatar] with a callback.
///
/// When the user taps on the image a popup menu is displayed with the [toolTip]
/// text, when the user clicks on the text, the callback [onTap] is executed.
class EditableCircleAvatar extends StatelessWidget {
  /// The radius of this [CircleAvatar], 100 by default.
  final double radius;

  /// The image to show in the [CircleAvatar].
  final ImageProvider backgroundImage;

  /// The action to be performed when the user taps the image.
  final GestureTapCallback? onTap;

  /// The text to be displayed when the user taps the image, 'continue' by default.
  final String toolTip;

  const EditableCircleAvatar({
    Key? key,
    this.radius = 100,
    required this.backgroundImage,
    this.onTap,
    this.toolTip = 'Continue',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Offset pos = Offset.zero;
    return Ink(
      child: CircleAvatar(
        radius: radius,
        backgroundImage: backgroundImage,
        child: Material(
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: InkWell(
            onTapDown: (details) => pos = details.globalPosition,
            onTap: () => _onTap(context, pos),
          ),
        ),
      ),
    );
  }

  void _onTap(BuildContext context, Offset pos) async {
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject()! as RenderBox;
    var confirm = await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        pos & const Size(50, 50),
        Offset.zero & overlay.size,
      ),
      items: [PopupMenuItem(child: Text(toolTip), value: true)],
    );
    if (confirm == null) return;
    onTap?.call();
  }
}
