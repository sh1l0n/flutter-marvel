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

    final height = style.textStyle.fontSize*2;

    return Container(
      width: double.infinity,
      height: height,
      color: style.backgroundColor,
      child: Row(
        children: [
          Container(
            width: height,
            height: height,
            child: FittedBox(
              fit: BoxFit.fill,
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
                }
              ),
            ),
          ),
          Container(width: style.textStyle.fontSize*0.25),
          Text(
            data.title, 
            style: style.textStyle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}