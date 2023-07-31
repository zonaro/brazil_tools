import 'package:flutter/material.dart';

import 'brazil_tools.dart';

class EstadoAutocomplete extends Autocomplete<Estado> {
  EstadoAutocomplete({
    super.key,
    super.displayStringForOption = RawAutocomplete.defaultStringForOption,
    super.onSelected,
    super.optionsMaxHeight = 200.0,
    super.optionsViewBuilder,
    super.initialValue,
    super.fieldViewBuilder,
  }) : super(optionsBuilder: (TextEditingValue v) => Brasil.estados.where((element) => element.uf.toLowerCase() == v.text.toLowerCase() || element.nome.toLowerCase().contains(v.text.toLowerCase())).toList());
}

class CidadeAutocomplete extends Autocomplete<Cidade> {
  CidadeAutocomplete({
    super.key,
    super.displayStringForOption = RawAutocomplete.defaultStringForOption,
    super.onSelected,
    super.optionsMaxHeight = 200.0,
 
    super.initialValue,
    super.fieldViewBuilder,
    String nomeEstadoOuUfOuIBGE = "",
  }) : super(
        optionsViewBuilder: (e) {
          
        },
    optionsBuilder: (TextEditingValue v) => Brasil.pesquisarCidade(v.text, nomeEstadoOuUfOuIBGE));
}
