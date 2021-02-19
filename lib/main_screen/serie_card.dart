//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/widgets.dart';

import 'package:lib_marvel/marvel_api.dart';

class SerieGridCard extends StatefulWidget {
  const SerieGridCard({Key key, @required this.serie, @required this.onTap}) : super(key: key);

  final MarvelSerieWrapper serie;
  final Function onTap;

  @override
  State<StatefulWidget> createState() => _SerieGridCardState();
}

class _SerieGridCardState extends State<SerieGridCard> {

  MarvelSerieWrapper get serie => widget.serie;
  bool _isEnabled;

  void initState() {
    super.initState();
    _isEnabled = true;
  }  

  Widget buildCard() {
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

  void _handleTap(final bool isTapDown) {
    setState(() {
      _isEnabled = !isTapDown;
    });
  }

  @override
  Widget build(BuildContext context) {

    final pressedContainer = Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0xffff0000),
    );
  
    return GestureDetector(
      onTapDown: (final TapDownDetails details) {
        _handleTap(true);
      },
      onTapUp: (final TapUpDetails details) {
        _handleTap(false);
         widget.onTap();
      },
      onTapCancel: () {
        _handleTap(false);
      },
      child: _isEnabled ? buildCard() : pressedContainer,
    );
  }
}