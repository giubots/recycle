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
import 'package:recycle/text_field_icon.dart';

import 'testing_helpers.dart';

void main() {
  var subject;
  Completer? completer;
  const LABEL = 'test title';
  const TEXT = 'sample text';
  const EDITED = 'edited text';
  const SUBJECT_KEY = 'subject';

  setUp(() {
    completer = Completer();
    subject = addMaterial(TextFieldIcon(
      key: Key(SUBJECT_KEY),
      label: LABEL,
      initialValue: TEXT,
      icon: Icon(Icons.done),
      onChanged: (value) => completer!.complete(value),
    ));
  });

  testWidgets('Label is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();

    expect(find.text(LABEL), findsOneWidget);
  });

  testWidgets('Can write to text field', (WidgetTester tester) async {
    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), EDITED);
    await tester.pumpAndSettle();

    expect(find.text(EDITED), findsOneWidget);
  });

  testWidgets('Tap on button sends text', (WidgetTester tester) async {
    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();

    expect(completer!.isCompleted, false);
    await tester.enterText(find.byType(TextField), EDITED);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.done));
    await tester.pumpAndSettle();

    expect(completer!.isCompleted, true);
    await tester.runAsync(() async => expect(await completer!.future, EDITED));
  });
}
