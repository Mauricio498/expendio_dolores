import 'package:flutter/material.dart';

import '../models/models.dart';
import '../shared/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final form = GlobalKey<FormState>();
  final name = TextEditingController(),
      phone = TextEditingController(),
      email = TextEditingController(),
      pass = TextEditingController(),
      confirm = TextEditingController();
  Role role = Role.client;
  @override
  void dispose() {
    name.dispose();
    phone.dispose();
    email.dispose();
    pass.dispose();
    confirm.dispose();
    super.dispose();
  }

  void validateForm() {
    if (!form.currentState!.validate()) {
      feedback(context, 'Hay datos por corregir.', error: true);
      return;
    }
    feedback(context, 'Los datos son válidos. Es solo una demostración.');
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Formulario válido'),
        content: Text(
          'El registro para ${role.label.toLowerCase()} es válido. No se creó ni guardó ninguna cuenta.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: const Text('Volver al acceso'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Registro')),
    body: Form(
      key: form,
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Heading(
            'Crear cuenta',
            'Formulario de demostración para los perfiles de Expendio Dolores.',
          ),
          const SizedBox(height: 18),
          DropdownButtonFormField<Role>(
            value: role,
            decoration: const InputDecoration(labelText: 'Tipo de perfil'),
            items: Role.values
                .map((r) => DropdownMenuItem(value: r, child: Text(r.label)))
                .toList(),
            onChanged: (v) => setState(() => role = v ?? Role.client),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: name,
            decoration: const InputDecoration(labelText: 'Nombre completo'),
            validator: (v) => v == null || v.trim().length < 3
                ? 'Ingresa un nombre válido.'
                : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: phone,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(labelText: 'Teléfono'),
            validator: (v) =>
                v == null || v.replaceAll(RegExp(r'\D'), '').length < 10
                ? 'Ingresa un teléfono de 10 dígitos.'
                : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(labelText: 'Correo'),
            validator: (v) =>
                v == null ||
                    !RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(v.trim())
                ? 'Ingresa un correo válido.'
                : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: pass,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Contraseña'),
            validator: (v) =>
                v == null || v.length < 6 ? 'Usa al menos 6 caracteres.' : null,
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: confirm,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Confirmar contraseña',
            ),
            validator: (v) =>
                v != pass.text ? 'Las contraseñas no coinciden.' : null,
          ),
          const SizedBox(height: 18),
          PrimaryButton(
            text: 'Validar registro',
            icon: Icons.check_circle_outline,
            onPressed: validateForm,
          ),
        ],
      ),
    ),
  );
}
