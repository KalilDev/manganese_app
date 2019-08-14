import 'dart:math';

import 'package:flutter/material.dart';
import 'package:manganese_app/ui/alloys_info_view.dart';
import 'package:manganese_app/ui/atom_painter.dart';

import '../text.dart';

class ManganeseSea extends StatefulWidget {
  @override
  State<ManganeseSea> createState() => _ManganeseSeaState();
}

class _ManganeseSeaState extends State<ManganeseSea>
    with TickerProviderStateMixin {
  Animation<double> _manganeseAnimation;
  AnimationController _animationController;
  ScrollController scrollController;
  static const int _kAtomsPerPart = 48;
  int currentPage = 0;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _manganeseAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animationController.repeat();
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  Widget buildElementalManganese() {
    return SliverGrid(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        delegate: SliverChildBuilderDelegate(
            (BuildContext context, int i) => AnimatedBuilder(
                animation: _manganeseAnimation,
                builder: (BuildContext context, _) {
                  return Hero(
                      tag: 'manganese' + i.toString(),
                      child: Material(
                        child: CustomPaint(
                            painter: AtomPainter.manganese(
                                _manganeseAnimation.value,
                                style: Theme.of(context).textTheme.body1)),
                      ));
                }),
            childCount: _kAtomsPerPart));
  }

  Widget buildSiliconManganese() {
    return SliverGrid(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        delegate: SliverChildBuilderDelegate((BuildContext context, int i) {
          final bool isManganese = Random().nextDouble() > 0.3;
          return AnimatedBuilder(
              animation: _manganeseAnimation,
              builder: (BuildContext context, _) {
                return CustomPaint(
                    painter: isManganese
                        ? AtomPainter.manganese(_manganeseAnimation.value,
                            style: Theme.of(context).textTheme.body1)
                        : AtomPainter.silicon(_manganeseAnimation.value,
                            style: Theme.of(context).textTheme.body1));
              });
        }, childCount: _kAtomsPerPart));
  }

  Widget buildManguiron() {
    return SliverGrid(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        delegate: SliverChildBuilderDelegate((BuildContext context, int i) {
          final bool isManganese = Random().nextDouble() > 0.2;
          return AnimatedBuilder(
              animation: _manganeseAnimation,
              builder: (BuildContext context, _) {
                return CustomPaint(
                    painter: isManganese
                        ? AtomPainter.manganese(_manganeseAnimation.value,
                            style: Theme.of(context).textTheme.body1)
                        : AtomPainter.iron(_manganeseAnimation.value,
                            style: Theme.of(context).textTheme.body1));
              });
        }, childCount: _kAtomsPerPart));
  }

  Widget buildAluminoganese() {
    return SliverGrid(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        delegate: SliverChildBuilderDelegate((BuildContext context, int i) {
          final bool isManganese = Random().nextDouble() > 0.985;
          return AnimatedBuilder(
              animation: _manganeseAnimation,
              builder: (BuildContext context, _) {
                return CustomPaint(
                    painter: isManganese
                        ? AtomPainter.manganese(_manganeseAnimation.value,
                            style: Theme.of(context).textTheme.body1)
                        : AtomPainter.aluminum(_manganeseAnimation.value,
                            style: Theme.of(context).textTheme.body1));
              });
        }, childCount: _kAtomsPerPart));
  }

  Widget buildAppBar() {
    return SliverAppBar(
      centerTitle: true,
      title: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Colors.indigo, borderRadius: BorderRadius.circular(20.0)),
          child: const Text(manganese)),
      flexibleSpace: FlexibleSpaceBar(
          background: Image.asset(
        manganeseImg,
        fit: BoxFit.cover,
      )),
      expandedHeight: 300,
      pinned: false,
    );
  }

  void addListener(BoxConstraints size) {
    final double sizeOf4 = size.maxWidth;
    final int rowsPerPart = (_kAtomsPerPart / 4).ceil();
    final double sizeOfPart = (sizeOf4 / 4) * rowsPerPart + 100;
    scrollController.addListener(() {
      final double current = scrollController.position.extentBefore +
          (scrollController.position.viewportDimension / 2) -
          300;
      int currentPage = (current / sizeOfPart).floor();
      if (currentPage != this.currentPage && currentPage > -1) {
        setState(() {
          this.currentPage = currentPage;
        });
      }
    });
  }

  Widget buildHeader(int i) {
    return SliverPersistentHeader(
        delegate: MetalHeaderDelegate(
      height: 100.0,
      child: Material(
        elevation: 8.0,
        color: Theme.of(context).accentColor,
        child: SizedBox(
          height: 100,
          child: Center(
            child: Text(
              titles[i],
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Theme.of(context).colorScheme.onSecondary),
            ),
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      if (!scrollController.hasListeners) addListener(constraints);

      return Scaffold(
          body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              buildAppBar(),
              buildHeader(0),
              buildElementalManganese(),
              buildHeader(1),
              buildSiliconManganese(),
              buildHeader(2),
              buildManguiron(),
              buildHeader(3),
              buildAluminoganese()
            ],
          ),
          Center(
            child: Material(
              borderRadius: BorderRadius.circular(20.0),
              clipBehavior: Clip.antiAlias,
              elevation: 8.0,
              child: InkWell(
                onTap: () => Navigator.of(context).push<void>(MaterialPageRoute(
                    builder: (BuildContext context) => InfoPages(currentPage))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(texts[currentPage].substring(0, 21) + '...'),
                ),
              ),
            ),
          )
        ],
      ));
    });
  }
}

class MetalHeaderDelegate extends SliverPersistentHeaderDelegate {
  MetalHeaderDelegate({
    @required this.height,
    @required this.child,
  });
  final double height;
  final Widget child;
  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(MetalHeaderDelegate oldDelegate) {
    return height != oldDelegate.height || child != oldDelegate.child;
  }
}
