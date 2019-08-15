import 'package:latlong/latlong.dart';

const int kTonsPerYearWorldWide = 18000000;

class Country {
  const Country({this.name, this.tonsPerYear, this.latLng, this.flagUrl});
  final String name;
  final String flagUrl;
  final int tonsPerYear;
  final LatLng latLng;
  double get productionPercentage =>
      ((tonsPerYear / kTonsPerYearWorldWide) * 10000).round() / 100;
}

final List<Country> countries = [
  Country(
      name: 'Africa do Sul',
      flagUrl: 'assets/country_flags/za.png',
      tonsPerYear: 6200000,
      latLng: LatLng(-34.6283864, 27.2516952)),
  Country(
      name: 'China',
      flagUrl: 'assets/country_flags/cn.png',
      tonsPerYear: 3000000,
      latLng: LatLng(35.780287, 104.1374349)),
  Country(
      name: 'Australia',
      flagUrl: 'assets/country_flags/au.png',
      tonsPerYear: 2900000,
      latLng: LatLng(-26.1772288, 133.4170119)),
  Country(
      name: 'Gabão',
      flagUrl: 'assets/country_flags/ga.png',
      tonsPerYear: 1800000,
      latLng: LatLng(-0.9237455, 11.4739617)),
  Country(
      name: 'Brasil',
      flagUrl: 'assets/country_flags/br.png',
      tonsPerYear: 1000000,
      latLng: LatLng(-14.4086569, -51.31668)),
  Country(
      name: 'Índia',
      flagUrl: 'assets/country_flags/in.png',
      tonsPerYear: 950000,
      latLng: LatLng(20.9880134, 82.7525294)),
  Country(
      name: 'Malasia',
      flagUrl: 'assets/country_flags/my.png',
      tonsPerYear: 400000,
      latLng: LatLng(4.140634, 109.6181485)),
  Country(
      name: 'Ucrania',
      flagUrl: 'assets/country_flags/ua.png',
      tonsPerYear: 390000,
      latLng: LatLng(48.3358856, 31.1788196)),
  Country(
      name: 'Cazaquistão',
      flagUrl: 'assets/country_flags/kz.png',
      tonsPerYear: 390000,
      latLng: LatLng(48.005284, 66.9045435)),
  Country(
      name: 'Gana',
      flagUrl: 'assets/country_flags/gh.png',
      tonsPerYear: 390000,
      latLng: LatLng(7.9044654, -1.0304069)),
];
