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

/// A bar with a rounded text field and a send button.
///
/// The text field has 1 to 10 lines, then it start scrolling. When the user
/// presses the send button the [onSend] callback is called.
class ChatBottomBar extends StatefulWidget {
  /// The text that is displayed when the text field is empty.
  final String? hintText;

  /// The action performed when the button is pressed.
  final ValueChanged<String>? onSend;

  const ChatBottomBar({Key? key, this.hintText, this.onSend}) : super(key: key);

  @override
  _ChatBottomBarState createState() => _ChatBottomBarState();
}

class _ChatBottomBarState extends State<ChatBottomBar> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: ShapeDecoration(
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            clipBehavior: Clip.hardEdge,
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
            shape: const CircleBorder(),
            color: Theme.of(context).accentColor,
          ),
          child: IconButton(
            icon: const Icon(Icons.send),
            onPressed: _onPressed,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onPressed() async {
    var text = controller.text.trim();
    controller.clear();
    widget.onSend?.call(text);
  }
}
