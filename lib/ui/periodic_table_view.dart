import 'package:flutter/material.dart';

import 'atom_painter.dart';

class PeriodicTableView extends StatefulWidget {
  @override
  _PeriodicTableViewState createState() => _PeriodicTableViewState();
}

class _PeriodicTableViewState extends State<PeriodicTableView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

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
    const int kWidth = 1496;
    const int kHeight = 1100;
    const int kMStartHeight = 469;
    const int kMStartWidth = 504;
    const int kMEndHeight = 543;
    const int kMEndWidth = 577;
    final Size size = constraints.biggest;
    final double pixelSize = size.width / kWidth;
    final Size manganeseSize = Size(pixelSize * (kMEndWidth - kMStartWidth),
        pixelSize * (kMEndHeight - kMStartHeight));
    final Offset imgBeginOffset =
        Offset(0, (size.height - (kHeight * pixelSize)) / 2);
    final Offset manganeseBeginOffset = imgBeginOffset +
        Offset(kMStartWidth * pixelSize, kMStartHeight * pixelSize);
    return Positioned(
        bottom: size.height - manganeseBeginOffset.dy - manganeseSize.height,
        left: manganeseBeginOffset.dx,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Material(
              child: SizedBox(
                  height: size.width / 4 + 40.0,
                  width: size.width / 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        AspectRatio(
                          aspectRatio: 1.0,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (_, __) => CustomPaint(
                              painter: AtomPainter.manganese(_animation.value),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            '25',
                            style: DefaultTextStyle.of(context)
                                .style
                                .copyWith(shadows: [
                              BoxShadow(offset: Offset(1, 1), blurRadius: 2.0)
                            ]),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text('Manganês\n54.938049'),
                        )
                      ],
                    ),
                  )),
              elevation: 4.0,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0)),
            ),
            Material(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(2.0)),
              elevation: 4.0,
              child: SizedBox(
                width: manganeseSize.width,
                height: manganeseSize.height,
                child: Center(
                  child: Text('Mn'),
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
              Center(child: Image.asset('assets/periodic_table.png')),
              _buildPositioned(context, constraints),
            ]));
  }
}
