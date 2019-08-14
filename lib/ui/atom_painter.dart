import 'dart:math';

import 'package:flutter/material.dart';

const double phi = 1.6180339887498948482045868343656;
const double goldenAngle = 2.3999632297286533222315555066336;

class AtomPainter extends CustomPainter {
  AtomPainter(this.movement,
      {this.protons,
      this.neutrons,
      this.electronsPerLevel,
      this.symbol,
      this.style});
  final double movement;
  final int protons;
  final int neutrons;
  final Map<int, int> electronsPerLevel;
  final String symbol;
  final TextStyle style;

  factory AtomPainter.manganese(double movement, {TextStyle style}) {
    const int kProtons = 25;
    const int kNeutrons = 30;
    const Map<int, int> kElectronsPerLevel = <int, int>{
      4: 2,
      3: 13,
      2: 8,
      1: 2
    };
    const String kSymbol = 'Mn';
    return AtomPainter(movement,
        protons: kProtons,
        neutrons: kNeutrons,
        electronsPerLevel: kElectronsPerLevel,
        symbol: kSymbol,
        style: style);
  }

  factory AtomPainter.silicon(double movement, {TextStyle style}) {
    const int kProtons = 14;
    const int kNeutrons = 14;
    const Map<int, int> kElectronsPerLevel = <int, int>{3: 4, 2: 8, 1: 2};
    const String kSymbol = 'Si';
    return AtomPainter(movement,
        protons: kProtons,
        neutrons: kNeutrons,
        electronsPerLevel: kElectronsPerLevel,
        symbol: kSymbol,
        style: style);
  }

  factory AtomPainter.iron(double movement, {TextStyle style}) {
    const int kProtons = 26;
    const int kNeutrons = 29;
    const Map<int, int> kElectronsPerLevel = <int, int>{
      4: 2,
      3: 14,
      2: 8,
      1: 2
    };
    const String kSymbol = 'Fe';
    return AtomPainter(movement,
        protons: kProtons,
        neutrons: kNeutrons,
        electronsPerLevel: kElectronsPerLevel,
        symbol: kSymbol,
        style: style);
  }

  factory AtomPainter.carbon(double movement, {TextStyle style}) {
    const int kProtons = 6;
    const int kNeutrons = 6;
    const Map<int, int> kElectronsPerLevel = <int, int>{2: 4, 1: 2};
    const String kSymbol = 'C';
    return AtomPainter(movement,
        protons: kProtons,
        neutrons: kNeutrons,
        electronsPerLevel: kElectronsPerLevel,
        symbol: kSymbol,
        style: style);
  }

  factory AtomPainter.aluminum(double movement, {TextStyle style}) {
    const int kProtons = 13;
    const int kNeutrons = 13;
    const Map<int, int> kElectronsPerLevel = <int, int>{3: 3, 2: 8, 1: 2};
    const String kSymbol = 'Al';
    return AtomPainter(movement,
        protons: kProtons,
        neutrons: kNeutrons,
        electronsPerLevel: kElectronsPerLevel,
        symbol: kSymbol,
        style: style);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Constants
    final double _kSizeOfElectron = size.width / 60;
    final double _kOnePart = size.width /
        (2 + electronsPerLevel.keys.reduce((int i, int i2) => i + i2)) /
        2;
    final Offset _kCenter = Offset(size.width / 2, size.height / 2);

    // Energy level painter
    final Paint _kEnergyLevelPainter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _kSizeOfElectron / 4
      ..color = Colors.indigo;
    final Paint _kEletronPainter = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.orange;

    void drawElectrons(int electrons, {double radius, num frequency}) {
      final double angleElectron = 2 * pi / electrons;
      for (int i = 0; i < electrons; i++) {
        final double angle =
            angleElectron * i + pi / 2 + (movement * (2 * pi) * frequency);
        final Offset posOfAtom =
            _kCenter.translate(cos(angle) * radius, sin(angle) * radius);
        canvas.drawCircle(posOfAtom, _kSizeOfElectron / 2, _kEletronPainter);
      }
    }

    double levelRadius;
    for (int l in electronsPerLevel.keys) {
      final int frequency = electronsPerLevel.keys.toList().indexOf(l) + 1;
      final int electrons = electronsPerLevel[l];
      if (levelRadius == null) {
        levelRadius ??= size.width / 2 - _kSizeOfElectron;
      } else {
        levelRadius -= (l + 1) * _kOnePart;
      }
      canvas.drawCircle(_kCenter, levelRadius, _kEnergyLevelPainter);
      drawElectrons(electrons, radius: levelRadius, frequency: frequency);
    }

    // Nucleus
    final double _kParticleSize = size.width / 100;
    final double _kParticleMovement = _kParticleSize / 16;
    const int _kParticleMovementFrequency = 40;
    final Paint _kProtonPaint = Paint()..color = Colors.lime;
    final Paint _kNeutronPaint = Paint()..color = Colors.blue;
    final double nucleusSize = (protons / 10) * _kParticleSize * 7;
    void drawParticle(Offset position, bool isProton) {
      double angle = 2 * pi * _kParticleMovementFrequency * movement;
      angle = isProton ? angle : -angle;
      try {
        final Offset realPos = position.translate(
            cos(angle) * _kParticleMovement, sin(angle) * _kParticleMovement);
        canvas.drawCircle(
            realPos, _kParticleSize, isProton ? _kProtonPaint : _kNeutronPaint);
      } catch (e) {
        return;
      }
    }

    void drawParticles(int n, bool isProton) {
      for (int i = 0; i <= n; i++) {
        final double theta = i * goldenAngle + (isProton ? pi / 2 + 0.5 : 0.0);
        final double r = sqrt(i) / sqrt(n);
        drawParticle(
            _kCenter.translate(cos(theta) * r * nucleusSize / 2,
                sin(theta) * r * nucleusSize / 2),
            isProton);
      }
    }

    drawParticles(neutrons, false);
    drawParticles(protons, true);
    if (style != null)
      TextPainter(
          text: TextSpan(text: symbol, style: style),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center)
        ..layout(maxWidth: size.width, minWidth: size.width)
        ..paint(canvas, Offset(0, size.height / 2 - style.fontSize / 2 - 1.5));
  }
}
