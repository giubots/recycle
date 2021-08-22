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
import 'package:recycle/circle_avatar.dart';

import 'testing_helpers.dart';

void main() {
  var subject;
  var completer;
  const TITLE = 'test title';
  const SUBJECT_KEY = 'subject';

  setUp(() {
    completer = Completer();
    subject = addMaterial(EditableCircleAvatar(
      key: Key(SUBJECT_KEY),
      backgroundImage: AssetImage('assets/testImage.jpeg'),
      toolTip: TITLE,
      onTap: completer.complete,
    ));
  });

  testWidgets('Tap displays text', (WidgetTester tester) async {
    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();

    expect(completer.isCompleted, false);
    expect(find.text(TITLE), findsNothing);

    await tester.tap(find.byKey(Key(SUBJECT_KEY)));
    await tester.pumpAndSettle();

    expect(completer.isCompleted, false);
    expect(find.text(TITLE), findsOneWidget);
  }, skip: true);

  testWidgets('Tap on text calls callback', (WidgetTester tester) async {
    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(Key(SUBJECT_KEY)));
    await tester.pumpAndSettle();
    await tester.tap(find.text(TITLE));
    await tester.pumpAndSettle();

    expect(find.text(TITLE), findsNothing);
    expect(completer.isCompleted, true);
  }, skip: true);
}
