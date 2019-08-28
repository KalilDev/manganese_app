import 'package:flutter/material.dart';
import 'package:manganese_app/model/molecule.dart';

class MoleculesView extends StatefulWidget {
  @override
  State<MoleculesView> createState() => _MoleculesViewState();
}

class _MoleculesViewState extends State<MoleculesView> {
  int currentPage = 0;

  Widget _buildList(bool isTablet) {
    return ListView.builder(
        itemBuilder: (BuildContext context, int i) {
          final Molecule molecule = molecules[i];
          handleTap() {
            if (isTablet) {
              setState(() => currentPage = i);
            } else {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => Scaffold(
                        body: SizedBox.expand(child: _AlloyView(molecule)),
                        appBar: AppBar(
                          title: Text('Manganês'),
                        ),
                      )));
            }
          }

          return ListTile(title: Text(molecule.name), onTap: handleTap);
        },
        itemCount: molecules.length);
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
            child: _AlloyView(molecules[currentPage]),
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

class _AlloyView extends StatelessWidget {
  _AlloyView(this.molecule);
  final Molecule molecule;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final double aspectRatio =
          (constraints.maxWidth * 4 / 3) / constraints.maxHeight - 0.1;
      print(aspectRatio);
      final bool isTablet = aspectRatio >= 1;
      if (isTablet) {
        final double childSize = constraints.maxWidth / 4;
        final double kStep2 = 160;
        final double kStep3 = 100;
        return Stack(
          children: <Widget>[
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
                          molecule.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              left: childSize > 100 ? childSize : 0,
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
              child: Text(molecule.text),
            ))
          ],
        );
      }
    });
  }

  Widget buildImage() {
    Widget _image(String asset) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
            elevation: 4.0,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(30.0),
            child: Image.asset(asset)));
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: molecule.imgUrl.map<Widget>((String s) => _image(s)).toList(),
    );
  }
}
