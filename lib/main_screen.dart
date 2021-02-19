//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:lib_marvel/marvel_api.dart';

import 'main_screen_bloc.dart';


class MainScreenStyle {
  const MainScreenStyle({@required this.columns, @required this.verticalMargin, @required this.horizontalMargin});
  final int columns;
  final double verticalMargin;
  final double horizontalMargin;
}

class SerieGridCard extends StatelessWidget {
  const SerieGridCard({Key key, @required this.serie}) : super(key: key);

  final MarvelSerieWrapper serie;

  @override
  Widget build(BuildContext context) {

    final double fontSize = 18;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0xff272727),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Center(child: Image(image: NetworkImage(serie.imagePath))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: fontSize*3,
              color: Color(0xee424242),
              child: Center(
                child: Text(
                  serie.title, 
                  style: TextStyle(fontSize: fontSize, color: Color(0xffffffff)),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
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

  Widget buildGrid() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3/2,
        crossAxisCount: widget.style.columns,
        crossAxisSpacing: widget.style.horizontalMargin,
        mainAxisSpacing: widget.style.verticalMargin
      ),
      itemCount: bloc.series.length,
      itemBuilder: (final BuildContext c, final int index) {
        bloc.shouldUpdate(index);
        final serie = bloc.series[index];
        return SerieGridCard(serie: serie);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.reloadSeriesStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (bloc.series==null) {
          return Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () async {
            await bloc.reset();
          },
          child: bloc.series.isEmpty 
            ? ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return const Center(child: Text('No data!'));
              })
            :  buildGrid(),
        );
    });
  }
}