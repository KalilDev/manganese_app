import 'package:manganese_app/model/atom.dart';

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
    }, name: 'Silício-Manganês', assetUrl: 'assets/alloy/simn.jpg', text: '');
  }
  factory Alloy.elemental() {
    return Alloy({1.0: Atom.manganese()},
        name: 'Manganês puro', assetUrl: 'assets/alloy/mn.jpg', text: '');
  }
  factory Alloy.femn() {
    return Alloy({
      1: Atom.iron(),
      0.2: Atom.manganese(),
    }, name: 'Ferro-Manganês', assetUrl: 'assets/alloy/femn.png', text: '');
  }
  factory Alloy.stmn() {
    return Alloy({
      1: Atom.iron(),
      0.15: Atom.manganese(),
      0.165: Atom.carbon(),
    }, name: 'Aço Hadfield', assetUrl: 'assets/alloy/stmn.png', text: '');
  }
  factory Alloy.almn() {
    return Alloy({0.015: Atom.manganese(), 1: Atom.aluminum()},
        name: 'Alumínio-Manganês', assetUrl: 'assets/alloy/almn.png', text: '');
  }
}

final List<Alloy> alloys = [
  Alloy.elemental(),
  Alloy.stmn(),
  Alloy.simn(),
  Alloy.femn(),
  Alloy.almn()
];
const String lipsum =
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse commodo quis nulla eu euismod. Donec finibus, ante pellentesque pharetra imperdiet, lacus nisl mattis augue, ac convallis sem arcu non risus. Praesent id semper magna. Proin mollis bibendum lacus, vel vulputate tortor congue ut. Nulla eu purus consequat, accumsan lectus at, mollis justo. Pellentesque at sapien nec sem suscipit feugiat a in purus. In sed arcu varius, feugiat diam id, ornare quam. Fusce tincidunt porttitor est, vitae rhoncus odio hendrerit ut.\nDonec semper viverra elementum. In dapibus elementum ligula, vel interdum nunc accumsan a. Phasellus at imperdiet leo. Integer sed dictum est. Aliquam ac lorem a ipsum porta sagittis. Pellentesque maximus egestas quam, sed pretium augue eleifend id. Vestibulum in ligula turpis. Fusce rhoncus sed metus ac aliquet.\nNunc feugiat elit a neque tristique, a lacinia magna cursus. Nulla dapibus neque diam, quis finibus sem convallis quis. Nam dapibus tellus ut magna bibendum, vel feugiat purus tincidunt. Nam quam mauris, tempus at velit ullamcorper, ultricies ullamcorper ex. Vestibulum id turpis sed lectus faucibus vulputate. Praesent sed consequat massa. Donec sagittis urna sit amet sem lobortis consectetur. Curabitur a accumsan nisi, vulputate bibendum mi. Duis tristique erat ut augue porta, vel vehicula lacus sagittis.\nDuis congue nec purus a ullamcorper. Morbi tincidunt non orci non vehicula. Vestibulum et est ac ipsum luctus pulvinar. Phasellus sodales justo mollis pretium molestie. Proin imperdiet gravida sem, sit amet varius mauris consectetur a. Cras ac nulla velit. Aenean tincidunt felis eget purus venenatis dictum.\nIn fringilla nisl non dui vestibulum, sit amet posuere est dictum. Vestibulum ut dui non quam efficitur sodales. In a sagittis eros. Praesent maximus arcu metus, id consequat nisl tincidunt vitae. Aenean condimentum viverra augue eget scelerisque. Pellentesque elit nibh, eleifend vel lobortis at, suscipit ac massa. Praesent quis neque feugiat sapien porta efficitur. Vivamus posuere justo et consectetur vulputate. In pellentesque vehicula venenatis. Nullam eget lacus urna.';
