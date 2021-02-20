
import 'package:flutter/material.dart';

import 'package:lib_network_grid/network_grid_card.dart';


class DetailsScreenStyle {
  const DetailsScreenStyle({@required this.appBarColor, @required this.appBarHeight, @required this.backgroundColor});
  final Color appBarColor;
  final double appBarHeight;
  final Color backgroundColor;
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key key, @required this.style, @required this.serie}) : super(key: key);

  static const String route = '/details';

  final DetailsScreenStyle style;
  final NetworkGridDataWrapper serie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(style.appBarHeight), // here the desired height
        child: AppBar(
          backgroundColor: style.appBarColor,
          title: Text('Details'),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: style.backgroundColor,
        child: Container(),
      )
    );
  }


}