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
import 'package:flutter_test/flutter_test.dart';
import 'package:recycle/chat_message_tile.dart';

import 'testing_helpers.dart';

void main() {
  var subject;
  const AUTHOR = 'test author';
  const TEXT = 'sample text';
  const SUBJECT_KEY = 'subject';

  testWidgets('Text is displayed', (WidgetTester tester) async {
    subject = addMaterial(ChatMessageTile(
      key: Key(SUBJECT_KEY),
      message: TEXT,
      author: AUTHOR,
      fromCurrentUser: false,
    ));

    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();

    expect(find.text(AUTHOR), findsOneWidget);
    expect(find.text(TEXT), findsOneWidget);
  });

  testWidgets('Author not displayed if from current user',
      (WidgetTester tester) async {
    subject = addMaterial(ChatMessageTile(
      key: Key(SUBJECT_KEY),
      message: TEXT,
      author: AUTHOR,
      fromCurrentUser: true,
    ));

    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();

    expect(find.text(AUTHOR), findsNothing);
    expect(find.text(TEXT), findsOneWidget);
  });
}
