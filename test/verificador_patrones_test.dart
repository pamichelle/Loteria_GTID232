
import 'package:flutter_test/flutter_test.dart';
import 'package:loteria/logica/verificador_patrones.dart';

void main() {
  test('detecta una linea horizontal completa', () {
    final marcadas = [
      [true, true, true, true],
      [false, false, false, false],
      [false, false, false, false],
      [false, false, false, false],
    ];

    expect(VerificadorPatrones.hayLinea(marcadas), true);
  });

  test('no detecta una fila incompleta', () {
    final marcadas = [
      [true, true, true, false],
      [false, false, false, false],
      [false, false, false, false],
      [false, false, false, false],
    ];

    expect(VerificadorPatrones.hayLinea(marcadas), false);
  });

  test('detecta una columna completa', () {
    final marcadas = [
      [true, false, false, false],
      [true, false, false, false],
      [true, false, false, false],
      [true, false, false, false],
    ];

    expect(VerificadorPatrones.hayColumna(marcadas), true);
  });

  test('no detecta una columna incompleta', () {
    final marcadas = [
      [true, false, false, false],
      [true, false, false, false],
      [false, false, false, false],
      [true, false, false, false],
    ];

    expect(VerificadorPatrones.hayColumna(marcadas), false);
  });

  test('detecta la diagonal principal', () {
    final marcadas = [
      [true, false, false, false],
      [false, true, false, false],
      [false, false, true, false],
      [false, false, false, true],
    ];

    expect(VerificadorPatrones.hayDiagonal(marcadas), true);
  });

  test('detecta la diagonal secundaria', () {
    final marcadas = [
      [false, false, false, true],
      [false, false, true, false],
      [false, true, false, false],
      [true, false, false, false],
    ];

    expect(VerificadorPatrones.hayDiagonal(marcadas), true);
  });

  test('detecta un ganador con cualquier patron completo', () {
    final marcadas = [
      [true, true, true, true],
      [false, false, false, false],
      [false, false, false, false],
      [false, false, false, false],
    ];

    expect(VerificadorPatrones.hayGanador(marcadas), true);
  });

  test('no detecta ganador si no hay patrones completos', () {
    final marcadas = [
      [true, false, false, false],
      [false, true, false, false],
      [false, false, true, false],
      [false, false, false, false],
    ];

    expect(VerificadorPatrones.hayGanador(marcadas), false);
  });
}
