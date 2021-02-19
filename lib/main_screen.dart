//
// Created by sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/src/rendering/sliver_grid.dart';
import 'package:flutter/src/rendering/sliver.dart';
import 'package:flutter/widgets.dart';
import 'package:marvel/main_screen_bloc.dart';
import 'package:lib_marvel/marvel_api.dart';


class MainScreenStyle {
  const MainScreenStyle({@required this.columns, @required this.verticalMargin, @required this.horizontalMargin});
  final int columns;
  final double verticalMargin;
  final double horizontalMargin;
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key key, @required this.bloc, @required this.style}) : super(key: key);
  final MainScreenStyle style;
  final MainScreenBLoC bloc;

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  MainScreenBLoC get bloc => widget.bloc;

  Widget buildGrid(final BuildContext context) {
    return StreamBuilder(
      stream: bloc.getSeriesStream,
      builder: (final BuildContext context, final AsyncSnapshot<List<MarvelSerieWrapper>> snapshot) {
        final List<MarvelSerieWrapper> data = snapshot.hasData ? snapshot.data : [];
        return GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3/2,
            crossAxisCount: widget.style.columns,
            crossAxisSpacing: widget.style.horizontalMargin,
            mainAxisSpacing: widget.style.verticalMargin
          ),
          itemCount: data.length,
          itemBuilder: (final BuildContext c, final int index) {
            return Container(
              color: Color(0xffff0000),
            );
          }
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: buildGrid(context),
    );
  }
}