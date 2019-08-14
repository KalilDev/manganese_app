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
      flagUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Flag_of_South_Africa.svg/125px-Flag_of_South_Africa.svg.png',
      tonsPerYear: 6200000,
      latLng: LatLng(-34.6283864, 27.2516952)),
  Country(
      name: 'China',
      flagUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_the_People%27s_Republic_of_China.svg/125px-Flag_of_the_People%27s_Republic_of_China.svg.png',
      tonsPerYear: 3000000,
      latLng: LatLng(35.780287, 104.1374349)),
  Country(
      name: 'Australia',
      flagUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Flag_of_Australia_%28converted%29.svg/125px-Flag_of_Australia_%28converted%29.svg.png',
      tonsPerYear: 2900000,
      latLng: LatLng(-26.1772288, 133.4170119)),
  Country(
      name: 'Gabão',
      flagUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Flag_of_Gabon.svg/125px-Flag_of_Gabon.svg.png',
      tonsPerYear: 1800000,
      latLng: LatLng(-0.9237455, 11.4739617)),
  Country(
      name: 'Brasil',
      flagUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/0/05/Flag_of_Brazil.svg/125px-Flag_of_Brazil.svg.png',
      tonsPerYear: 1000000,
      latLng: LatLng(-14.4086569, -51.31668)),
  Country(
      name: 'Índia',
      flagUrl:
          'https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/125px-Flag_of_India.svg.png',
      tonsPerYear: 950000,
      latLng: LatLng(20.9880134, 82.7525294)),
  Country(
      name: 'Malasia',
      flagUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Flag_of_Malaysia.svg/125px-Flag_of_Malaysia.svg.png',
      tonsPerYear: 400000,
      latLng: LatLng(4.140634, 109.6181485)),
  Country(
      name: 'Ucrania',
      flagUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Flag_of_Ukraine.svg/125px-Flag_of_Ukraine.svg.png',
      tonsPerYear: 390000,
      latLng: LatLng(48.3358856, 31.1788196)),
  Country(
      name: 'Cazaquistão',
      flagUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Flag_of_Kazakhstan.svg/125px-Flag_of_Kazakhstan.svg.png',
      tonsPerYear: 390000,
      latLng: LatLng(48.005284, 66.9045435)),
  Country(
      name: 'Gana',
      flagUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag_of_Ghana.svg/125px-Flag_of_Ghana.svg.png',
      tonsPerYear: 390000,
      latLng: LatLng(7.9044654, -1.0304069)),
];
