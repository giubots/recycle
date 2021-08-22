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
import 'package:intl/intl.dart';
import 'package:recycle/event_tile.dart';

import 'testing_helpers.dart';

void main() {
  var subject;
  Completer? completerTap;
  Completer? completerDismiss;
  final DateTime start = DateTime.now();
  final DateTime end = DateTime.now().add(Duration(hours: 1));
  const TEXT = 'sample text';
  const SUBJECT_KEY = 'subject';

  setUp(() {
    completerTap = Completer();
    completerDismiss = Completer();
    subject = addMaterial(EventTile(
      key: Key(SUBJECT_KEY),
      start: start,
      end: end,
      description: TEXT,
      onTap: completerTap!.complete,
      onDismissed: completerDismiss!.complete,
    ));
  });

  testWidgets('Date and text are displayed', (WidgetTester tester) async {
    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();

    expect(find.text(TEXT), findsOneWidget);
    expect(find.text(DateFormat.Hm().format(start)), findsOneWidget);
    expect(find.text(DateFormat.Hm().format(end)), findsOneWidget);
  });

  testWidgets('Tap invokes callback', (WidgetTester tester) async {
    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();
    expect(completerTap!.isCompleted, false);

    await tester.tap(find.text(TEXT));
    await tester.pumpAndSettle();

    expect(completerTap!.isCompleted, true);
  });

  testWidgets('Swipe invokes callback', (WidgetTester tester) async {
    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();
    expect(completerDismiss!.isCompleted, false);

    await tester.drag(find.byType(Dismissible), Offset(500.0, 0.0));
    await tester.pumpAndSettle();

    expect(completerDismiss!.isCompleted, false);
  });
}
