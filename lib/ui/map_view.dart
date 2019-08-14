import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:manganese_app/model/country.dart';

class MapView extends StatelessWidget {
  List<Marker> _buildMarkers() {
    return countries
        .map<Marker>((Country c) => _buildMarker(c))
        .toList()
        .reversed
        .toList();
  }

  _openCountry(Country c, BuildContext context) {
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
                      SizedBox(height: 100.0, child: Image.network(c.flagUrl)),
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

  Marker _buildMarker(Country c) {
    return Marker(
        point: c.latLng,
        width: 138.0,
        height: 54.0,
        builder: (context) {
          return Material(
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
                      style: Theme.of(context).textTheme.title,
                    ),
                    SizedBox(height: 4.0),
                    Text(c.productionPercentage.toString() + '% da produção'),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterMap(
      options: MapOptions(
          center: LatLng(0, 0), zoom: 3.0, maxZoom: 3.0, minZoom: 3.0),
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
        new MarkerLayerOptions(
          markers: _buildMarkers(),
        ),
      ],
    ));
  }
}
