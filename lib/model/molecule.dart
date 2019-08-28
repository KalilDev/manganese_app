class Molecule {
  Molecule({this.name, this.imgUrl, this.text, this.type});
  final String name;
  final List<String> imgUrl;
  final String text;
  final MoleculeType type;
}

enum MoleculeType { ore, other }

List<Molecule> molecules = [
  Molecule(
      name: 'Pirolusita',
      imgUrl: ['assets/molecules/0.png', 'assets/molecules/1.png'],
      text: '       A pirolusita é um mineral composto basicamente de dióxido de manganês (MnO2), sendo o mais importante mineral-minério de manganês, possuindo em sua composição 63% Mn, portanto ele é usado amplamente na indústria. Seus usos variam desde a produção de baterias, vidros, tinturas, solventes e produtos químicos no geral, mas a sua principal aplicação é na obtenção do metal manganês puro e na fabricação do aço, que é composto de 98,5% Fe e 1,5% Mn.' +
          '\n        A pirolusita é explorada no Brasil principalmente na Serra do Navio (AP) ( que foi paralisada em 1998 ); no Quadrilátero Ferrífero (MG), que é a área produtora mais antiga do Brasil, tendo seu foco em Conselheiro Lafaiete, responsável por 23% da produção nacional; no Morro do Urucum (MS); e na Serra dos Carajás (PA) que atualmente é a maior extratora do mineral e possui a segunda maior reserva do Brasil.',
      type: MoleculeType.ore),
  Molecule(
      name: 'Braunita',
      imgUrl: ['assets/molecules/3.png'],
      text:
          '\n       A braunita é um mineral silicato de manganês (isto é, basicamente, um membro de uma família de ânions composto de silício e oxigênio) de fórmula Mn²+Mn3+6[O8|SiO4]. Geralmente ele apresenta formações mais geométricas do que a da pirolusita, que tende a ter um formato mais de bolhas. Ele comumente está associado a impurezas como ferro, bário, titânio, alumínio, boro, cálcio e magnésio. Ele não é extraído no Brasil, embora seja muito utilizado para a fabricação de alguns compostos e solventes.',
      type: MoleculeType.ore),
  Molecule(
      name: 'Permanganato de potássio',
      imgUrl: [
        'assets/molecules/4.jpg',
        'assets/molecules/5.jpg',
      ],
      text: '\n       O permanganato de potássio (KMMnO4) é um sal inorgânico, formado pelos íons de potássio (K)+ e permanganato (MnO4)-. Ele é um agente oxidante extremamente forte, possuindo uma cor roxo forte tanto no seu estado sólido quanto diluído em uma solução aquosa, e mantém essa tonalidade numa proporção de 1,5g de permanganato de potássio para 1 litro d’água, assim assumindo uma cor vermelho forte. Ele é usado no tratamento de várias doenças, entre ela a catapora, já que ele ajuda a secar os ferimentos. Também é usado muita na indústria pelas suas capacidades oxidantes, o que também permite sua utilização em desinfetantes, e é usado no tratamento da água para torná-la potável, além como antídoto em casos de envenenamento por fósforo. Em soluções ácidas, ele se reduz ao cátion Mn+2; em neutras, se reduz para MnO2 na qual o manganês tem um estado de oxidação +4; e em soluções alcalinas, se reduz a um estado de oxidação +6, formando o manganato de potássio, K2MnO4.' +
          '\n       Quando misturado a glicerina (C3H8O3), ocorre uma reação de oxidação tão potente que sua temperatura de combustão chega a ser alta o suficiente para acender termita (+2000°C). Nessa reação, o permanganato de potássio é o oxidante e a glicerina é o agente redutor, o doador de elétrons.\n       14KMnO4 + 3C3H5(OH)3 → 7K2CO3 + 14MnO2 + 12H2O + 2CO2 ' +
          '\n       Quando misturado com ácido sulfúrico concentrado, é obtido uma substância altamente reativa e perigosa, o Óxido de Manganês VII (heptóxido de manganês).\n        2 KMnO4 + H2SO4 → K2SO4 + Mn2O7 + H2O',
      type: MoleculeType.other),
  Molecule(
      name: 'Heptóxido de Manganês',
      imgUrl: [],
      text:
          'O heptóxido de manganês é uma substância verde e inodora, mas que reage violentamente com qualquer combustível que ela toca, gerando uma combustão espontânea. Por exemplo, em uma reação com álcool, ele se incendeia violentamente e incinera o material no momento de seu contato, reduzindo-se assim ao dióxido de manganês, subproduto da maior parte das reações que os compostos instáveis de manganês podem gerar.\n        2 Mn2O7 + CH3CH2OH → 4 MnO2 + 2 CO2 + 3 H2O',
      type: MoleculeType.other),
  Molecule(
      name: 'Dióxido de Manganês',
      imgUrl: [],
      text: 'Por si só, o dióxido de manganês é um ótimo catalisador (substâncias que reduzem a energia de ativação para a ocorrência de uma reação), por exemplo, normalmente o peróxido de manganês se decompõe muito devagar, de uma maneira quase imperceptível. Quando se adiciona o dióxido de manganês na equação, uma decomposição extremamente rápida se inicia, com toda a energia se dispersando em forma de calor, com o peróxido de hidrogênio se decompondo em oxigênio e água e o dióxido de manganês se mantendo igual.\n        2 H2O2(aq) + MnO2(s) → O2(g) + 2H2O(l)\n' +
          '\n       Essa propriedade do dióxido de manganês é usada na síntese orgânica como uma maneira de oxidação mais efetiva de compostos orgânicos. Ele também é usado na produção de pilhas e baterias, atuando como oxidante, ou o cátodo.' +
          '\n       O dióxido de manganês, combinado com as proporções certas de alumínio (Al2), e utilizando fluoreto de cálcio (CaF2) e hexafluoraluminato de sódio (Na3AlF6) como combustíveis de partida para sustentar a reação, é possível fundir manganês puro facilmente, já que a seguinte é uma reação clássica de termita (a reação entre um metal reativo, com o óxido de um menos reativo), sendo o agente oxidante neste caso o dióxido de manganês, e a reação se dá na seguinte maneira:\n        MnO2 + 2Al → Mn2 + Al2O2',
      type: MoleculeType.other),
];
