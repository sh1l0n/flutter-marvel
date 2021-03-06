//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of lib_network_grid package
//

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'network_grid_bloc.dart';
import 'network_grid_card.dart';


class NetworkGridStyle {
  const NetworkGridStyle({@required this.columns, @required this.verticalMargin, @required this.horizontalMargin, @required this.cardStyle});
  final int columns;
  final double verticalMargin;
  final double horizontalMargin;
  final NetworkGridCardStyle cardStyle;
}

class NetworkGrid extends StatelessWidget {
  const NetworkGrid({Key key, @required this.placeholder, @required this.bloc, @required this.style, @required this.onTap}) : super(key: key);
  final String placeholder;
  final NetworkGridStyle style;
  final NetworkGridBLoC bloc;
  final Function(NetworkGridDataWrapper) onTap;

  static String get route => '/';

  @override
  Widget build(final BuildContext context) {
    return StreamBuilder(
      stream: bloc.reloadSeriesStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (bloc.data==null) {
          return Center(child: CircularProgressIndicator());
        }
        return RefreshIndicator(
          onRefresh: () async {
            await bloc.reset();
          },
          child: bloc.data.isEmpty 
            ? ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (final BuildContext context, int index) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          placeholder,
                          style: style.cardStyle.textStyle,
                        ),
                        Center(
                          child: Icon(
                            Icons.arrow_downward,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ],
                    ),
                  );
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
      itemCount: bloc.data.length,
      itemBuilder: (final BuildContext c, final int index) {
        bloc.shouldUpdate(index);
        final serie = bloc.data[index];
        return NetworkGridCard(
          data: NetworkGridDataWrapper(serie.id, serie.title, serie.imagePath),
          style: style.cardStyle,
          onTap: () {
            onTap(serie);
          },
        );
      },
    );
  }
}