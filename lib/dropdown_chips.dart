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

/// A [FormField] with a [DropdownButtonFormField] and some [Chip].
///
/// The user can choose amongst the [items], the chosen item is added to a section
/// under the dropdown menu as a chip. The chip can be removed and added back again.
/// The items can be added only once
///
/// The [labelText] is showed on the dropdown button.
/// The [nameBuilder] is used to produce the label from the object [T].
class DropdownAndChipsFormField<T> extends FormField<Set<T>> {
  DropdownAndChipsFormField({
    Key? key,
    onSaved,
    initialValue,
    labelText,
    required Set<T> items,
    required String Function(T element) nameBuilder,
  }) : super(
          key: key,
          onSaved: onSaved,
          initialValue: initialValue ?? {},
          builder: (FormFieldState<Set<T>> field) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<T>(
                  items: items.map((i) {
                    return DropdownMenuItem<T>(
                      value: i,
                      child: Text(nameBuilder(i)),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: labelText),
                  onChanged: (value) async {
                    if (value == null) return;
                    field.value!.add(value);
                  },
                ),
                Wrap(
                  spacing: 4.0,
                  children: field.value!.map((i) {
                    return Chip(
                      label: Text(nameBuilder(i)),
                      onDeleted: () async {
                        var newValue = field.value!;
                        newValue.remove(i);
                        field.didChange(newValue);
                      },
                    );
                  }).toList(),
                ),
              ],
            );
          },
        );
}
