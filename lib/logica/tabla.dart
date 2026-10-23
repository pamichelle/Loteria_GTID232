
import '../modelos/carta.dart';

class Tabla {
  final List<List<Carta>> filas;
  final List<List<bool>> marcadas;

  Tabla._(this.filas, this.marcadas);

  Tabla.desdeFilas(List<List<Carta>> filas)
      : filas = filas.map((fila) => List<Carta>.from(fila)).toList(),
        marcadas = List.generate(
          4,
          (_) => List.generate(4, (_) => false),
        );

  static Tabla generar(List<Carta> cartas) {
    if (cartas.length != 16) {
      throw ArgumentError('La tabla necesita exactamente 16 cartas.');
    }

    final copia = List<Carta>.from(cartas)..shuffle();
    final filas = <List<Carta>>[];

    for (var f = 0; f < 4; f++) {
      filas.add(copia.sublist(f * 4, f * 4 + 4));
    }

    return Tabla.desdeFilas(filas);
  }

  void marcar(Carta carta) {
    for (var f = 0; f < filas.length; f++) {
      for (var c = 0; c < filas[f].length; c++) {
        if (filas[f][c] == carta) {
          marcadas[f][c] = true;
          return;
        }
      }
    }
  }
}
