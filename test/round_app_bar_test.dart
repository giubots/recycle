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

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recycle/round_app_bar.dart';

import 'testing_helpers.dart';

void main() {
  var subject;
  const TITLE = 'test title';
  const CHILD_KEY = 'child';

  setUp(() {
    subject = addMaterial(RoundAppBar(
      title: TITLE,
      actions: [Placeholder(key: Key(CHILD_KEY))],
    ));
  });

  testWidgets('Title is displayed', (WidgetTester tester) async {
    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();

    expect(find.text(TITLE), findsOneWidget);
  });

  testWidgets('Actions are visible', (WidgetTester tester) async {
    await tester.pumpWidget(subject);
    await tester.pumpAndSettle();

    expect(find.byKey(Key(CHILD_KEY)), findsOneWidget);
  });
}
