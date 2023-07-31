import 'package:flutter/material.dart';

import 'brazil_tools.dart';

class EstadoAutocomplete extends Autocomplete<Estado> {
  EstadoAutocomplete({super.key}) : super(optionsBuilder: (TextEditingValue v) => Brasil.estados.where((element) => element.uf.toLowerCase() == v.text.toLowerCase() || element.nome.toLowerCase().contains(v.text.toLowerCase())).toList());
}

class CidadeAutocomplete extends Autocomplete<Cidade> {
  CidadeAutocomplete({super.key, String nomeEstadoOuUfOuIBGE = ""}) : super(optionsBuilder: (TextEditingValue v) => Brasil.pesquisarCidade(v.text, nomeEstadoOuUfOuIBGE));
}
