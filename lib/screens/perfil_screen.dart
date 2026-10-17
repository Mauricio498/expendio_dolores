import 'package:flutter/material.dart';

import '../widgets/componentes.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Mi perfil',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: tinta,
          ),
        ),
        const SizedBox(height: 25),
        const CircleAvatar(
          radius: 43,
          backgroundColor: Color(0xFFDCEBFA),
          child: Icon(Icons.person_outline, size: 46, color: azul),
        ),
        const SizedBox(height: 12),
        const Text(
          'Usuario de ejemplo',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: tinta,
          ),
        ),
        const SizedBox(height: 5),
        const Text(
          'usuario@correo.com',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: grisTexto),
        ),
        const SizedBox(height: 25),
        const Text(
          'INFORMACIÓN PERSONAL',
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 1,
            fontWeight: FontWeight.w800,
            color: grisTexto,
          ),
        ),
        const SizedBox(height: 10),
        tarjeta(
          child: const Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.phone_outlined, color: azul),
                title: Text('Teléfono', style: TextStyle(fontSize: 12)),
                subtitle: Text('Dato de ejemplo'),
              ),
              Divider(),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.location_on_outlined, color: azul),
                title: Text('Dirección', style: TextStyle(fontSize: 12)),
                subtitle: Text('Dirección de entrega'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'OPCIONES',
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 1,
            fontWeight: FontWeight.w800,
            color: grisTexto,
          ),
        ),
        const SizedBox(height: 10),
        tarjeta(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.receipt_long_outlined, color: azul),
                title: const Text(
                  'Mis pedidos',
                  style: TextStyle(fontSize: 13),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.notifications_none, color: azul),
                title: const Text(
                  'Notificaciones',
                  style: TextStyle(fontSize: 13),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.help_outline, color: azul),
                title: const Text('Ayuda', style: TextStyle(fontSize: 13)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.logout),
          label: const Text('Cerrar sesión'),
          style: OutlinedButton.styleFrom(
            foregroundColor: rojo,
            minimumSize: const Size.fromHeight(46),
            side: const BorderSide(color: rojo),
          ),
        ),
      ],
    ),
  );
}
