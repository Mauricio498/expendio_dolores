import 'package:flutter/material.dart';

import '../models/models.dart';

class DemoStore extends ChangeNotifier {
  DemoStore._() {
    orders.addAll([
      DemoOrder(
        id: 'PED-00140',
        customerId: 'u-client',
        customerName: 'Mauricio Pérez',
        deliveryType: 'Entrega a domicilio',
        address: 'Calle Hidalgo 12, Zona Centro',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        lines: const [
          OrderLine(
            productId: 'p1',
            name: 'Pan Blanco Bimbo Grande 620 g',
            price: 36,
            quantity: 2,
          ),
          OrderLine(
            productId: 'p2',
            name: 'Mantecadas Bimbo sabor vainilla',
            price: 20,
            quantity: 2,
          ),
        ],
        status: OrderStatus.preparing,
        courierId: 'u-courier',
      ),
      DemoOrder(
        id: 'PED-00139',
        customerId: 'u-client',
        customerName: 'Mauricio Pérez',
        deliveryType: 'Recoger en expendio',
        address: 'Expendio PedidoLocal',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        lines: const [
          OrderLine(
            productId: 'p3',
            name: 'Roles de canela Bimbo',
            price: 13,
            quantity: 3,
          ),
        ],
        status: OrderStatus.delivered,
        courierId: 'u-courier',
        deliveryResult: 'Entrega completa',
      ),
    ]);
  }
  static final instance = DemoStore._();
  static const password = '123456';

  final users = <DemoUser>[
    const DemoUser(
      id: 'u-client',
      name: 'Mauricio Pérez',
      email: 'cliente@expendiodolores.mx',
      phone: '444 123 4567',
      role: Role.client,
    ),
    const DemoUser(
      id: 'u-staff',
      name: 'Luis Manuel Arteaga Cruz',
      email: 'personal@expendiodolores.mx',
      phone: '444 123 0000',
      role: Role.staff,
    ),
    const DemoUser(
      id: 'u-courier',
      name: 'Alfonso Alderete',
      email: 'repartidor@expendiodolores.mx',
      phone: '444 123 1111',
      role: Role.courier,
    ),
    const DemoUser(
      id: 'u-admin',
      name: 'Mau Pérez',
      email: 'admin@expendiodolores.mx',
      phone: '444 123 2222',
      role: Role.admin,
    ),
  ];
  final products = <Product>[
    const Product(
      id: 'p1',
      name: 'Pan Blanco Bimbo Grande 620 g',
      category: 'Pan de caja',
      presentation: 'Bolsa 620 g',
      price: 36,
      icon: Icons.bakery_dining,
      color: Color(0xFFE9D5B5),
    ),
    const Product(
      id: 'p2',
      name: 'Pan Integral Bimbo Grande',
      category: 'Pan de caja',
      presentation: 'Bolsa',
      price: 39,
      icon: Icons.grain,
      color: Color(0xFFD9C6A4),
    ),
    const Product(
      id: 'p3',
      name: 'Pan Tostado Bimbo Clásico',
      category: 'Tostadas',
      presentation: 'Paquete',
      price: 30,
      icon: Icons.breakfast_dining,
      color: Color(0xFFE8D6B4),
    ),
    const Product(
      id: 'p4',
      name: 'Mantecadas Bimbo sabor vainilla',
      category: 'Pastelitos',
      presentation: 'Paquete',
      price: 20,
      icon: Icons.cake_outlined,
      color: Color(0xFFF1D7B8),
    ),
    const Product(
      id: 'p5',
      name: 'Roles de canela Bimbo',
      category: 'Bollería',
      presentation: 'Paquete 2 piezas',
      price: 13,
      icon: Icons.bakery_dining,
      color: Color(0xFFE8C8A1),
    ),
    const Product(
      id: 'p6',
      name: 'Donas Bimbo',
      category: 'Pastelitos',
      presentation: 'Paquete',
      price: 10,
      icon: Icons.donut_large,
      color: Color(0xFFF0D3DD),
    ),
    const Product(
      id: 'p7',
      name: 'Panquecitos Bimbo con chispas de chocolate',
      category: 'Pastelitos',
      presentation: 'Paquete',
      price: 15,
      icon: Icons.cake,
      color: Color(0xFFDCC9ED),
    ),
    const Product(
      id: 'p8',
      name: 'Rebanadas Bimbo',
      category: 'Pan dulce',
      presentation: 'Paquete',
      price: 5,
      icon: Icons.inventory_2_outlined,
      color: Color(0xFFE9D5B5),
    ),
    const Product(
      id: 'p9',
      name: 'Panqué Bimbo con nuez',
      category: 'Pan dulce',
      presentation: 'Paquete',
      price: 39,
      icon: Icons.cake_outlined,
      color: Color(0xFFD8C1A4),
    ),
    const Product(
      id: 'p10',
      name: 'Medias Noches Bimbo',
      category: 'Pan de caja',
      presentation: 'Paquete',
      price: 48,
      icon: Icons.lunch_dining,
      color: Color(0xFFE7C79C),
    ),
    const Product(
      id: 'p11',
      name: 'Conchas sabor vainilla Bimbo',
      category: 'Pan dulce',
      presentation: 'Paquete',
      price: 18,
      icon: Icons.bakery_dining_outlined,
      color: Color(0xFFE9D5B5),
    ),
    const Product(
      id: 'p12',
      name: 'Colchones sabor naranja Bimbo',
      category: 'Pan dulce',
      presentation: 'Paquete',
      price: 16,
      icon: Icons.breakfast_dining,
      color: Color(0xFFF0D2A8),
    ),
  ];
  final orders = <DemoOrder>[];
  final cart = <String, int>{};
  DemoUser? user;
  int _nextOrder = 142;

