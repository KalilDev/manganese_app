import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:manganese_app/model/country.dart';
import 'package:manganese_app/text.dart';

final kBrasilBounds =
    LatLngBounds(LatLng(2.808795, -71.304378), LatLng(-32.000166, -36.1590227));

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  MapController controller;
  bool isOnBrasil = false;

  @override
  void initState() {
    controller = MapController();
    super.initState();
  }

  List<Marker> _buildMarkers() {
    return countries
        .map<Marker>((Country c) => _buildMarker(c))
        .toList()
        .reversed
        .toList();
  }

  _openCountry(Country c, BuildContext context) {
    if (c.name == 'Brasil' && !isOnBrasil) {
      controller.move(LatLng(-3.952825, -67.664360), 8);
      setState(() {
        isOnBrasil = true;
      });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Material(
                  borderRadius: BorderRadius.circular(30.0),
                  elevation: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(height: 100.0, child: Image.asset(c.flagUrl)),
                        SizedBox(height: 8.0),
                        Text(
                          c.name,
                          style: Theme.of(context).textTheme.title,
                        ),
                        SizedBox(height: 4.0),
                        Text(
                            'São produzidas nesse país ${c.tonsPerYear.toString()} toneladas de Manganês por ano, segundo dados de 2015. Isso equivale a ${c.productionPercentage}% da produção mundial. Isso faz de ${c.name} o ${countries.indexOf(c) + 1}° produtor mundial desse metal. Impressionante, ${c.name}!'),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    }
  }

  Marker _buildTextMarker(String text, LatLng pos) {
    return Marker(
        point: pos,
        height: 200,
        width: 300,
        builder: (BuildContext context) {
          return Center(
            child: Text(text),
          );
        });
  }

  Marker _buildPinpoint(String text, LatLng pos) {
    return Marker(
        anchorPos: AnchorPos.align(AnchorAlign.top),
        height: 200,
        width: 400,
        point: pos,
        builder: (BuildContext context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[Text(text), Icon(Icons.pin_drop)],
          );
        });
  }

  List<Marker> _buildTextMarkers() {
    return [
      //_buildPinpoint('Quem mora aqui mama', LatLng(-19.9075495, -43.9076999)),
      _buildPinpoint(portoDeSantana, LatLng(-0.037562, -51.1946795)),
      _buildPinpoint(fortunaLtda, LatLng(-14.4708409, -48.4829318)),
      _buildPinpoint(mariana, LatLng(-20.3770549, -43.4538469)),
      _buildTextMarker(
          genericMap0 + '\n' + genericMap1, LatLng(-3.952825, -67.664360)),
      _buildTextMarker(genericMap2, LatLng(-10.110603, -62.772693)),
      _buildTextMarker(genericMap3, LatLng(-16.452107, -60.752372)),
      _buildTextMarker(genericMap4, LatLng(-23.276005, -56.498772)),
      _buildTextMarker(genericMap5, LatLng(-27.201619, -52.223073)),
    ];
  }

  Marker _buildMarker(Country c) {
    return Marker(
        point: c.latLng,
        width: 138.0,
        height: 54.0,
        builder: (context) {
          return Material(
            color: c.name == 'Brasil' ? Theme.of(context).accentColor : null,
            elevation: 8.0,
            type: MaterialType.card,
            borderRadius: BorderRadius.circular(30.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(30.0),
              onTap: () => _openCountry(c, context),
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      c.name,
                      style: c.name == 'Brasil'
                          ? Theme.of(context).textTheme.title.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary)
                          : Theme.of(context).textTheme.title,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      c.productionPercentage.toString() + '% da produção',
                      style: c.name == 'Brasil'
                          ? DefaultTextStyle.of(context).style.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary)
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  _positionCallback(MapPosition pos, bool hasGesture, bool isUserGesture) {
    if (pos.center == null || pos.zoom == null || !mounted) return;
    if (!kBrasilBounds.contains(pos.center)) {
      if (isOnBrasil)
        setState(() {
          isOnBrasil = false;
        });
    } else {
      if (pos.zoom > 4.5)
        setState(() {
          isOnBrasil = true;
        });
      else if (isOnBrasil)
        setState(() {
          isOnBrasil = false;
        });
    }
  }

  _zoomIn() {
    controller.move(controller.center, controller.zoom + 0.2);
  }

  _zoomOut() {
    controller.move(controller.center, controller.zoom - 0.2);
  }

  _buildZoomButtons() {
    return Positioned(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: _zoomIn),
          IconButton(icon: Icon(Icons.remove), onPressed: _zoomOut),
        ],
      ),
      right: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Marker> markers = isOnBrasil
        ? _buildMarkers().followedBy(_buildTextMarkers()).toList()
        : _buildMarkers();

    const kDarkMapColor = Color(0xFF191a1a);
    const kLightMapColor = Color(0xFFcad2d3);

    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FlutterMap(
          options: MapOptions(
              onPositionChanged: _positionCallback,
              center: LatLng(-3.952825, -67.664360),
              zoom: 3.0,
              maxZoom: 7.0,
              minZoom: 3.0),
          mapController: controller,
          layers: [
            new TileLayerOptions(
              backgroundColor: Theme.of(context).brightness == Brightness.light
                  ? kLightMapColor
                  : kDarkMapColor,
              urlTemplate:
                  "https://api.tiles.mapbox.com/styles/v1/kalildev/{theme}/tiles/{z}/{x}/{y}@2x?access_token={token}",
              tileProvider: NetworkTileProvider(),
              additionalOptions: {
                'theme': Theme.of(context).brightness == Brightness.light
                    ? 'cjzcrm7022g0d1cp7jlxdrdks'
                    : 'cjzcrlx3i2fuq1co8kmp8vner',
                'token':
                    'pk.eyJ1Ijoia2FsaWxkZXYiLCJhIjoiY2p6YWM3bGRjMDB1cDNtbWppYm56Z3ljbSJ9.l1xToqUtWnzYODN-c37ZHg'
              },
            ),
            MarkerLayerOptions(
              markers: markers,
            ),
          ],
        ),
        _buildZoomButtons()
      ],
    ));
  }
}
