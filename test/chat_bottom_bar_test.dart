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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recycle/chat_bottom_bar.dart';

import 'testing_helpers.dart';

void main() {
  var subject;
  Completer? completer;
  const TITLE = 'test title';
  const TEXT = 'sample text';
  const SUBJECT_KEY = 'subject';

  setUp(() {
    completer = Completer();
    subject = addMaterial(ChatBottomBar(
      key: Key(SUBJECT_KEY),
      onSend: (value) => completer!.complete(value),
      hintText: TITLE,
    ));
  });

  testWidgets('Default text is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();

    expect(find.text(TITLE), findsOneWidget);
  });

  testWidgets('Can write to text field', (WidgetTester tester) async {
    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), TEXT);
    await tester.pumpAndSettle();

    expect(find.text(TEXT), findsOneWidget);
  });

  testWidgets('Tap on button sends text', (WidgetTester tester) async {
    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), TEXT);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    expect(find.text(TEXT), findsNothing);
    expect(completer!.isCompleted, true);
    await tester.runAsync(() async => expect(await completer!.future, TEXT));
  });
}
