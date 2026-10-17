import 'package:flutter/material.dart';

import '../data/demo_data.dart';
import '../widgets/componentes.dart';
import 'detalle_pedido_screen.dart';

class PedidosScreen extends StatelessWidget {
  const PedidosScreen({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const Text(
          'Pedidos',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w900,
            color: tinta,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'Consulta el estado de tus pedidos y preventas.',
          style: TextStyle(fontSize: 12, color: grisTexto),
        ),
        const SizedBox(height: 18),
        busqueda(hint: 'Buscar por folio o cliente...'),
        const SizedBox(height: 17),
        ...pedidos.map(
          (p) => Padding(
            padding: const EdgeInsets.only(bottom: 11),
            child: InkWell(
              borderRadius: BorderRadius.circular(15),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetallePedidoScreen(pedido: p),
                ),
              ),
              child: tarjeta(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.receipt_long_outlined,
                          size: 19,
                          color: azul,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            p.folio,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                              color: tinta,
                            ),
                          ),
                        ),
                        etiqueta(p.estado, p.color),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      p.cliente,
                      style: const TextStyle(
                        fontSize: 13,
                        color: tinta,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      p.fecha,
                      style: const TextStyle(fontSize: 11, color: grisTexto),
                    ),
                    const Divider(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          p.tipoEntrega,
                          style: const TextStyle(
                            fontSize: 11,
                            color: grisTexto,
                          ),
                        ),
                        Text(
                          dinero(p.total),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                            color: azul,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
