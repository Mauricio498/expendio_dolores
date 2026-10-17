import 'package:flutter/material.dart';

import 'catalogo_screen.dart';
import 'carrito_screen.dart';
import 'pedidos_screen.dart';
import 'perfil_screen.dart';

class InicioApp extends StatefulWidget {
  const InicioApp({super.key});
  @override
  State<InicioApp> createState() => _InicioAppState();
}

class _InicioAppState extends State<InicioApp> {
  int indice = 0;
  final pantallas = const [
    CatalogoScreen(),
    CarritoScreen(),
    PedidosScreen(),
    PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(index: indice, children: pantallas),
    bottomNavigationBar: NavigationBar(
      selectedIndex: indice,
      backgroundColor: Colors.white,
      indicatorColor: const Color(0xFFDCEBFA),
      onDestinationSelected: (i) => setState(() => indice = i),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.storefront_outlined),
          selectedIcon: Icon(Icons.storefront),
          label: 'Expendio',
        ),
        NavigationDestination(
          icon: Icon(Icons.shopping_cart_outlined),
          selectedIcon: Icon(Icons.shopping_cart),
          label: 'Carrito',
        ),
        NavigationDestination(
          icon: Icon(Icons.receipt_long_outlined),
          selectedIcon: Icon(Icons.receipt_long),
          label: 'Pedidos',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Perfil',
        ),
      ],
    ),
  );
}
