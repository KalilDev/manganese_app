import 'dart:math';

import 'package:flutter/material.dart';
import 'package:manganese_app/model/atom.dart';

const double phi = 1.6180339887498948482045868343656;
const double goldenAngle = 2.3999632297286533222315555066336;

class AtomTheme {
  AtomTheme(
      {this.protonColor,
      this.electronColor,
      this.neutronColor,
      this.electronSize = 4.0,
      this.levelSize = 4.0,
      this.particleSize = 10.0,
      this.particleShake = 2.0,
      this.textColor,
      this.levelColor});
  factory AtomTheme.dark(
      {double electronSize,
      double levelSize,
      double particleSize,
      double particleShake}) {
    return AtomTheme(
        protonColor: Colors.red[200],
        neutronColor: Colors.green[200],
        levelColor: Colors.yellow[100],
        electronColor: Colors.yellow[400],
        textColor: Colors.black,
        electronSize: electronSize,
        particleSize: particleSize,
        levelSize: levelSize,
        particleShake: particleShake);
  }
  factory AtomTheme.light(
      {double electronSize,
      double levelSize,
      double particleSize,
      double particleShake}) {
    return AtomTheme(
        protonColor: Colors.red,
        neutronColor: Colors.green,
        levelColor: Colors.amber[200],
        electronColor: Colors.amber,
        textColor: Colors.black,
        electronSize: electronSize,
        particleSize: particleSize,
        levelSize: levelSize,
        particleShake: particleShake);
  }
  final Color protonColor;
  final Color neutronColor;
  final Color electronColor;
  final Color levelColor;
  final Color textColor;
  final double electronSize;
  final double levelSize;
  final double particleSize;
  final double particleShake;
  AtomTheme copyWith(
      {Color protonColor,
      Color neutronColor,
      Color electronColor,
      Color levelColor,
      Color textColor,
      double electronSize,
      double levelSize,
      double particleSize,
      double particleShake}) {
    return AtomTheme(
        protonColor: protonColor ?? this.protonColor,
        neutronColor: neutronColor ?? this.neutronColor,
        electronColor: electronColor ?? this.electronColor,
        levelColor: levelColor ?? this.levelColor,
        textColor: textColor ?? this.textColor,
        electronSize: electronSize ?? this.electronSize,
        levelSize: levelSize ?? this.levelSize,
        particleSize: particleSize ?? this.particleSize,
        particleShake: particleShake ?? this.particleShake);
  }
}

class AtomPainter extends CustomPainter {
  AtomPainter(this.movement,
      {this.protons,
      this.neutrons,
      this.electronsPerLevel,
      this.symbol,
      this.style,
      this.theme});
  final double movement;
  final int protons;
  final int neutrons;
  final Map<int, int> electronsPerLevel;
  final String symbol;
  final TextStyle style;
  final AtomTheme theme;

  factory AtomPainter.fromAtom(double movement,
      {@required Atom atom,
      Brightness brightness,
      TextStyle style,
      AtomTheme theme}) {
    assert(brightness == null || theme == null);
    AtomTheme atomTheme = theme ??
        (brightness ?? Brightness.light == Brightness.light
            ? AtomTheme.light()
            : AtomTheme.dark());

    return AtomPainter(movement,
        protons: atom.protons,
        neutrons: atom.neutrons,
        electronsPerLevel: atom.electronsPerLevel,
        symbol: atom.symbol,
        style: style,
        theme: atomTheme);
  }
  factory AtomPainter.manganese(double movement,
      {Brightness brightness, TextStyle style, AtomTheme theme}) {
    final Atom atom = Atom.manganese();
    return AtomPainter.fromAtom(movement,
        atom: atom, brightness: brightness, style: style, theme: theme);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // Constants
    final double _kSizeOfElectron = theme.electronSize ?? size.width / 60;
    final Offset _kCenter = Offset(size.width / 2, size.height / 2);
    // Nucleus
    final double _kParticleSize = theme.particleSize ?? size.width / 100;
    final double _kParticleMovement =
        theme.particleShake ?? _kParticleSize / 16;
    const int _kParticleMovementFrequency = 40;
    final Paint _kProtonPaint = Paint()..color = theme.protonColor;
    final Paint _kNeutronPaint = Paint()..color = theme.neutronColor;
    final double nucleusSize =
        (protons / (10 + protons / 140 * 25)) * _kParticleSize * 7;
    List<Offset> scheduledProtons = List();
    List<Offset> scheduledNeutrons = List();
    void drawParticle(Offset position, bool isProton) {
      double angle = 2 * pi * _kParticleMovementFrequency * movement;
      angle = isProton ? angle : -angle;
      try {
        final Offset realPos = position.translate(
            cos(angle) * _kParticleMovement, sin(angle) * _kParticleMovement);
        isProton
            ? scheduledProtons.add(realPos)
            : scheduledNeutrons.add(realPos);
      } catch (e) {
        return;
      }
    }

    final double _kOnePart = size.width /
            (2 + electronsPerLevel.keys.reduce((int i, int i2) => i + i2)) /
            2 -
        (nucleusSize /
                (electronsPerLevel.keys.reduce((int i, int i2) => i + i2))) /
            2;

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

    void commitScheduled() {
      final int m = max(scheduledNeutrons.length, scheduledProtons.length);
      for (int i = 0; i < m; i++) {
        if (scheduledProtons.length > i) {
          canvas.drawCircle(scheduledProtons[i], _kParticleSize, _kProtonPaint);
        }
        if (scheduledNeutrons.length > i) {
          canvas.drawCircle(
              scheduledNeutrons[i], _kParticleSize, _kNeutronPaint);
        }
      }
    }

    // Energy level painter
    final Paint _kEnergyLevelPainter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = theme.levelSize ?? _kSizeOfElectron / 4
      ..color = theme.levelColor;
    final Paint _kEletronPainter = Paint()
      ..style = PaintingStyle.fill
      ..color = theme.electronColor;

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

    drawParticles(neutrons, false);
    drawParticles(protons, true);
    commitScheduled();
    if (style != null)
      TextPainter(
          text: TextSpan(
              text: symbol, style: style.copyWith(color: theme.textColor)),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center)
        ..layout(maxWidth: size.width, minWidth: size.width)
        ..paint(canvas, Offset(0, size.height / 2 - style.fontSize / 2 - 1.5));
  }
}
