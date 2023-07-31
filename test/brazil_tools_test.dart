import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:brazil_tools/brazil_tools.dart';

void main() {

    WidgetsFlutterBinding.ensureInitialized();


  test('Nome aleatorio', () {
    var x = Brasil.gerarNomeAleatorio();
    debugPrint(x);
    return true;
  });

  test("Trazer Estados", () async {
    var f = await Brasil.estados;
    for (var e in f) {
      for (var c in e.cidades) {
        debugPrint("${e.nome} - ${c.nome}");
      }
    }
  });

   test("Trazer Estados de novo", () async {
    var f = await Brasil.estados;
    for (var e in f) {
      for (var c in e.cidades) {
        debugPrint("${e.nome} - ${c.nome}");
      }
    }
  });
}
