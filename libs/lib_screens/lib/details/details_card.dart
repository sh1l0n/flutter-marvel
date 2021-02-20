//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';

import 'package:lib_network_grid/network_grid_card.dart';


class DetailsCardStyle {
  const DetailsCardStyle({@required this.textStyle, @required this.backgroundColor});
  final TextStyle textStyle;
  final Color backgroundColor;
}

class DetailsCard extends StatelessWidget {
  const DetailsCard({Key key, @required this.data, @required this.style}) : super(key: key);

  final NetworkGridDataWrapper data;
  final DetailsCardStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: style.textStyle.fontSize*2,
      color: style.backgroundColor,
      child: Row(
        children: [
          Container(
            child: FittedBox(
              fit: BoxFit.fitHeight,
              child: Center(child: Image(image: NetworkImage(data.imagePath))),
            ),
          ),
          Center(
            child: Text(
              data.title, 
              style: style.textStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}