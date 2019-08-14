import 'package:flutter/material.dart';
import 'package:manganese_app/ui/atom_painter.dart';

import '../text.dart';

class InfoPages extends StatefulWidget {
  InfoPages(this.initialPage);
  final int initialPage;

  @override
  _InfoPagesState createState() => _InfoPagesState();
}

class _InfoPagesState extends State<InfoPages> {
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialPage);
    super.initState();
  }

  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget buildContent(int i) {
    return Container(child: Text(texts[i]));
  }

  Widget buildFooter(int i) {
    Widget widget;
    switch (i) {
      case 0:
        widget = Row(
          children: <Widget>[
            Spacer(),
            Flexible(
              child: AspectRatio(
                aspectRatio: 1,
                child: CustomPaint(
                  painter: AtomPainter.manganese(0.0),
                ),
              ),
            ),
            Spacer()
          ],
        );
        break;
      case 1:
        widget = SizedBox();
        break;
      case 2:
        widget = SizedBox();
        break;
      case 3:
        widget = SizedBox();
        break;
    }
    return widget;
  }

  Widget itemBuilder(BuildContext context, int i) {
    Widget buildSection(BuildContext context, int a) {
      switch (a) {
        case 0:
          return buildContent(i);
          break;
        case 1:
          return buildFooter(i);
          break;
      }
    }

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          centerTitle: true,
          title: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Text(titles[i])),
          flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
            imgPaths[i],
            fit: BoxFit.cover,
          )),
          expandedHeight: 300,
          pinned: false,
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(buildSection, childCount: 2))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
      itemCount: titles.length,
      itemBuilder: itemBuilder,
      controller: _pageController,
    ));
  }
}
