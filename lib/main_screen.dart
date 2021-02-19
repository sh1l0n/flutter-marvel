//
// Created by sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_grid.dart';
import 'package:flutter/src/rendering/sliver.dart';
import 'package:flutter/widgets.dart';
import 'package:marvel/main_screen_bloc.dart';
import 'package:lib_marvel/marvel_api.dart';

import 'main_screen_bloc.dart';


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


  MarvelSerieNotifier notifier;

  @override
  void initState() {
    super.initState();
    notifier =  MarvelSerieNotifier();
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  Widget buildGrid(final List<MarvelSerieWrapper> series) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3/2,
        crossAxisCount: widget.style.columns,
        crossAxisSpacing: widget.style.horizontalMargin,
        mainAxisSpacing: widget.style.verticalMargin
      ),
      itemCount: series.length,
      itemBuilder: (final BuildContext c, final int index) {
        final serie = series[index];
        return Container(
          color: Color(0xff272727),
          child: Stack(
            children: [
              Center(child: Image(image: NetworkImage(serie.imagePath))),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 50,
                  color: Color(0xcc424242),
                  child: Text(serie.title, style: TextStyle(color: Color(0xffffffff))),
                )
              ),
            ],
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<MarvelSerieWrapper>>(
      valueListenable: notifier,
      builder: (BuildContext context, List<MarvelSerieWrapper> series, Widget child) {
        if (series==null) {
          return Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: () async {
            print('reload');
            return await notifier.reload();
          },
          child: series.isEmpty 
            ? ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (BuildContext context, int index) {
                  return const Center(child: Text('No data!'));
              })
            : NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo is ScrollStartNotification && scrollInfo.metrics.extentBefore == 0) {
                    notifier.getLast();
                    return true;
                  } else if (scrollInfo is ScrollEndNotification && scrollInfo.metrics.extentAfter == 0) {
                    notifier.getNext();
                    return true;
                  }
                  return false;
                },
                child: buildGrid(series),
            ),
        );
    });
  }
}