import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

void main() => runApp(const PedidoLocalApp());

class PedidoLocalApp extends StatelessWidget {
  const PedidoLocalApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'PedidoLocal',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF6F8FB),
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF07549A)),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFF6F8FB),
        foregroundColor: Color(0xFF182230),
        elevation: 0,
      ),
    ),
    home: const LoginScreen(),
  );
}
