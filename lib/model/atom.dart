class Atom {
  Atom(
      {this.electronsPerLevel,
      this.protons,
      this.neutrons,
      this.name,
      this.symbol});
  final Map<int, int> electronsPerLevel;
  final int protons;
  final int neutrons;
  final String name;
  final String symbol;
  factory Atom.manganese() => Atom(
      electronsPerLevel: {4: 2, 3: 13, 2: 8, 1: 2},
      protons: 25,
      neutrons: 30,
      name: 'Manganês',
      symbol: 'Mn');
  factory Atom.silicon() => Atom(
      electronsPerLevel: {3: 4, 2: 8, 1: 2},
      protons: 14,
      neutrons: 14,
      name: 'Silicio',
      symbol: 'Si');

  factory Atom.iron() => Atom(
      electronsPerLevel: {4: 2, 3: 14, 2: 8, 1: 2},
      protons: 26,
      neutrons: 29,
      name: 'Ferro',
      symbol: 'Fe');

  factory Atom.carbon() => Atom(
      electronsPerLevel: {2: 4, 1: 2},
      protons: 6,
      neutrons: 6,
      name: 'Carbono',
      symbol: 'C');

  factory Atom.aluminum() => Atom(
      electronsPerLevel: {3: 3, 2: 8, 1: 2},
      protons: 13,
      neutrons: 13,
      name: 'Aluminio',
      symbol: 'Al');
}
