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
import 'package:recycle/loading_screen.dart';

import 'testing_helpers.dart';

void main() {
  var subject;
  var completer;
  const CHILD_KEY = 'child';
  const NEXT_KEY = 'next';

  testWidgets('Child is visible', (WidgetTester tester) async {
    completer = Completer();
    subject = addMaterial(LoadingScreen(
      work: completer.future,
      nextWidget: () => Placeholder(key: Key(NEXT_KEY)),
      child: Placeholder(key: Key(CHILD_KEY)),
    ));

    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();

    expect(find.byKey(Key(CHILD_KEY)), findsOneWidget);
    expect(find.byKey(Key(NEXT_KEY)), findsNothing);
  });

  testWidgets('Child has default value', (WidgetTester tester) async {
    completer = Completer();
    subject = addMaterial(LoadingScreen(
      work: completer.future,
      nextWidget: () => Placeholder(key: Key(NEXT_KEY)),
    ));

    await tester.pumpWidget(subject);
    await tester.pump();

    expect(
      find.byType(CircularProgressIndicator),
      findsOneWidget,
    );
    expect(find.byKey(Key(NEXT_KEY)), findsNothing);
  });

  testWidgets('nextChild becomes visible', (WidgetTester tester) async {
    completer = Completer();
    subject = addMaterial(LoadingScreen(
      work: completer.future,
      nextWidget: () => Placeholder(key: Key(NEXT_KEY)),
      child: Placeholder(key: Key(CHILD_KEY)),
    ));

    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();

    completer.complete();

    await tester.pumpAndSettle();

    expect(find.byKey(Key(CHILD_KEY)), findsNothing);
    expect(find.byKey(Key(NEXT_KEY)), findsOneWidget);
  });
}