  bool login(String email, String pass) {
    DemoUser? found;
    for (final candidate in users) {
      if (candidate.email.toLowerCase() == email.trim().toLowerCase()) {
        found = candidate;
        break;
      }
    }
    if (found == null || pass != password) return false;
    user = found;
    notifyListeners();
    return true;
  }

  void logout() {
    user = null;
    cart.clear();
    notifyListeners();
  }

  void add(Product p) {
    cart.update(p.id, (n) => n + 1, ifAbsent: () => 1);
    notifyListeners();
  }

  void quantity(String id, int n) {
    if (n <= 0) {
      cart.remove(id);
    } else {
      cart[id] = n;
    }
    notifyListeners();
  }

  List<DemoOrder> get visibleOrders {
    final u = user;
    if (u == null) return [];
    if (u.role == Role.client)
      return orders.where((o) => o.customerId == u.id).toList();
    if (u.role == Role.courier)
      return orders.where((o) => o.courierId == u.id).toList();
    return List.unmodifiable(orders);
  }

  DemoOrder? createOrder(String type, String address) {
    if (user?.role != Role.client || cart.isEmpty) return null;
    final lines = cart.entries.map((e) {
      final p = products.firstWhere((p) => p.id == e.key);
      return OrderLine(
        productId: p.id,
        name: p.name,
        price: p.price,
        quantity: e.value,
      );
    }).toList();
    final o = DemoOrder(
      id: 'PED-${_nextOrder++}',
      customerId: user!.id,
      customerName: user!.name,
      deliveryType: type,
      address: address,
      createdAt: DateTime.now(),
      lines: lines,
      status: OrderStatus.pending,
      courierId: 'u-courier',
    );
    orders.insert(0, o);
    cart.clear();
    notifyListeners();
    return o;
  }

  void updateStatus(DemoOrder order, OrderStatus status) {
    order.status = status;
    notifyListeners();
  }

  void recordDelivery(DemoOrder order, String result, String note) {
    order.deliveryResult = result;
    order.note = note.trim().isEmpty ? null : note.trim();
    order.status = result == 'Entrega completa'
        ? OrderStatus.delivered
        : OrderStatus.incomplete;
    notifyListeners();
  }
}
