import 'package:flutter/material.dart';

import '../data/demo_data.dart';
import '../widgets/componentes.dart';
import '../widgets/producto_card.dart';

class CatalogoScreen extends StatefulWidget {
  const CatalogoScreen({super.key});
  @override
  State<CatalogoScreen> createState() => _CatalogoScreenState();
}

class _CatalogoScreenState extends State<CatalogoScreen> {
  String categoria = 'Todos';
  final categorias = const [
    'Todos',
    'Pan de caja',
    'Bollería',
    'Pastelitos',
    'Tostadas',
  ];

  @override
  Widget build(BuildContext context) {
    final lista = categoria == 'Todos'
        ? productos
        : productos.where((p) => p.categoria == categoria).toList();
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: azul,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.storefront,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    const SizedBox(width: 11),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PedidoLocal',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w900,
                              color: tinta,
                            ),
                          ),
                          Text(
                            'Expendio de productos',
                            style: TextStyle(fontSize: 11, color: grisTexto),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications_none_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                const Text(
                  '¡Bienvenido! 👋',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: tinta,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Encuentra tus productos favoritos del expendio.',
                  style: TextStyle(fontSize: 12, color: grisTexto),
                ),
                const SizedBox(height: 17),
                busqueda(),
                const SizedBox(height: 22),
                const Text(
                  'CATEGORÍAS',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.w800,
                    color: grisTexto,
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: categorias.map((c) {
                      final selected = categoria == c;
                      return Padding(
                        padding: const EdgeInsets.only(right: 7),
                        child: ChoiceChip(
                          label: Text(c),
                          selected: selected,
                          onSelected: (_) => setState(() => categoria = c),
                          showCheckmark: false,
                          backgroundColor: Colors.white,
                          selectedColor: azul,
                          labelStyle: TextStyle(
                            fontSize: 11,
                            color: selected ? Colors.white : tinta,
                            fontWeight: FontWeight.w600,
                          ),
                          side: BorderSide(color: selected ? azul : borde),
                          shape: const StadiumBorder(),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Productos del expendio',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: tinta,
                      ),
                    ),
                    Text(
                      '${lista.length} productos',
                      style: const TextStyle(fontSize: 10, color: grisTexto),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => ProductoCard(
                  producto: lista[index],
                  onAgregar: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${lista[index].nombre}: acción de demostración',
                        ),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
                childCount: lista.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 11,
                mainAxisSpacing: 12,
                childAspectRatio: .68,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }
}
