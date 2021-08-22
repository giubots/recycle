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

/// This widget is a [ListTile] that can display a message in a chat.
///
/// The constructor takes the [author] of the message and the [message] itself.
/// In order to display differently messages sent by the current user and those
/// sent by the others, the constructor takes a [fromCurrentUser] boolean.
/// If the message is from the current user, then it is displayed aligned on the
/// right, all the other messages are displayed on the left. If the message is
/// from the current use it also does not contain the name of the author.
class ChatMessageTile extends StatelessWidget {
  /// The author of this message, displayed at the top if not from current user.
  final String author;

  /// The contents of the message.
  final String message;

  /// Whether this message is from the user that is viewing the widget.
  final bool fromCurrentUser;

  /// Controls the alignment based on [fromCurrentUser].
  final TextAlign _alignment;

  const ChatMessageTile({
    Key? key,
    this.author = '',
    required this.message,
    this.fromCurrentUser = false,
  })  : _alignment = fromCurrentUser ? TextAlign.end : TextAlign.start,
        assert(
          fromCurrentUser || author != '',
          'The message is not from current user, an author must be provided',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!fromCurrentUser)
              Text(
                author,
                textAlign: _alignment,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            Text(
              message,
              textAlign: _alignment,
            ),
          ],
        ),
      ),
    );
  }
}
