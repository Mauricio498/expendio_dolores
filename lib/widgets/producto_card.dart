import 'package:flutter/material.dart';

import '../models/producto.dart';
import 'componentes.dart';

class ProductoCard extends StatelessWidget {
  final Producto producto;
  final VoidCallback? onAgregar;
  const ProductoCard({super.key, required this.producto, this.onAgregar});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: borde),
      borderRadius: BorderRadius.circular(15),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            color: producto.color,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(producto.icono, size: 64, color: const Color(0xFF7A6045)),
                Positioned(
                  top: 9,
                  left: 9,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: .9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      producto.presentacion,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: tinta,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 9, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                producto.nombre,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: tinta,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                producto.categoria,
                style: const TextStyle(fontSize: 10, color: grisTexto),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      dinero(producto.precio),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: azul,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onAgregar,
                    borderRadius: BorderRadius.circular(9),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: azul,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 19,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
