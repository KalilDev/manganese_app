import 'package:manganese_app/model/atom.dart';
import 'package:manganese_app/text.dart';

class Alloy {
  Alloy(this.probabilityAtomMap, {this.name, this.assetUrl, this.text});
  final Map<double, Atom> probabilityAtomMap;
  final String name;
  final String assetUrl;
  final String text;

  factory Alloy.simn() {
    return Alloy({
      1: Atom.silicon(),
      0.3: Atom.manganese(),
    }, name: 'Silício-Manganês', assetUrl: 'assets/alloy/simn.jpg', text: simn);
  }
  factory Alloy.elemental() {
    return Alloy({1.0: Atom.manganese()},
        name: 'Manganês puro', assetUrl: 'assets/alloy/mn.jpg', text: mn);
  }
  factory Alloy.femn() {
    return Alloy({
      1: Atom.iron(),
      0.2: Atom.manganese(),
    }, name: 'Ferro-Manganês', assetUrl: 'assets/alloy/femn.png', text: femn);
  }
  factory Alloy.stmn() {
    return Alloy({
      1: Atom.iron(),
      0.15: Atom.manganese(),
      0.165: Atom.carbon(),
    }, name: 'Aço Hadfield', assetUrl: 'assets/alloy/stmn.png', text: stmn);
  }
  factory Alloy.almn() {
    return Alloy({0.015: Atom.manganese(), 1: Atom.aluminum()},
        name: 'Alumínio-Manganês',
        assetUrl: 'assets/alloy/almn.png',
        text: almn);
  }
}

final List<Alloy> alloys = [
  Alloy.elemental(),
  Alloy.stmn(),
  Alloy.simn(),
  Alloy.femn(),
  Alloy.almn()
];
