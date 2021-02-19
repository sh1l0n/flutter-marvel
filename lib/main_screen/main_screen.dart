//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:marvel/drawer/drawer.dart';
import 'package:marvel/drawer/drawer_bloc.dart';

import 'main_screen_bloc.dart';
import 'serie_card.dart';


class MainScreenStyle {
  const MainScreenStyle({@required this.columns, @required this.verticalMargin, @required this.horizontalMargin, @required this.cardStyle});
  final int columns;
  final double verticalMargin;
  final double horizontalMargin;
  final SerieGridCardStyle cardStyle;
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key key, @required this.bloc, @required this.drawerBLoC, @required this.style}) : super(key: key);
  final MainScreenStyle style;
  final MainScreenBLoC bloc;
  final MarvelDrawerBLoC drawerBLoC;

  static String get route => '/';

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
        return SerieGridCard(
          serie: serie,
          style: widget.style.cardStyle,
          onTap: () {
            print('onTap: $index');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          title: Text('Hello world'),
        ),
      ),
      drawer: MarvelDrawer(bloc: widget.drawerBLoC),
      body: StreamBuilder(
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
        }
      ),
    );
  }
}