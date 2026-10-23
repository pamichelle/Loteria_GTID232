
import 'package:flutter/material.dart';

import 'logica/baraja.dart';
import 'logica/tabla.dart';
import 'logica/motor_juego.dart';

void main() {
  runApp(const LoteriaApp());
}

class LoteriaApp extends StatelessWidget {
  const LoteriaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lotería Doloreña',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
        ),
        useMaterial3: true,
      ),
      home: const JuegoScreen(),
    );
  }
}

class JuegoScreen extends StatefulWidget {
  const JuegoScreen({super.key});

  @override
  State<JuegoScreen> createState() => _JuegoScreenState();
}

class _JuegoScreenState extends State<JuegoScreen> {
  late MotorJuego _motor;
  late Tabla _tabla;

  String _ultimaCarta = '¡Toca cantar para comenzar!';
  int _cartasCantadas = 0;

  @override
  void initState() {
    super.initState();
    _reiniciar();
  }

  void _reiniciar() {
    final baraja = Baraja.crearBarajaCompleta()..mezclar();

    _tabla = Tabla.generar(
      Baraja.crearBarajaCompleta().cartasRestantes,
    );

    _motor = MotorJuego(
      baraja: baraja,
      tabla: _tabla,
    );

    _ultimaCarta = '¡Toca cantar para comenzar!';
    _cartasCantadas = 0;
  }

  void _cantar() {
    if (_motor.haGanado) return;

    final carta = _motor.cantarYMarcar();

    setState(() {
      if (carta != null) {
        _ultimaCarta = carta.nombre;
        _cartasCantadas++;
      } else {
        _ultimaCarta = '¡Ya no quedan cartas!';
      }
    });

    if (_motor.haGanado) {
      _mostrarVictoria();
    }
  }

  void _mostrarVictoria() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('¡Lotería! 🎉'),
          content: const Text(
            '¡Felicidades! Completaste una fila, '
            'columna o diagonal.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                setState(() {
                  _reiniciar();
                });
              },
              child: const Text('Jugar de nuevo'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lotería Doloreña'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text(
              '¡Viva la Independencia!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Card(
                color: Colors.orange.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Última carta cantada',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _ultimaCarta,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Cartas cantadas: $_cartasCantadas de 16',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: GridView.builder(
                  itemCount: 16,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 0.78,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemBuilder: (context, i) {
                    final fila = i ~/ 4;
                    final columna = i % 4;

                    final carta = _tabla.filas[fila][columna];
                    final marcada =
                        _tabla.marcadas[fila][columna];

                    return Container(
                      decoration: BoxDecoration(
                        color: marcada
                            ? Colors.deepOrange
                            : Colors.orange.shade50,
                        border: Border.all(
                          color: Colors.deepOrange,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            marcada
                                ? Icons.check_circle
                                : Icons.style,
                            color: marcada
                                ? Colors.white
                                : Colors.deepOrange,
                            size: 25,
                          ),
                          const SizedBox(height: 5),
                          Flexible(
                            child: Text(
                              carta.nombre,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: marcada
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed:
                      _motor.haGanado ||
                              _cartasCantadas >= 16
                          ? null
                          : _cantar,
                  icon: const Icon(Icons.campaign),
                  label: const Text('Cantar siguiente carta'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
