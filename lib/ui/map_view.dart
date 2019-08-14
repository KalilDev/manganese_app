import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:manganese_app/model/country.dart';

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
    if (c.name == 'Brasil') {
      if (isOnBrasil) {
        controller.move(c.latLng, 3);
        setState(() {
          isOnBrasil = false;
        });
      } else {
        controller.move(LatLng(-16.7959248, -44.6854487), 8);
        setState(() {
          isOnBrasil = true;
        });
      }
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
                        SizedBox(
                            height: 100.0, child: Image.network(c.flagUrl)),
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
        width: 200,
        builder: (BuildContext context) {
          return Center(
            child: Text(
              text,
              style: DefaultTextStyle.of(context)
                  .style
                  .copyWith(color: Colors.black, shadows: [
                BoxShadow(
                    color: Colors.white,
                    blurRadius: 4.0,
                    spreadRadius: 5,
                    offset: Offset(0, 0)),
                BoxShadow(
                    color: Colors.white,
                    blurRadius: 4.0,
                    spreadRadius: 5,
                    offset: Offset(-1, -1)),
                BoxShadow(
                    color: Colors.white,
                    blurRadius: 4.0,
                    spreadRadius: 5,
                    offset: Offset(1, 1))
              ]),
            ),
          );
        });
  }

  List<Marker> _buildTextMarkers() {
    return [
      _buildTextMarker(
          'Mineiração é muito ruim. Não faça da Africa o ancapistão.',
          LatLng(-17.3405181, -44.9550076))
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
    if (pos.zoom < 4 && isOnBrasil) {
      setState(() {
        isOnBrasil = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Marker> markers = isOnBrasil
        ? _buildMarkers().followedBy(_buildTextMarkers()).toList()
        : _buildMarkers();

    return Scaffold(
        body: FlutterMap(
      options: MapOptions(
          onPositionChanged: _positionCallback,
          center: LatLng(0, 0),
          zoom: 3.0,
          maxZoom: 6.0,
          minZoom: 3.0),
      mapController: controller,
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken':
                'pk.eyJ1Ijoia2FsaWxkZXYiLCJhIjoiY2p6YWM3bGRjMDB1cDNtbWppYm56Z3ljbSJ9.l1xToqUtWnzYODN-c37ZHg',
            'id': 'mapbox.streets',
          },
        ),
        MarkerLayerOptions(
          markers: markers,
        ),
      ],
    ));
  }
}
