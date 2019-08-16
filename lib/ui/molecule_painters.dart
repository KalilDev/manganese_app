import 'dart:math';

import 'package:flutter/material.dart';

final Map<Brightness, Color> kBondColor = {
  Brightness.light: Colors.black,
  Brightness.dark: Colors.grey[400]
};
final Map<Brightness, Color> kManganeseColor = {
  Brightness.light: Colors.blueGrey,
  Brightness.dark: Colors.blueGrey[400]
};
final Map<Brightness, Color> kSulfurColor = {
  Brightness.light: Colors.amber,
  Brightness.dark: Colors.amber[300]
};
final Map<Brightness, Color> kOxygenColor = {
  Brightness.light: Colors.lightBlue,
  Brightness.dark: Colors.lightBlue[400]
};

class ManganeseSulfidePainter extends CustomPainter {
  ManganeseSulfidePainter(this.style, this.brightness);
  final TextStyle style;
  final Brightness brightness;
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final kTextSize = size.height / 3;
    if (style != null)
      TextPainter(
          text: TextSpan(children: [
            TextSpan(
                text: '[',
                style: style.copyWith(
                    color: kBondColor[brightness], fontSize: kTextSize)),
            TextSpan(
                text: 'Mn²⁺',
                style: style.copyWith(
                    color: kManganeseColor[brightness], fontSize: kTextSize)),
            TextSpan(
                text: '][',
                style: style.copyWith(
                    color: kBondColor[brightness], fontSize: kTextSize)),
            TextSpan(
                text: 'S²⁻',
                style: style.copyWith(
                    color: kSulfurColor[brightness], fontSize: kTextSize)),
            TextSpan(
                text: ']',
                style: style.copyWith(
                    color: kBondColor[brightness], fontSize: kTextSize)),
          ]),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center)
        ..layout(maxWidth: size.width, minWidth: size.width)
        ..paint(canvas, Offset(0, size.height / 2 - kTextSize / 2 - 1.5));
  }
}

class ManganeseDioxidePainter extends CustomPainter {
  ManganeseDioxidePainter(this.style, this.brightness);
  final TextStyle style;
  final Brightness brightness;
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final kTextSize = size.height / 3;
    if (style != null)
      TextPainter(
          text: TextSpan(
              text: 'Mn',
              style: style.copyWith(
                  color: kManganeseColor[brightness], fontSize: kTextSize)),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center)
        ..layout(maxWidth: size.width, minWidth: size.width)
        ..paint(canvas, Offset(0, size.height / 2 - kTextSize / 2 - 1.5));

    if (style != null)
      TextPainter(
          text: TextSpan(
              text: 'O',
              style: style.copyWith(
                  color: kOxygenColor[brightness], fontSize: kTextSize)),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.left)
        ..layout(maxWidth: size.width, minWidth: size.width)
        ..paint(canvas, Offset(0, size.height - 2 * (kTextSize / 2 - 1.5)));

    if (style != null)
      TextPainter(
          text: TextSpan(
              text: 'O',
              style: style.copyWith(
                  color: kOxygenColor[brightness], fontSize: kTextSize)),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right)
        ..layout(maxWidth: size.width, minWidth: size.width)
        ..paint(canvas, Offset(0, 0));

    _doubleBond(
        Offset(0, size.height),
        Offset(size.width / 2, size.height / 2 - (kTextSize / 2 - 1.5)),
        canvas,
        kTextSize,
        brightness: brightness);
    _doubleBond(Offset(size.width / 2, size.height / 2 + (kTextSize / 2 - 1.5)),
        Offset(size.width, 0), canvas, kTextSize,
        brightness: brightness);
  }
}

final Map<Brightness, Paint> bondStrand = {
  Brightness.light: Paint()
    ..style = PaintingStyle.stroke
    ..color = kBondColor[Brightness.light]
    ..strokeWidth = 4.0,
  Brightness.dark: Paint()
    ..style = PaintingStyle.stroke
    ..color = kBondColor[Brightness.dark]
    ..strokeWidth = 4.0,
};

_doubleBond(Offset from, Offset to, Canvas canvas, double elementSize,
    {Brightness brightness}) {
  final finalElementSize = 2 * elementSize / 3;
  const kSpacing = 20.0;
  const kMaxStrandSize = 30.0;
  final cornerSize = kSpacing / sqrt(2);
  final Offset firstBegin =
      from.translate(finalElementSize - cornerSize, -finalElementSize);
  final Offset secondBegin =
      from.translate(finalElementSize, -finalElementSize + cornerSize);
  //canvas.drawLine(from, firstBegin, bondStrand);
  final Offset firstEnd =
      to.translate(-finalElementSize, finalElementSize - cornerSize);
  final Offset secondEnd =
      to.translate(-finalElementSize + cornerSize, finalElementSize);
  final double size = sqrt(
      (firstEnd.dx - firstBegin.dx) * (firstEnd.dx - firstBegin.dx) +
          (firstBegin.dy - firstEnd.dy) * (firstBegin.dy - firstEnd.dy));
  final double diff = (size - kMaxStrandSize) / 2;
  print(diff);

  canvas.drawLine(firstBegin.translate(diff / 2, -diff / 2),
      firstEnd.translate(-diff / 2, diff / 2), bondStrand[brightness]);
  canvas.drawLine(secondBegin, secondEnd, bondStrand[brightness]);
}
