import 'package:flutter/material.dart';

const Color kBondColor = Colors.black;
const Color kManganeseColor = Colors.blueGrey;
const Color kSulfurColor = Colors.amber;
const Color kOxygenColor = Colors.blueAccent;

class ManganeseSulfidePainter extends CustomPainter {
  ManganeseSulfidePainter(this.style);
  final TextStyle style;
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
                style: style.copyWith(color: kBondColor, fontSize: kTextSize)),
            TextSpan(
                text: 'Mn²⁺',
                style: style.copyWith(
                    color: kManganeseColor, fontSize: kTextSize)),
            TextSpan(
                text: '][',
                style: style.copyWith(color: kBondColor, fontSize: kTextSize)),
            TextSpan(
                text: 'S²⁻',
                style:
                    style.copyWith(color: kSulfurColor, fontSize: kTextSize)),
            TextSpan(
                text: ']',
                style: style.copyWith(color: kBondColor, fontSize: kTextSize)),
          ]),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center)
        ..layout(maxWidth: size.width, minWidth: size.width)
        ..paint(canvas, Offset(0, size.height / 2 - kTextSize / 2 - 1.5));
  }
}

class ManganeseDioxidePainter extends CustomPainter {
  ManganeseDioxidePainter(this.style);
  final TextStyle style;
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
              style:
                  style.copyWith(color: kManganeseColor, fontSize: kTextSize)),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center)
        ..layout(maxWidth: size.width, minWidth: size.width)
        ..paint(canvas, Offset(0, size.height / 2 - kTextSize / 2 - 1.5));

    if (style != null)
      TextPainter(
          text: TextSpan(
              text: 'O',
              style: style.copyWith(color: kOxygenColor, fontSize: kTextSize)),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.left)
        ..layout(maxWidth: size.width, minWidth: size.width)
        ..paint(canvas, Offset(0, size.height - 2 * (kTextSize / 2 - 1.5)));

    if (style != null)
      TextPainter(
          text: TextSpan(
              text: 'O',
              style: style.copyWith(color: kOxygenColor, fontSize: kTextSize)),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right)
        ..layout(maxWidth: size.width, minWidth: size.width)
        ..paint(canvas, Offset(0, 0));

    _doubleBond(Offset(size.width / 2, size.height / 2), Offset(0, size.height),
        canvas);
    _doubleBond(Offset(size.width, kTextSize / 2 - 1.5),
        Offset(size.width / 2, size.height / 2 + kTextSize / 2 - 1.5), canvas);
  }
}

final Paint bondStrand = Paint()
  ..style = PaintingStyle.stroke
  ..color = kBondColor
  ..strokeWidth = 4.0;
_doubleBond(Offset from, Offset to, Canvas canvas) {
  const kSpacing = 60.0;
  final Offset firstBegin = from.translate(-kSpacing, 0);
  final Offset secondBegin = from.translate(-kSpacing, kSpacing / 4);
  final Offset firstEnd = to.translate(kSpacing, -kSpacing + kSpacing / 4);
  final Offset secondEnd = to.translate(kSpacing, -kSpacing / 2);

  canvas.drawLine(firstBegin, firstEnd, bondStrand);
  canvas.drawLine(secondBegin, secondEnd, bondStrand);
}
