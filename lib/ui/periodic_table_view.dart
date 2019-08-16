import 'dart:math';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'atom_painter.dart';

const Color kLightImgBG = Color(0xFFffffff);
const Color kDarkImgBG = Color(0xFF3f3f3c);

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

  Widget _buildPositioned(BuildContext context, BoxConstraints constraints) {
    /// Constants
    const int kWidth = 1496;
    const int kHeight = 1100;
    const int kMStartHeight = 469;
    const int kMStartWidth = 504;
    const int kMEndHeight = 543;
    const int kMEndWidth = 577;
    final Size size = constraints.biggest;

    /// Dependent on rotation
    final bool isPortrait = kWidth / kHeight <= size.aspectRatio;
    double pixelSize;
    Offset imgBeginOffset;
    if (isPortrait) {
      pixelSize = size.height / kHeight;
      imgBeginOffset = Offset((size.width - (kWidth * pixelSize)) / 2, 0);
    } else {
      pixelSize = size.width / kWidth;
      imgBeginOffset = Offset(0, (size.height - (kHeight * pixelSize)) / 2);
    }
    final Size manganeseSize = Size(pixelSize * (kMEndWidth - kMStartWidth),
        pixelSize * (kMEndHeight - kMStartHeight));
    final Offset manganeseBeginOffset = imgBeginOffset +
        Offset(kMStartWidth * pixelSize, kMStartHeight * pixelSize);
    final double maxHeight =
        min(manganeseBeginOffset.dy, size.width / 4 + 40.0);
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
                  width: maxHeight - 40,
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
                                  AspectRatio(
                                    aspectRatio: 1.0,
                                    child: AnimatedBuilder(
                                      animation: _animation,
                                      builder: (_, __) => CustomPaint(
                                        painter: AtomPainter.manganese(
                                            _animation.value,
                                            theme: Theme.of(context)
                                                        .brightness ==
                                                    Brightness.light
                                                ? AtomTheme.light().copyWith(
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
                    child: Text('Mn'),
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
            PhotoView.customChild(
              childSize: constraints.biggest,
              backgroundDecoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? kLightImgBG
                      : kDarkImgBG),
              child: Stack(children: <Widget>[
                Center(
                    child: Image.asset(
                        Theme.of(context).brightness == Brightness.light
                            ? 'assets/periodic_table.png'
                            : 'assets/periodic_table_dark.png')),
                _buildPositioned(context, constraints),
              ]),
            ));
  }
}
