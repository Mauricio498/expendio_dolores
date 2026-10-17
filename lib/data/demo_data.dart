import 'package:flutter/material.dart';

import '../models/producto.dart';

// Nombres y precios ilustrativos, no son una lista oficial del expendio.
const productos = [
  Producto(
    nombre: 'Pan de caja',
    categoria: 'Pan de caja',
    presentacion: 'Paquete',
    precio: 48,
    icono: Icons.bakery_dining,
    color: Color(0xFFE9D5B5),
  ),
  Producto(
    nombre: 'Mantecadas',
    categoria: 'Pastelitos',
    presentacion: 'Paquete',
    precio: 32,
    icono: Icons.cake_outlined,
    color: Color(0xFFF1D7B8),
  ),
  Producto(
    nombre: 'Roles de canela',
    categoria: 'Bollería',
    presentacion: 'Paquete',
    precio: 39,
    icono: Icons.breakfast_dining,
    color: Color(0xFFE8C8A1),
  ),
  Producto(
    nombre: 'Donas',
    categoria: 'Pastelitos',
    presentacion: 'Paquete',
    precio: 35,
    icono: Icons.donut_large,
    color: Color(0xFFF0D3DD),
  ),
  Producto(
    nombre: 'Pan tostado',
    categoria: 'Tostadas',
    presentacion: 'Paquete',
    precio: 42,
    icono: Icons.inventory_2_outlined,
    color: Color(0xFFE8D6B4),
  ),
  Producto(
    nombre: 'Pan para hamburguesa',
    categoria: 'Pan de caja',
    presentacion: 'Paquete',
    precio: 36,
    icono: Icons.lunch_dining,
    color: Color(0xFFE7C79C),
  ),
  Producto(
    nombre: 'Pastelitos cubiertos',
    categoria: 'Pastelitos',
    presentacion: 'Caja',
    precio: 44,
    icono: Icons.cake,
    color: Color(0xFFDCC9ED),
  ),
  Producto(
    nombre: 'Bollos',
    categoria: 'Bollería',
    presentacion: 'Paquete',
    precio: 30,
    icono: Icons.bakery_dining_outlined,
    color: Color(0xFFE9D5B5),
  ),
];

const pedidos = [
  PedidoDemo(
    folio: 'PED-00142',
    cliente: 'Abarrotes La Esquina',
    fecha: '16 oct · 10:35',
    estado: 'Pendiente',
    total: 685,
    color: Color(0xFFD99A20),
    tipoEntrega: 'Ruta de reparto',
  ),
  PedidoDemo(
    folio: 'PED-00141',
    cliente: 'María González',
    fecha: '16 oct · 09:50',
    estado: 'En preparación',
    total: 245,
    color: Color(0xFF1769AA),
  ),
  PedidoDemo(
    folio: 'PED-00140',
    cliente: 'Tienda San José',
    fecha: '15 oct · 16:20',
    estado: 'Entregado',
    total: 920,
    color: Color(0xFF27804A),
    tipoEntrega: 'Ruta de reparto',
  ),
  PedidoDemo(
    folio: 'PED-00139',
    cliente: 'Miscelánea Lupita',
    fecha: '15 oct · 13:05',
    estado: 'Entrega incompleta',
    total: 410,
    color: Color(0xFFD99A20),
    tipoEntrega: 'Ruta de reparto',
  ),
];
