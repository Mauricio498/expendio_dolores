import 'package:flutter/material.dart';

import '../data/demo_data.dart';
import '../models/producto.dart';
import '../widgets/componentes.dart';

class DetallePedidoScreen extends StatelessWidget {
  final PedidoDemo pedido;
  const DetallePedidoScreen({super.key, required this.pedido});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Detalle del pedido'),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
    ),
    body: ListView(
      padding: const EdgeInsets.all(18),
      children: [
        tarjeta(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      pedido.folio,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                        color: tinta,
                      ),
                    ),
                  ),
                  etiqueta(pedido.estado, pedido.color),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                '${pedido.fecha} · ${pedido.cliente}',
                style: const TextStyle(fontSize: 11, color: grisTexto),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'PRODUCTOS DEL PEDIDO',
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 1,
            fontWeight: FontWeight.w800,
            color: grisTexto,
          ),
        ),
        const SizedBox(height: 10),
        tarjeta(
          child: Column(
            children: [
              ...productos
                  .take(3)
                  .map(
                    (p) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7),
                      child: Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: p.color,
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Icon(
                              p.icono,
                              size: 23,
                              color: const Color(0xFF7A6045),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              p.nombre,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: tinta,
                              ),
                            ),
                          ),
                          Text(
                            dinero(p.precio),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              const Divider(height: 20),
              filaImporte('Total del pedido', pedido.total, destacado: true),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'INFORMACIÓN DE ENTREGA',
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 1,
            fontWeight: FontWeight.w800,
            color: grisTexto,
          ),
        ),
        const SizedBox(height: 10),
        tarjeta(
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.local_shipping_outlined, color: azul, size: 25),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Entrega / ruta',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: tinta,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'La dirección y los detalles se confirman con el personal del expendio.',
                      style: TextStyle(fontSize: 11, color: grisTexto),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'SEGUIMIENTO',
          style: TextStyle(
            fontSize: 11,
            letterSpacing: 1,
            fontWeight: FontWeight.w800,
            color: grisTexto,
          ),
        ),
        const SizedBox(height: 10),
        tarjeta(
          child: Column(
            children: [
              _paso(Icons.receipt_long, 'Pedido registrado', true),
              _paso(
                Icons.inventory_2_outlined,
                'Preparación del pedido',
                pedido.estado != 'Pendiente',
              ),
              _paso(
                Icons.local_shipping_outlined,
                'En ruta de entrega',
                pedido.estado == 'Entregado' ||
                    pedido.estado == 'Entrega incompleta',
              ),
              _paso(
                Icons.check_circle_outline,
                'Entrega finalizada',
                pedido.estado == 'Entregado',
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        botonAzul(
          'Volver a pedidos',
          onPressed: () => Navigator.pop(context),
          icono: Icons.arrow_back,
        ),
      ],
    ),
  );

  Widget _paso(IconData icono, String titulo, bool activo) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      children: [
        CircleAvatar(
          radius: 17,
          backgroundColor: activo ? const Color(0xFFDCEBFA) : fondoSuave,
          child: Icon(icono, size: 18, color: activo ? azul : grisTexto),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Text(
            titulo,
            style: TextStyle(
              fontSize: 12,
              fontWeight: activo ? FontWeight.w700 : FontWeight.normal,
              color: activo ? tinta : grisTexto,
            ),
          ),
        ),
        if (activo)
          const Icon(Icons.check_circle, size: 17, color: Color(0xFF27804A)),
      ],
    ),
  );
}
