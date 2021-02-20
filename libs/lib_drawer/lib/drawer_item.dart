//
// Created by @sh1l0n
//
// Licensed by GPLv3
// This file is part of lib_drawer package
//

import 'package:flutter/material.dart';


class DrawerItemStyle {
  const DrawerItemStyle({@required this.textStyle, @required this.height, @required this.marginBetweenIconText, @required this.selectedColor});
  final TextStyle textStyle;
  final double height;
  final double marginBetweenIconText;
  final Color selectedColor;
}

class DrawerItem extends StatefulWidget {
  const DrawerItem({Key key, @required this.title, @required this.icon, @required this.style, @required this.onTap, @required this.isSelected}) : super(key: key);

  final String title;
  final IconData icon;
  final DrawerItemStyle style;
  final Function onTap;
  final bool isSelected;

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
      height: widget.style.height,
      color: _isEnabled && !widget.isSelected ? Color(0x00ffffff) : widget.style.selectedColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(widget.icon),
          Container(width: widget.style.marginBetweenIconText),
          Text(widget.title, style: widget.style.textStyle),
        ],
      )
    );
  }
}