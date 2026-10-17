import 'package:flutter/material.dart';

import '../data/demo_data.dart';
import '../widgets/componentes.dart';

class PanelPersonalScreen extends StatelessWidget {
  const PanelPersonalScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Panel del expendio')),
    body: ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Resumen de hoy',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w900,
            color: tinta,
          ),
        ),
        const SizedBox(height: 14),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.55,
          children: const [
            _Resumen(
              icono: Icons.receipt_long,
              titulo: 'Pedidos',
              valor: '14',
              color: azul,
            ),
            _Resumen(
              icono: Icons.inventory_2_outlined,
              titulo: 'Productos',
              valor: '8',
              color: Color(0xFF27804A),
            ),
            _Resumen(
              icono: Icons.pending_actions,
              titulo: 'Pendientes',
              valor: '3',
              color: Color(0xFFD99A20),
            ),
            _Resumen(
              icono: Icons.local_shipping_outlined,
              titulo: 'En reparto',
              valor: '2',
              color: Color(0xFF7B56A5),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const Text(
          'PEDIDOS RECIENTES',
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 1,
            fontWeight: FontWeight.w800,
            color: grisTexto,
          ),
        ),
        const SizedBox(height: 10),
        ...pedidos
            .take(3)
            .map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: tarjeta(
                  child: Row(
                    children: [
                      const Icon(Icons.receipt_long_outlined, color: azul),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              p.folio,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: tinta,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              p.cliente,
                              style: const TextStyle(
                                fontSize: 11,
                                color: grisTexto,
                              ),
                            ),
                          ],
                        ),
                      ),
                      etiqueta(p.estado, p.color),
                    ],
                  ),
                ),
              ),
            ),
        botonAzul('Gestionar pedidos', onPressed: () {}),
      ],
    ),
  );
}

class _Resumen extends StatelessWidget {
  final IconData icono;
  final String titulo, valor;
  final Color color;
  const _Resumen({
    required this.icono,
    required this.titulo,
    required this.valor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) => tarjeta(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(icono, color: color, size: 23),
        Text(
          valor,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        Text(titulo, style: const TextStyle(fontSize: 11, color: grisTexto)),
      ],
    ),
  );
}
