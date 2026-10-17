import 'package:flutter/material.dart';

import '../data/demo_data.dart';
import '../widgets/componentes.dart';

class CarritoScreen extends StatelessWidget {
  const CarritoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final seleccionados = [productos[0], productos[2], productos[4]];
    const cantidades = [2, 3, 1];
    final subtotal = seleccionados.asMap().entries.fold<double>(
      0,
      (s, e) => s + e.value.precio * cantidades[e.key],
    );
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mi carrito',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w900,
                color: tinta,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Productos para tu pedido',
              style: TextStyle(fontSize: 12, color: grisTexto),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: seleccionados.asMap().entries.map((e) {
                  final p = e.value;
                  final cantidad = cantidades[e.key];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: tarjeta(
                      child: Row(
                        children: [
                          Container(
                            width: 65,
                            height: 70,
                            decoration: BoxDecoration(
                              color: p.color,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              p.icono,
                              color: const Color(0xFF7A6045),
                              size: 34,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  p.nombre,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: tinta,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  p.presentacion,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: grisTexto,
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  'Cantidad: $cantidad',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: grisTexto,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            dinero(p.precio * cantidad),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: azul,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            tarjeta(
              child: Column(
                children: [
                  filaImporte('Subtotal', subtotal),
                  const SizedBox(height: 12),
                  filaImporte('Envío', 0),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1),
                  ),
                  filaImporte('Total estimado', subtotal, destacado: true),
                ],
              ),
            ),
            const SizedBox(height: 13),
            botonAzul(
              'Continuar con el pedido',
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Prototipo visual: preventa no registrada.'),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
