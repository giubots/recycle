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
import 'package:recycle/toggle_visible.dart';

import 'testing_helpers.dart';

void main() {
  const SUBJECT_KEY = 'subject';

  testWidgets('Initialization value: true', (WidgetTester tester) async {
    var completer = Completer();
    var subject = addMaterial(ToggleVisible(
      key: Key(SUBJECT_KEY),
      value: true,
      onChanged: (value) => completer.complete(value),
    ));

    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    expect(find.byIcon(Icons.visibility_off_outlined), findsNothing);
  });

  testWidgets('Initialization value: false', (WidgetTester tester) async {
    var completer = Completer();
    var subject = addMaterial(ToggleVisible(
      key: Key(SUBJECT_KEY),
      value: false,
      onChanged: (value) => completer.complete(value),
    ));

    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.visibility_outlined), findsNothing);
    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
  });

  testWidgets('Tap on button sends value', (WidgetTester tester) async {
    var completer = Completer();
    var subject = addMaterial(ToggleVisible(
      key: Key(SUBJECT_KEY),
      value: true,
      onChanged: (value) => completer.complete(value),
    ));

    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.visibility_outlined));
    await tester.pumpAndSettle();

    expect(completer.isCompleted, true);
    await tester.runAsync(() async => expect(await completer.future, false));
  });
}
