import 'package:flutter/material.dart';

enum Role { client, staff, courier, admin }

extension RoleText on Role {
  String get label => switch (this) {
    Role.client => 'Cliente',
    Role.staff => 'Personal',
    Role.courier => 'Repartidor',
    Role.admin => 'Administrador',
  };
}

class DemoUser {
  final String id, name, email, phone;
  final Role role;
  const DemoUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
  });
}

class Product {
  final String id, name, category, presentation;
  final double price;
  final IconData icon;
  final Color color;
  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.presentation,
    required this.price,
    required this.icon,
    required this.color,
  });
}

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  inDelivery,
  delivered,
  incomplete,
  cancelled,
}

extension OrderStatusText on OrderStatus {
  String get label => switch (this) {
    OrderStatus.pending => 'Pendiente',
    OrderStatus.confirmed => 'Confirmado',
    OrderStatus.preparing => 'En preparación',
    OrderStatus.inDelivery => 'En reparto',
    OrderStatus.delivered => 'Entregado',
    OrderStatus.incomplete => 'Entrega incompleta',
    OrderStatus.cancelled => 'Cancelado',
  };
}

class OrderLine {
  final String productId, name;
  final double price;
  final int quantity;
  const OrderLine({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
  });
  double get subtotal => price * quantity;
}

class DemoOrder {
  final String id, customerId, customerName, deliveryType, address;
  final DateTime createdAt;
  final List<OrderLine> lines;
  final String? courierId;
  OrderStatus status;
  String? deliveryResult, note;
  DemoOrder({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.deliveryType,
    required this.address,
    required this.createdAt,
    required this.lines,
    required this.status,
    this.courierId,
    this.deliveryResult,
    this.note,
  });
  double get total => lines.fold(0, (s, l) => s + l.subtotal);
}
