library brazil_tools;

import 'dart:math';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

mixin Brasil {



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

  static final List<Estado> _estados = [];
  static Future<List<Estado>> get estados async {
    if (_estados.isEmpty) {
      var jsonText = await rootBundle.loadString('assets/estados.json');
      var data = json.decode(jsonText) as List<dynamic>;
      for (var v in data) {
        _estados.add(Estado.fromJson(v as Map<String, dynamic>));
      }
    }
    return _estados.toList(growable: false);
  }
}

class Estado {
  final String nome;
  final String uf;
  final int ibge;
  final String regiao;
  final double latitude;
  final double longitude;
  final List<Cidade> cidades = [];

  Estado(this.nome, this.uf, this.ibge, this.regiao, this.latitude, this.longitude);

  factory Estado.fromJson(Map<String, dynamic> json) {
    var e = Estado(
      json['Nome'],
      json['UF'],
      json['IBGE'],
      json['Regiao'],
      json['Latitude'],
      json['Longitude'],
    );
    json['Cidades'].forEach((v) {
      e.cidades.add(Cidade.fromJson(v));
    });
    return e;
  }

  Map<String, dynamic> toJson() => {'Nome': nome, 'UF': uf, 'IBGE': ibge, 'Regiao': regiao, 'Latitude': latitude, 'Longitude': longitude, 'Cidades': cidades.map((v) => v.toJson()).toList()};
}

class Cidade {
  final String nome;
  final bool capital;
  final int ibge;
  final int siafi;
  final int ddd;
  final String timeZone;

  Cidade(this.nome, this.capital, this.ibge, this.siafi, this.ddd, this.timeZone);

  factory Cidade.fromJson(Map<String, dynamic> json) => Cidade(json['Nome'], json['Capital'], json['IBGE'], json['SIAFI'], json['DDD'], json['TimeZone']);

  Map<String, dynamic> toJson() => {'Nome': nome, 'Capital': capital, 'IBGE': ibge, 'SIAFI': siafi, 'DDD': ddd, 'TimeZone': timeZone};
}
