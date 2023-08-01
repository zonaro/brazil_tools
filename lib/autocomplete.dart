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
  }) : super(optionsBuilder: (TextEditingValue v) => Estado.pesquisarEstado(v.text));
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
  }) : super(optionsBuilder: (TextEditingValue v) => Cidade.pesquisarCidade(v.text, nomeEstadoOuUfOuIBGE));
}
