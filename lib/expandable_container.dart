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

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// A container that shows its child in the center of the screen.
///
/// Usage: use a transparent PageRouteBuilder; pass to this
/// an [animationController] with value `1` to expand and contract it using its
/// [forward] and [reverse] methods.
///
/// Example:
///
/// ```dart
/// controller.reverse();
/// await Future.delayed(animationDuration - Duration(milliseconds: 100));
/// await widget.pushFade(route);
/// controller.forward();
/// ```

class ExpandableContainer extends StatefulWidget {
  final Widget child;
  final AnimationController animationController;

  const ExpandableContainer(
      {Key? key, required this.child, required this.animationController})
      : super(key: key);

  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  late Animation _animation;
  var myChildSize = Size.zero;

  @override
  void initState() {
    super.initState();
    _animation =
        CurveTween(curve: Curves.easeInOut).animate(widget.animationController);
    _animation.addListener(() => setState(() {}));
  }

  Widget build(BuildContext context) {
    final sHeight = MediaQuery.of(context).size.height;
    final pHeight = (sHeight - myChildSize.height) / 2;

    return AnimatedContainer(
      duration: Duration(seconds: 1),
      child: MeasureSize(
        onChange: (size) => setState(() => myChildSize = size),
        child: widget.child,
      ),
    );
  }
}

typedef void OnWidgetSizeChange(Size size);

class MeasureSizeRenderObject extends RenderProxyBox {
  Size oldSize = Size.zero;
  final OnWidgetSizeChange onChange;

  MeasureSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();

    Size newSize = child?.size ?? oldSize;
    if (oldSize == newSize) return;

    oldSize = newSize;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}

class MeasureSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const MeasureSize({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return MeasureSizeRenderObject(onChange);
  }
}
