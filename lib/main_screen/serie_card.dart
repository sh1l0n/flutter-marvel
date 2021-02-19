//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:lib_marvel/marvel_api.dart';


class SerieGridCardStyle {
  const SerieGridCardStyle({@required this.textBackgroundColor, @required this.textStyle, @required this.selectedLayerColor});
  final Color textBackgroundColor;
  final TextStyle textStyle;
  final Color selectedLayerColor;
}

class SerieGridCard extends StatefulWidget {
  const SerieGridCard({Key key, @required this.serie, @required this.style, @required this.onTap}) : super(key: key);
  final MarvelSerieWrapper serie;
  final SerieGridCardStyle style;
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
    return Container(
      width: double.infinity,
      height: double.infinity,
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
              height: widget.style.textStyle.fontSize*3,
              color: widget.style.textBackgroundColor,
              child: Center(
                child: Text(
                  serie.title, 
                  style: widget.style.textStyle,
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

  Widget buildTappedLayer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: widget.style.selectedLayerColor,
    );
  }

  void _handleTap(final bool isTapDown) {
    setState(() {
      _isEnabled = !isTapDown;
    });
  }

  @override
  Widget build(BuildContext context) {

    final card = buildCard();
  
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
      child: _isEnabled ? card : Stack(children: [card, buildTappedLayer()]),
    );
  }
}