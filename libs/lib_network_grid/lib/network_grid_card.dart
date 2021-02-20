//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class NetworkGridDataWrapper {
  const NetworkGridDataWrapper(this.id, this.title, this.imagePath);
  final int id;
  final String title;
  final String imagePath;
  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'imagePath': imagePath};
  @override
  String toString() {
    return jsonEncode(toJson());
  }
}

class NetworkGridCardStyle {
  const NetworkGridCardStyle({@required this.textBackgroundColor, @required this.textStyle, @required this.selectedLayerColor});
  final Color textBackgroundColor;
  final TextStyle textStyle;
  final Color selectedLayerColor;
}

class NetworkGridCard extends StatefulWidget {
  const NetworkGridCard({Key key, @required this.data, @required this.style, @required this.onTap}) : super(key: key);
  final NetworkGridDataWrapper data;
  final NetworkGridCardStyle style;
  final Function onTap;
  @override
  State<StatefulWidget> createState() => _NetworkGridCardState();
}

class _NetworkGridCardState extends State<NetworkGridCard> {

  NetworkGridDataWrapper get data => widget.data;
  bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _isEnabled = true;
  }  

  Widget buildCard() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Color(0x00ffffff),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Center(
                child: Image(
                  image: NetworkImage(
                    data.imagePath
                  ),
                  loadingBuilder: (final BuildContext c, final Widget child , final ImageChunkEvent loadingProgress) {
                    if (loadingProgress==null) {
                      return child;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                            : null,
                        ),
                      );
                    }
                  },
                ),
              ),
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
                  data.title, 
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