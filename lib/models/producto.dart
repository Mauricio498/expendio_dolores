import 'package:flutter/material.dart';

class Producto {
  final String nombre, categoria, presentacion;
  final double precio;
  final IconData icono;
  final Color color;

  const Producto({
    required this.nombre,
    required this.categoria,
    required this.presentacion,
    required this.precio,
    required this.icono,
    required this.color,
  });
}

class PedidoDemo {
  final String folio, cliente, fecha, estado, tipoEntrega;
  final double total;
  final Color color;

  const PedidoDemo({
    required this.folio,
    required this.cliente,
    required this.fecha,
    required this.estado,
    required this.total,
    required this.color,
    this.tipoEntrega = 'Entrega a domicilio',
  });
}
