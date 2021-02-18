//
// Created by sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/src/rendering/sliver_grid.dart';
import 'package:flutter/src/rendering/sliver.dart';
import 'package:flutter/widgets.dart';


class MainScreenStyle {
  const MainScreenStyle({@required this.columns, @required this.verticalMargin, @required this.horizontalMargin});
  final int columns;
  final double verticalMargin;
  final double horizontalMargin;
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key key, @required this.style}) : super(key: key);
  final MainScreenStyle style;

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 3/2,
          crossAxisCount: widget.style.columns,
          crossAxisSpacing: widget.style.horizontalMargin,
          mainAxisSpacing: widget.style.verticalMargin
        ),
        itemCount: 20,
        itemBuilder: (final BuildContext c, final int index) {
          return Container(
            color: Color(0xffff0000),
          );
        },
      ),
    );
  }
}