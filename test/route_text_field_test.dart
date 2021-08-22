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
import 'package:recycle/route_text_field.dart';

import 'testing_helpers.dart';

void main() {
  var subject;
  Completer? completer;
  const APP_BAR_KEY = 'app bar';
  const HEADER_KEY = 'header';
  const TITLE = 'test title';
  const TEXT = 'text inserted';
  const HINT = 'hint text';
  const BUTTON_TEXT = 'button';
  const FOOTER_KEY = 'footer';
  const SUBJECT_KEY = 'subject';

  setUp(() {
    completer = Completer();
    subject = addMaterial(OneTextFieldRoute(
      key: Key(SUBJECT_KEY),
      buttonLabel: BUTTON_TEXT,
      mainText: TITLE,
      onPressed: (context, value) => Future(() {
        completer!.complete(value);
        return true;
      }),
      appBar: AppBar(key: Key(APP_BAR_KEY)),
      fieldHint: HINT,
      header: Placeholder(key: Key(HEADER_KEY)),
      footer: Placeholder(key: Key(FOOTER_KEY)),
    ));
  });

  testWidgets('All widget are displayed', (WidgetTester tester) async {
    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();

    expect(find.byKey(Key(APP_BAR_KEY)), findsOneWidget);
    expect(find.byKey(Key(HEADER_KEY)), findsOneWidget);
    expect(find.text(TITLE), findsOneWidget);
    expect(find.text(HINT), findsOneWidget);
    expect(find.text(BUTTON_TEXT), findsOneWidget);
    expect(find.byKey(Key(FOOTER_KEY)), findsOneWidget);
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
    await tester.tap(find.byKey(Key(SUBJECT_KEY)));
    await tester.pumpAndSettle();

    expect(completer!.isCompleted, false);
  });
}
