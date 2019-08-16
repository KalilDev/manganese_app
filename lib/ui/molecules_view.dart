import 'package:flutter/material.dart';

import 'molecule_painters.dart';

class MoleculesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: CustomPaint(
          painter: ManganeseSulfidePainter(
              DefaultTextStyle.of(context).style, Theme.of(context).brightness),
        ),
      ),
    );
  }
}
