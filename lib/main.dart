import 'package:flutter/material.dart';

import 'screens/inicio_app.dart';

void main() => runApp(const PedidoLocalApp());

class PedidoLocalApp extends StatelessWidget {
  const PedidoLocalApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'PedidoLocal',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF8F9FB),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF07549A)),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF8F9FB),
        foregroundColor: Color(0xFF182230),
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Color(0xFF182230),
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
    home: const InicioApp(),
  );
}
