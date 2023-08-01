library brazil_tools;

import 'dart:math';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

abstract interface class Brasil {
  static late List<dynamic> _data;

  /// Lista contendo os nomes mais comuns no Brasil
  static List<String> get nomesComuns => [
        "Miguel",
        "Arthur",
        "Davi",
        "Gabriel",
        "Pedro",
        "Alice",
        "Sophia",
        "Sofia",
        "Manuela",
        "Isabella",
        "Laura",
        "Heitor",
        "Enzo",
        "Lorenzo",
        "Valentina",
        "Giovanna",
        "Giovana",
        "Maria Eduarda",
        "Beatriz",
        "Maria Clara",
        "Vinícius",
        "Rafael",
        "Lara",
        "Mariana",
        "Helena",
        "Mariana",
        "Isadora",
        "Lívia",
        "Luana",
        "Maria Luíza",
        "Luiza",
        "Ana Luiza",
        "Eduarda",
        "Letícia",
        "Lara",
        "Melissa",
        "Maria Fernanda",
        "Cecília",
        "Lorena",
        "Clara",
        "Gustavo",
        "Matheus",
        "João Pedro",
        "Breno",
        "Felipe",
        "Júlia",
        "Carolina",
        "Caroline",
        "Joaquim",
        "Enzo Gabriel",
        "Thiago",
        "Lucas",
        "Giovanni",
        "Bianca",
        "Sophie",
        "Antônio",
        "Benjamin",
        "Vitória",
        "Isabelly",
        "Amanda",
        "Emilly",
        "Maria Cecília",
        "Marina",
        "Analu",
        "Nina",
        "Júlia",
        "Gustavo Henrique",
        "Miguel",
        "Catarina",
        "Stella",
        "Miguel Henrique",
        "Guilherme",
        "Caio",
        "Maria Vitória",
        "Isis",
        "Heloísa",
        "Gabriela",
        "Eloá",
        "Agatha",
        "Arthur Miguel",
        "Luiza",
        "Pedro Henrique",
        "Ana Beatriz",
        "Ruan",
        "Sophia",
        "Lara",
        "Luana",
        "Bárbara",
        "Kaique",
        "Raissa",
        "Rafaela",
        "Maria Valentina",
        "Bernardo",
        "Mirella",
        "Leonardo",
        "Davi Lucas",
        "Luiz Felipe",
        "Emanuel",
        "Maria Alice",
        "Luana",
        "Luna",
        "Enrico"
      ];

  /// Lista contendo os sobrenomes mais comuns no Brasil
  static List<String> get sobrenomesComuns => [
        "Silva",
        "Santos",
        "Souza",
        "Oliveira",
        "Pereira",
        "Ferreira",
        "Alves",
        "Pinto",
        "Ribeiro",
        "Rodrigues",
        "Costa",
        "Carvalho",
        "Gomes",
        "Martins",
        "Araújo",
        "Melo",
        "Barbosa",
        "Cardoso",
        "Nascimento",
        "Lima",
        "Moura",
        "Cavalcanti",
        "Monteiro",
        "Moreira",
        "Nunes",
        "Sales",
        "Ramos",
        "Montenegro",
        "Siqueira",
        "Borges",
        "Teixeira",
        "Amaral",
        "Sampaio",
        "Correa",
        "Fernandes",
        "Batista",
        "Miranda",
        "Leal",
        "Xavier",
        "Marques",
        "Andrade",
        "Freitas",
        "Paiva",
        "Vieira",
        "Aguiar",
        "Macedo",
        "Garcia",
        "Lacerda",
        "Lopes"
      ];

  /// Gera um nome aleatório
  static String gerarNomeAleatorio({bool sobrenomeUnico = false}) {
    var random = Random();
    var s1 = sobrenomesComuns[random.nextInt(sobrenomesComuns.length)];
    var s2 = sobrenomesComuns[random.nextInt(sobrenomesComuns.length)];
    if (random.nextBool() || s1 == s2 || sobrenomeUnico) {
      s2 = "";
    }
    return "${nomesComuns[random.nextInt(nomesComuns.length)]} $s1 $s2".trim();
  }

  static Future<void> init() async {
    var jsonText = await rootBundle.loadString('packages/brazil_tools/assets/estados.json');
    _data = json.decode(jsonText) as List<dynamic>;
    for (var v in _data) {
      var e = Estado._fromJson(v as Map<String, dynamic>);
      _estados.add(e);
    }
  }

