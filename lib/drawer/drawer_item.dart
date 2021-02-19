//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of Flutter-Marvel project
//

import 'package:flutter/material.dart';


class DrawerItem extends StatefulWidget {
  const DrawerItem({Key key, @required this.title, @required this.onTap}) : super(key: key);

  final String title;
  final Function onTap;

  @override
  State<StatefulWidget> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {

  bool _isEnabled;

  @override
  void initState() {
    super.initState();
    _isEnabled = true;
  }

  void _handleTap(final bool isTapDown) {
    setState(() {
      _isEnabled = !isTapDown;
    });
  }

  @override
  Widget build(BuildContext context) {

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
      child: buildItem(),
    );
  }

  Widget buildItem() {
    return Container(
      width: double.infinity,
      height: 30,
      color: _isEnabled ? Color(0x00ffffff) : Color(0xff000000),
      child: Text(widget.title),
    );
  }
}