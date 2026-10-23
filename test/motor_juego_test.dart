
import 'package:flutter_test/flutter_test.dart';
import 'package:loteria/logica/baraja.dart';
import 'package:loteria/logica/tabla.dart';
import 'package:loteria/logica/motor_juego.dart';

void main() {
  test('el motor detecta Loteria al completar una fila', () {
    final cartas = Baraja.crearBarajaCompleta().cartasRestantes;
    final baraja = Baraja.desdeCartas(cartas);

    final tabla = Tabla.desdeFilas([
      cartas.sublist(0, 4),
      cartas.sublist(4, 8),
      cartas.sublist(8, 12),
      cartas.sublist(12, 16),
    ]);

    final motor = MotorJuego(baraja: baraja, tabla: tabla);

    // Las últimas cuatro cartas forman la última fila.
    for (var i = 0; i < 4; i++) {
      motor.cantarYMarcar();
    }

    expect(motor.haGanado, true);
  });

  test('el motor no reporta Loteria antes de completar un patron', () {
    final cartas = Baraja.crearBarajaCompleta().cartasRestantes;
    final baraja = Baraja.desdeCartas(cartas);

    final tabla = Tabla.desdeFilas([
      cartas.sublist(0, 4),
      cartas.sublist(4, 8),
      cartas.sublist(8, 12),
      cartas.sublist(12, 16),
    ]);

    final motor = MotorJuego(baraja: baraja, tabla: tabla);

    motor.cantarYMarcar();
    motor.cantarYMarcar();

    expect(motor.haGanado, false);
  });
}
