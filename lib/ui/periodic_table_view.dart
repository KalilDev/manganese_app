import 'dart:math';

import 'package:flutter/material.dart';
import 'package:manganese_app/text.dart';

import 'atom_painter.dart';

const int kWidth = 2339;
const int kHeight = 1654;

class PeriodicTableView extends StatefulWidget {
  @override
  _PeriodicTableViewState createState() => _PeriodicTableViewState();
}

class _PeriodicTableViewState extends State<PeriodicTableView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  bool isHidden = false;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPositionedText(
      BuildContext context, BoxConstraints constraints) {
    final Size size = constraints.biggest;

    /// Dependent on rotation
    final bool isPortrait = kWidth / kHeight <= size.aspectRatio;
    double pixelSize;
    Offset textBeginOffset;
    if (isPortrait) {
      pixelSize = size.height / kHeight;
      textBeginOffset = Offset(pixelSize * kWidth, 0);
    } else {
      pixelSize = size.width / kWidth;
      textBeginOffset = Offset(0, kHeight * pixelSize);
    }
    return Positioned(
        top: textBeginOffset.dy,
        left: textBeginOffset.dx,
        child: SizedBox(
            height: size.height - textBeginOffset.dy,
            width: size.width - textBeginOffset.dx,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(mainText),
            )));
  }

  Widget _buildPositioned(BuildContext context, BoxConstraints constraints) {
    /// Constants
    const int kMStartHeight = 609;
    const int kMStartWidth = 868;
    const int kMEndHeight = 741;
    const int kMEndWidth = 981;
    final Size size = constraints.biggest;

    /// Dependent on rotation
    final bool isPortrait = kWidth / kHeight <= size.aspectRatio;
    double pixelSize;
    Offset imgBeginOffset;
    if (isPortrait) {
      pixelSize = size.height / kHeight;
      imgBeginOffset = Offset(0, 0);
    } else {
      pixelSize = size.width / kWidth;
      imgBeginOffset = Offset(0, 0);
    }
    final Size manganeseSize = Size(pixelSize * (kMEndWidth - kMStartWidth),
        pixelSize * (kMEndHeight - kMStartHeight));
    final Offset manganeseBeginOffset = imgBeginOffset +
        Offset(kMStartWidth * pixelSize, kMStartHeight * pixelSize);
    final double maxHeight =
        min(manganeseBeginOffset.dy, size.width / 4 + 40.0);
    double textSize = DefaultTextStyle.of(context).style.fontSize * 0.8 * 8;
    return Positioned(
        bottom: size.height - manganeseBeginOffset.dy - manganeseSize.height,
        left: manganeseBeginOffset.dx,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              transitionBuilder: (Widget child, Animation<double> anim) {
                return SizedBox(
                  height: maxHeight,
                  width: max(textSize, maxHeight - 30),
                  child: SlideTransition(
                    position: Tween<Offset>(
                            end: Offset.zero,
                            begin: Offset(0, -size.height / maxHeight))
                        .animate(anim),
                    child: child,
                  ),
                );
              },
              child: isHidden
                  ? SizedBox()
                  : Material(
                      type: MaterialType.card,
                      child: InkWell(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12.0),
                            topRight: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0)),
                        onTap: () => setState(() => isHidden = !isHidden),
                        child: SizedBox(
                            height: maxHeight,
                            width: maxHeight - 40,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: <Widget>[
                                  SizedBox(
                                    height: maxHeight - 30,
                                    child: Center(
                                      child: AspectRatio(
                                        aspectRatio: 1.0,
                                        child: AnimatedBuilder(
                                          animation: _animation,
                                          builder: (_, __) => CustomPaint(
                                            painter: AtomPainter.manganese(
                                                _animation.value,
                                                theme: Theme.of(context)
                                                            .brightness ==
                                                        Brightness.light
                                                    ? AtomTheme.light()
                                                        .copyWith(
                                                            electronSize: 5,
                                                            particleShake: 0.4,
                                                            levelSize: 1)
                                                    : AtomTheme.dark().copyWith(
                                                        electronSize: 5,
                                                        particleShake: 0.4,
                                                        levelSize: 1)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment:
                                        Alignment.topCenter + Alignment(0, 0.1),
                                    child: Text('25'),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text('Manganês\n54.938049'),
                                  )
                                ],
                              ),
                            )),
                      ),
                      elevation: 4.0,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0)),
                    ),
            ),
            Material(
              borderRadius: BorderRadius.zero,
              elevation: 4.0,
              type: MaterialType.card,
              child: InkWell(
                onTap: () => setState(() => isHidden = !isHidden),
                child: SizedBox(
                  width: manganeseSize.width,
                  height: manganeseSize.height,
                  child: Center(
                    child: Text(
                      'Mn',
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontSize: manganeseSize.width / 2),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            Stack(children: <Widget>[
              Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                      Theme.of(context).brightness == Brightness.light
                          ? 'assets/periodic_table.png'
                          : 'assets/periodic_table_dark.png')),
              _buildPositioned(context, constraints),
              _buildPositionedText(context, constraints),
            ]));
  }
}