  static final List<Estado> _estados = [];
  static List<Estado> get estados => _estados.toList(growable: false);

  static List<Cidade> get cidades => _estados.expand((element) => element.cidades).toList();

  /// pega um estado a partir do nome, UF ou IBGE
  static Estado? pegarEstado(String nomeOuUFOuIBGE) {
    try {
      nomeOuUFOuIBGE = nomeOuUFOuIBGE.toLowerCase().trim();
      return _estados.firstWhere((e) => e.nome.toLowerCase() == nomeOuUFOuIBGE || e.uf.toLowerCase() == nomeOuUFOuIBGE || e.ibge.toString() == nomeOuUFOuIBGE.trim().substring(0, 2));
    } catch (e) {
      return null;
    }
  }

  /// pesquisa uma cidade no Brasil todo ou em algum estado especifico se [nomeOuUFOuIBGE] for especificado
  static List<Cidade> pesquisarCidade(String nomeCidadeOuIBGE, [String nomeOuUFOuIBGE = ""]) {
    try {
      nomeCidadeOuIBGE = nomeCidadeOuIBGE.toLowerCase().trim();
      Estado? e = pegarEstado(nomeCidadeOuIBGE);
      if (e == null && nomeOuUFOuIBGE.trim() != "") {
        e = pegarEstado(nomeOuUFOuIBGE);
      }
      return (e?.cidades ?? (cidades)).where((c) => c.nome.toLowerCase().contains(nomeCidadeOuIBGE) || c.ibge.toString().startsWith(nomeCidadeOuIBGE)).toList();
    } catch (e) {
      return [];
    }
  }

  /// Pega uma cidade a partir do nome, UF ou IBGE e estado
  static Cidade? pegarCidade(String nomeCidadeOuIBGE, [String nomeOuUFOuIBGE = ""]) => (pesquisarCidade(nomeCidadeOuIBGE, nomeOuUFOuIBGE)).singleOrNull;
}

class Estado {
  final String nome;
  final String uf;
  final int ibge;
  final String regiao;
  final double latitude;
  final double longitude;
  final List<Cidade> cidades = [];

  @override
  String toString() => nome;

  @override
  int get hashCode => Object.hash(ibge, 0);

  Estado._(this.nome, this.uf, this.ibge, this.regiao, this.latitude, this.longitude);

  factory Estado._fromJson(Map<String, dynamic> json) {
    var e = Estado._(json['Nome'], json['UF'], json['IBGE'], json['Regiao'], json['Latitude'], json['Longitude']);
    json['Cidades'].forEach((v) {
      e.cidades.add(Cidade._fromJson(v, e));
    });
    return e;
  }

  Map<String, dynamic> toJson() => {'Nome': nome, 'UF': uf, 'IBGE': ibge, 'Regiao': regiao, 'Latitude': latitude, 'Longitude': longitude, 'Cidades': cidades.map((v) => v.toJson()).toList()};

  @override
  bool operator ==(Object other) {
    if (other is Estado) {
      return ibge == other.ibge;
    }

    if (other is Cidade) {
      return ibge == other.estado.ibge;
    }
    return false;
  }
}

class Cidade {
  final String nome;
  final bool capital;
  final int ibge;
  final int siafi;
  final int ddd;
  final String timeZone;
  final Estado estado;

  @override
  String toString() => nome;

  Cidade._(this.nome, this.capital, this.ibge, this.siafi, this.ddd, this.timeZone, this.estado);

  factory Cidade._fromJson(Map<String, dynamic> json, Estado estado) => Cidade._(json['Nome'], json['Capital'], json['IBGE'], json['SIAFI'], json['DDD'], json['TimeZone'], estado);

  Map<String, dynamic> toJson() => {'Nome': nome, 'Capital': capital, 'IBGE': ibge, 'SIAFI': siafi, 'DDD': ddd, 'TimeZone': timeZone, "Estado": estado.uf};

  @override
  bool operator ==(Object other) {
    if (other is Cidade) {
      return ibge == other.ibge;
    }

    if (other is Estado) {
      return estado.ibge == other.ibge;
    }
    return false;
  }

  @override
  int get hashCode => Object.hash(ibge, 0);
}
