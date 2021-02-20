//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:lib_drawer/drawer_bloc.dart';

import '../base_scaffold.dart';
import 'main_screen_bloc.dart';
import 'serie_card.dart';


class MainScreenStyle {
  const MainScreenStyle({@required this.columns, @required this.verticalMargin, @required this.horizontalMargin, @required this.cardStyle});
  final int columns;
  final double verticalMargin;
  final double horizontalMargin;
  final SerieGridCardStyle cardStyle;
}

class MainScreen extends BaseScaffold {
  const MainScreen({Key key, @required this.bloc, @required DrawerBLoC drawerBLoC, @required this.style}) : super(key: key, drawerBLoC: drawerBLoC);
  final MainScreenStyle style;
  final MainScreenBLoC bloc;

  static String get route => '/';

  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends BaseScaffoldState {

  MainScreenBLoC get bloc => (widget as MainScreen).bloc;
  MainScreenStyle get style => (widget as MainScreen).style;

  @override
  Widget buildBody(final BuildContext context) {
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
      }
    );
  }

  Widget buildGrid() {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3/2,
        crossAxisCount: style.columns,
        crossAxisSpacing: style.horizontalMargin,
        mainAxisSpacing: style.verticalMargin
      ),
      itemCount: bloc.series.length,
      itemBuilder: (final BuildContext c, final int index) {
        bloc.shouldUpdate(index);
        final serie = bloc.series[index];
        return SerieGridCard(
          serie: serie,
          style: style.cardStyle,
          onTap: () {
            print('onTap: $index');
          },
        );
      },
    );
  }
}