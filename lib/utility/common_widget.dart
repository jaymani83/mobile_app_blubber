import 'package:flexiares/utility/color_scheme.dart';
import 'package:flutter/material.dart';

class CommonWidget {
  const CommonWidget();

  ButtonStyle buttonStyle([Color? color, double radius = 12.0]) {
    final themeColor = color ?? CustomColorScheme.btnColor;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );
    return ElevatedButton.styleFrom(
      backgroundColor: themeColor,
      shape: shape,
    );
  }

  Widget customListTile(dynamic title, dynamic subtitle, {bool withCard = true}) {
    final _tile = Column(
      children: [
        ListTile(
          title: Text(title?.toString() ?? ''),
          subtitle: Text(subtitle?.toString() ?? ''),
        ),
      ],
    );

    return withCard ? Card(child: _tile) : _tile;
  }
}
