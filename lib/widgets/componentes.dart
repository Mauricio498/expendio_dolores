import 'package:flutter/material.dart';

const azul = Color(0xFF07549A);
const tinta = Color(0xFF182230);
const grisTexto = Color(0xFF778292);
const borde = Color(0xFFE4E8EE);
const fondoSuave = Color(0xFFF0F3F7);
const rojo = Color(0xFFC93434);

String dinero(double valor) => '\$${valor.toStringAsFixed(2)}';

Widget busqueda({String hint = 'Buscar productos...'}) => Container(
  height: 46,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(14),
    border: Border.all(color: borde),
  ),
  child: TextField(
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: grisTexto, fontSize: 13),
      prefixIcon: const Icon(Icons.search, size: 20, color: grisTexto),
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(vertical: 13),
    ),
  ),
);

Widget etiqueta(String texto, Color color) => Container(
  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
  decoration: BoxDecoration(
    color: color.withValues(alpha: .12),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text(
    texto,
    style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w700),
  ),
);

Widget tarjeta({
  required Widget child,
  EdgeInsets padding = const EdgeInsets.all(14),
}) => Container(
  padding: padding,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: borde),
  ),
  child: child,
);

Widget botonAzul(String texto, {VoidCallback? onPressed, IconData? icono}) =>
    SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton.icon(
        onPressed: onPressed ?? () {},
        icon: Icon(icono ?? Icons.arrow_forward, size: 18),
        label: Text(texto, style: const TextStyle(fontWeight: FontWeight.w700)),
        style: ElevatedButton.styleFrom(
          backgroundColor: azul,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );

Widget filaImporte(String nombre, double total, {bool destacado = false}) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          nombre,
          style: TextStyle(
            fontSize: destacado ? 15 : 13,
            color: destacado ? tinta : grisTexto,
            fontWeight: destacado ? FontWeight.w800 : FontWeight.normal,
          ),
        ),
        Text(
          dinero(total),
          style: TextStyle(
            fontSize: destacado ? 18 : 13,
            color: tinta,
            fontWeight: destacado ? FontWeight.w800 : FontWeight.w600,
          ),
        ),
      ],
    );
