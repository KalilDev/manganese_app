import 'dart:math';

import 'package:flutter/material.dart';
import 'package:manganese_app/model/alloy.dart';
import 'package:manganese_app/model/atom.dart';
import 'package:manganese_app/ui/atom_painter.dart';

class ManganeseSea extends StatefulWidget {
  @override
  State<ManganeseSea> createState() => _ManganeseSeaState();
}

class _ManganeseSeaState extends State<ManganeseSea>
    with TickerProviderStateMixin {
  int currentPage = 0;

  Widget _buildList(bool isTablet) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int i) {
          final Alloy alloy = alloys[i];
          handleTap() {
            if (isTablet) {
              setState(() => currentPage = i);
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => Scaffold(
                        body: SizedBox.expand(child: _AlloyView(alloy)),
                        appBar: AppBar(
                          title: Text('Manganês'),
                        ),
                      )));
            }
          }

          return ListTile(title: Text(alloy.name), onTap: handleTap);
        },
        itemCount: alloys.length);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (constraints.biggest.aspectRatio >= 1) {
        // TabletLayout
        return Row(children: <Widget>[
          Flexible(child: Material(elevation: 4.0, child: _buildList(true))),
          Expanded(
            child: _AlloyView(alloys[currentPage]),
            flex: 2,
          )
        ]);
      } else {
        // MobileLayout
        return _buildList(false);
      }
    });
  }
}

class _AlloyView extends StatefulWidget {
  _AlloyView(this.alloy);
  final Alloy alloy;
  @override
  __AlloyViewState createState() => __AlloyViewState();
}

class __AlloyViewState extends State<_AlloyView>
    with SingleTickerProviderStateMixin {
  Animation<double> _manganeseAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _manganeseAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildAtom(BuildContext context, int i) {
      final double random = Random().nextDouble();
      List<double> vals = widget.alloy.probabilityAtomMap.keys.toList();
      vals.sort();
      Atom atom;
      for (double val in vals.reversed) {
        if (random >= 1 - val) atom = widget.alloy.probabilityAtomMap[val];
      }
      final double random2 = Random().nextDouble();
      if (random2 <= 0.2) {
        /// Animate
        return AspectRatio(
          aspectRatio: 1,
          child: AnimatedBuilder(
            animation: _manganeseAnimation,
            builder: (_, __) => CustomPaint(
              painter: AtomPainter.fromAtom(_manganeseAnimation.value,
                  atom: atom,
                  style: DefaultTextStyle.of(context).style,
                  theme: Theme.of(context).brightness == Brightness.light
                      ? AtomTheme.light().copyWith(
                          electronSize: 5, particleShake: 0.4, levelSize: 1)
                      : AtomTheme.dark().copyWith(
                          electronSize: 5, particleShake: 0.4, levelSize: 1)),
            ),
          ),
        );
      } else {
        /// Do not animate
        return AspectRatio(
          aspectRatio: 1,
          child: CustomPaint(
            painter: AtomPainter.fromAtom(0.21 * i,
                atom: atom,
                style: DefaultTextStyle.of(context).style,
                theme: Theme.of(context).brightness == Brightness.light
                    ? AtomTheme.light().copyWith(
                        electronSize: 5, particleShake: 0.4, levelSize: 1)
                    : AtomTheme.dark().copyWith(
                        electronSize: 5, particleShake: 0.4, levelSize: 1)),
          ),
        );
      }
    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double aspectRatio =
          (constraints.maxWidth * 4 / 3) / constraints.maxHeight - 0.1;
      print(aspectRatio);
      final bool isTablet = aspectRatio >= 1;
      if (isTablet) {
        final double childSize = constraints.maxWidth / 4;
        final double kStep1 = 200;
        final double kStep2 = 160;
        final double kStep3 = 100;
        Widget atomWidget = GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: childSize > kStep1 ? 2 : 1),
            itemBuilder: buildAtom);
        return Stack(
          children: <Widget>[
            if (childSize > kStep3)
              Positioned(
                child: SizedBox(
                    height: constraints.maxHeight,
                    width: childSize,
                    child: atomWidget),
              ),
            Positioned(
              child: SizedBox(
                height: constraints.maxHeight,
                width: (childSize > kStep2 ? 2 : childSize > kStep3 ? 3 : 4) *
                    childSize,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      buildImage(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.alloy.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              left: childSize > 100 ? childSize : 0,
            ),
            if (childSize > kStep2)
              Positioned(
                child: SizedBox(
                    height: constraints.maxHeight,
                    width: childSize,
                    child: atomWidget),
                right: 0,
              ),
          ],
        );
      } else {
        return CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(child: buildImage()),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.alloy.text),
            )),
            SliverGrid(
                delegate: SliverChildBuilderDelegate(buildAtom),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4))
          ],
        );
      }
    });
  }

  Widget buildImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
          elevation: 4.0,
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(30.0),
          child: Image.asset(widget.alloy.assetUrl)),
    );
  }
}
