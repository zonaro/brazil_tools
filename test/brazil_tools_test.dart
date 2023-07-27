import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:brazil_tools/brazil_tools.dart';

void main() {
  test('Nome aleatorio', () {
    var x = Brasil.gerarNomeAleatorio();
    debugPrint(x);     
  });
}
