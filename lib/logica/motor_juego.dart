
import '../modelos/carta.dart';
import 'baraja.dart';
import 'tabla.dart';
import 'verificador_patrones.dart';

class MotorJuego {
  final Baraja baraja;
  final Tabla tabla;

  bool haGanado = false;

  MotorJuego({
    required this.baraja,
    required this.tabla,
  });

  Carta? cantarYMarcar() {
    if (haGanado) return null;

    final carta = baraja.cantarSiguiente();

    if (carta == null) return null;

    tabla.marcar(carta);

    if (VerificadorPatrones.hayGanador(tabla.marcadas)) {
      haGanado = true;
    }

    return carta;
  }
}
