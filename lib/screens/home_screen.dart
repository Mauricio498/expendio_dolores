import 'package:flutter/material.dart';

import '../data/demo_store.dart';
import '../models/models.dart';
import '../shared/widgets.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _Tab {
  final String label;
  final IconData icon;
  final Widget screen;
  const _Tab(this.label, this.icon, this.screen);
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  List<_Tab> tabsFor(Role role) => switch (role) {
    Role.client => [
      _Tab('Inicio', Icons.home_outlined, const ClientDashboard()),
      _Tab('Productos', Icons.storefront_outlined, const CatalogScreen()),
      _Tab('Pedidos', Icons.receipt_long_outlined, const OrdersScreen()),
      _Tab('Perfil', Icons.person_outline, const ProfileScreen()),
    ],
    Role.staff => [
      _Tab('Panel', Icons.dashboard_outlined, const StaffDashboard()),
      _Tab('Pedidos', Icons.receipt_long_outlined, const OrdersScreen()),
      _Tab(
        'Productos',
        Icons.inventory_2_outlined,
        const CatalogScreen(staffView: true),
      ),
    ],
    Role.courier => [
      _Tab('Panel', Icons.dashboard_outlined, const CourierDashboard()),
      _Tab(
        'Entregas',
        Icons.local_shipping_outlined,
        const DeliveryListScreen(),
      ),
      _Tab('Historial', Icons.history, const OrdersScreen(historyOnly: true)),
    ],
    Role.admin => [
      _Tab('Panel', Icons.dashboard_outlined, const AdminDashboard()),
      _Tab('Pedidos', Icons.receipt_long_outlined, const OrdersScreen()),
      _Tab('Usuarios', Icons.people_outline, const UsersScreen()),
      _Tab(
        'Productos',
        Icons.inventory_2_outlined,
        const CatalogScreen(staffView: true),
      ),
    ],
  };

  void logout() {
    DemoStore.instance.logout();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = DemoStore.instance.user;
    if (user == null) return const LoginScreen();
    final tabs = tabsFor(user.role);
    if (index >= tabs.length) index = 0;
    return AnimatedBuilder(
      animation: DemoStore.instance,
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PedidoLocal · ${user.role.label}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                user.name,
                style: const TextStyle(fontSize: 11, color: muted),
              ),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'Cerrar sesión',
              onPressed: logout,
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: IndexedStack(
          index: index,
          children: tabs.map((t) => t.screen).toList(),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (i) => setState(() => index = i),
          destinations: tabs
              .map(
                (t) =>
                    NavigationDestination(icon: Icon(t.icon), label: t.label),
              )
              .toList(),
        ),
      ),
    );
  }
}

class ClientDashboard extends StatelessWidget {
  const ClientDashboard({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const Heading(
        '¡Bienvenido!',
        'Explora los productos del expendio y prepara tu pedido.',
      ),
      const SizedBox(height: 16),
      _ActionCard(
        icon: Icons.storefront,
        title: 'Explorar productos',
        subtitle: 'Pan de caja, bollería, pastelitos y más.',
        onTap: () => _selectTab(context, 1),
      ),
      _ActionCard(
        icon: Icons.shopping_cart_outlined,
        title: 'Abrir carrito',
        subtitle: 'Revisa y confirma tus productos.',
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CartScreen()),
        ),
      ),
      _ActionCard(
        icon: Icons.receipt_long_outlined,
        title: 'Mis pedidos',
        subtitle: 'Consulta los estados y el seguimiento.',
        onTap: () => _selectTab(context, 2),
      ),
    ],
  );
  void _selectTab(BuildContext context, int i) {
    final state = context.findAncestorStateOfType<_HomeScreenState>();
    state?.setState(() => state.index = i);
  }
}

class CatalogScreen extends StatefulWidget {
  final bool staffView;
  const CatalogScreen({super.key, this.staffView = false});
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String category = 'Todos', query = '';
  final search = TextEditingController();
  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: DemoStore.instance,
    builder: (context, _) {
      final list = DemoStore.instance.products
          .where(
            (p) =>
                (category == 'Todos' || p.category == category) &&
                p.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
      const categories = [
        'Todos',
        'Pan de caja',
        'Bollería',
        'Pastelitos',
        'Tostadas',
      ];
      return SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Heading(
                    widget.staffView ? 'Productos' : 'Catálogo',
                    widget.staffView
                        ? 'Catálogo de consulta en esta versión.'
                        : 'Productos del expendio de panificación.',
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: search,
                    onChanged: (v) => setState(() => query = v),
                    decoration: const InputDecoration(
                      hintText: 'Buscar productos...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((c) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: ChoiceChip(
                            label: Text(c),
                            selected: category == c,
                            onSelected: (_) => setState(() => category = c),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${list.length} productos',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ]),
              ),
            ),
            if (list.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('No hay productos que coincidan.'),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) => ProductTile(
                      product: list[i],
                      onAdd: () {
                        if (widget.staffView ||
                            DemoStore.instance.user?.role != Role.client) {
                          feedback(
                            context,
                            'Este perfil solo puede consultar el catálogo.',
                          );
                          return;
                        }
                        DemoStore.instance.add(list[i]);
                        feedback(
                          context,
                          '${list[i].name} añadido al carrito.',
                        );
                      },
                    ),
                    childCount: list.length,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 12,
                    childAspectRatio: .68,
                  ),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      );
    },
  );
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String type = 'Entrega a domicilio';
  final address = TextEditingController(text: 'Calle Hidalgo 12, Zona Centro');
  @override
  void dispose() {
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: DemoStore.instance,
    builder: (context, _) {
      final store = DemoStore.instance;
      final items = store.cart.entries
          .map(
            (e) => (store.products.firstWhere((p) => p.id == e.key), e.value),
          )
          .toList();
      final total = items.fold<double>(0, (s, e) => s + e.$1.price * e.$2);
      return Scaffold(
        appBar: AppBar(title: const Text('Mi carrito')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Heading(
              'Tu pedido',
              'Ajusta cantidades y valida la entrega.',
            ),
            const SizedBox(height: 12),
            if (items.isEmpty)
              const Padding(
                padding: EdgeInsets.all(28),
                child: Center(
                  child: Text(
                    'El carrito está vacío. Regresa al catálogo para añadir productos.',
                  ),
                ),
              )
            else
              ...items.map(
                (e) => Card(
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: e.$1.color,
                      child: Icon(e.$1.icon, color: const Color(0xFF7A6045)),
                    ),
                    title: Text(e.$1.name),
                    subtitle: Text(
                      '\$${e.$1.price.toStringAsFixed(2)} · Subtotal \$${(e.$1.price * e.$2).toStringAsFixed(2)}',
                    ),
                    trailing: SizedBox(
                      width: 112,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => store.quantity(e.$1.id, e.$2 - 1),
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                          Text('${e.$2}'),
                          IconButton(
                            onPressed: () => store.quantity(e.$1.id, e.$2 + 1),
                            icon: const Icon(Icons.add_circle_outline),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            if (items.isNotEmpty) ...[
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                value: type,
                decoration: const InputDecoration(labelText: 'Tipo de entrega'),
                items: const [
                  DropdownMenuItem(
                    value: 'Entrega a domicilio',
                    child: Text('Entrega a domicilio'),
                  ),
                  DropdownMenuItem(
                    value: 'Recoger en expendio',
                    child: Text('Recoger en expendio'),
                  ),
                ],
                onChanged: (v) => setState(() => type = v ?? type),
              ),
              if (type == 'Entrega a domicilio') ...[
                const SizedBox(height: 10),
                TextField(
                  controller: address,
                  decoration: const InputDecoration(
                    labelText: 'Dirección de entrega',
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Card(
                color: Colors.white,
                child: ListTile(
                  title: const Text('Total estimado'),
                  trailing: Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              PrimaryButton(
                text: 'Confirmar pedido demo',
                icon: Icons.check_circle_outline,
                onPressed: () {
                  if (type == 'Entrega a domicilio' &&
                      address.text.trim().length < 5) {
                    feedback(
                      context,
                      'Ingresa una dirección válida.',
                      error: true,
                    );
                    return;
                  }
                  final order = store.createOrder(
                    type,
                    type == 'Entrega a domicilio'
                        ? address.text.trim()
                        : 'Expendio PedidoLocal',
                  );
                  if (order == null) {
                    feedback(
                      context,
                      'Añade al menos un producto.',
                      error: true,
                    );
                    return;
                  }
                  feedback(context, 'Pedido ${order.id} creado en memoria.');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderDetailScreen(orderId: order.id),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      );
    },
  );
}

class OrdersScreen extends StatelessWidget {
  final bool historyOnly;
  const OrdersScreen({super.key, this.historyOnly = false});
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: DemoStore.instance,
    builder: (context, _) {
      final user = DemoStore.instance.user!;
      var orders = DemoStore.instance.visibleOrders;
      if (historyOnly)
        orders = orders
            .where(
              (o) => [
                OrderStatus.delivered,
                OrderStatus.incomplete,
                OrderStatus.cancelled,
              ].contains(o.status),
            )
            .toList();
      return Scaffold(
        appBar: AppBar(
          title: Text(historyOnly ? 'Historial de entregas' : 'Pedidos'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Heading(
              historyOnly ? 'Historial' : 'Pedidos',
              user.role == Role.client
                  ? 'Consulta tus pedidos y su estado.'
                  : 'Pedidos disponibles para ${user.role.label.toLowerCase()}.',
            ),
            const SizedBox(height: 12),
            if (orders.isEmpty)
              const Padding(
                padding: EdgeInsets.all(25),
                child: Center(child: Text('No hay pedidos para mostrar.')),
              )
            else
              ...orders.map(
                (o) => OrderTile(
                  order: o,
                  showCustomer: user.role != Role.client,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderDetailScreen(orderId: o.id),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    },
  );
}

class OrderDetailScreen extends StatelessWidget {
  final String orderId;
  const OrderDetailScreen({super.key, required this.orderId});
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: DemoStore.instance,
    builder: (context, _) {
      final store = DemoStore.instance;
      final found = store.orders.where((o) => o.id == orderId);
      if (found.isEmpty)
        return Scaffold(
          appBar: AppBar(title: const Text('Pedido')),
          body: const Center(child: Text('Pedido no disponible.')),
        );
      final o = found.first, user = store.user!;
      final canManage = user.role == Role.staff || user.role == Role.admin;
      final canDeliver = user.role == Role.courier && o.courierId == user.id;
      return Scaffold(
        appBar: AppBar(title: const Text('Detalle del pedido')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              color: Colors.white,
              child: ListTile(
                title: Text(
                  o.id,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
                subtitle: Text(
                  '${o.customerName}\n${o.deliveryType} · ${o.address}',
                ),
                isThreeLine: true,
                trailing: StatusPill(o.status),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'PRODUCTOS',
              style: TextStyle(fontWeight: FontWeight.w800, color: muted),
            ),
            Card(
              color: Colors.white,
              child: Column(
                children: [
                  ...o.lines.map(
                    (l) => ListTile(
                      title: Text('${l.name} × ${l.quantity}'),
                      trailing: Text('\$${l.subtotal.toStringAsFixed(2)}'),
                    ),
                  ),
                  ListTile(
                    title: const Text(
                      'Total',
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                    trailing: Text(
                      '\$${o.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'SEGUIMIENTO',
              style: TextStyle(fontWeight: FontWeight.w800, color: muted),
            ),
            Card(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.receipt_long),
                    title: const Text('Pedido registrado'),
                    trailing: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.inventory_2_outlined),
                    title: const Text('Estado actual'),
                    subtitle: Text(o.status.label),
                  ),
                  if (o.deliveryResult != null)
                    ListTile(
                      leading: const Icon(Icons.local_shipping_outlined),
                      title: Text(o.deliveryResult!),
                      subtitle: Text(o.note ?? 'Sin observaciones'),
                    ),
                ],
              ),
            ),
            if (canManage) ...[
              const SizedBox(height: 12),
              const Text(
                'ACTUALIZAR ESTADO',
                style: TextStyle(fontWeight: FontWeight.w800, color: muted),
              ),
              DropdownButtonFormField<OrderStatus>(
                value:
                    [
                      OrderStatus.pending,
                      OrderStatus.confirmed,
                      OrderStatus.preparing,
                      OrderStatus.inDelivery,
                      OrderStatus.cancelled,
                    ].contains(o.status)
                    ? o.status
                    : OrderStatus.preparing,
                items: const [
                  DropdownMenuItem(
                    value: OrderStatus.pending,
                    child: Text('Pendiente'),
                  ),
                  DropdownMenuItem(
                    value: OrderStatus.confirmed,
                    child: Text('Confirmado'),
                  ),
                  DropdownMenuItem(
                    value: OrderStatus.preparing,
                    child: Text('En preparación'),
                  ),
                  DropdownMenuItem(
                    value: OrderStatus.inDelivery,
                    child: Text('En reparto'),
                  ),
                  DropdownMenuItem(
                    value: OrderStatus.cancelled,
                    child: Text('Cancelado'),
                  ),
                ],
                onChanged: (s) {
                  if (s != null) {
                    store.updateStatus(o, s);
                    feedback(context, 'Estado actualizado: ${s.label}.');
                  }
                },
              ),
            ],
            if (canDeliver) ...[
              const SizedBox(height: 12),
              const Text(
                'RESULTADO DE ENTREGA',
                style: TextStyle(fontWeight: FontWeight.w800, color: muted),
              ),
              PrimaryButton(
                text: 'Entrega completa',
                icon: Icons.check_circle_outline,
                onPressed: () {
                  store.recordDelivery(o, 'Entrega completa', '');
                  feedback(context, 'Entrega registrada.');
                },
              ),
              const SizedBox(height: 8),
              PrimaryButton(
                text: 'Entrega incompleta',
                icon: Icons.warning_amber_outlined,
                onPressed: () => _note(context, o),
              ),
            ],
            const SizedBox(height: 14),
            const Text(
              'Cambios temporales: se comparten entre perfiles y desaparecen al cerrar la aplicación.',
              style: TextStyle(fontSize: 11, color: muted),
            ),
          ],
        ),
      );
    },
  );

  Future<void> _note(BuildContext context, DemoOrder order) async {
    final c = TextEditingController();
    final note = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Entrega incompleta'),
        content: TextField(
          controller: c,
          maxLines: 3,
          decoration: const InputDecoration(labelText: 'Motivo u observación'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              if (c.text.trim().isEmpty) {
                feedback(ctx, 'Escribe una observación.', error: true);
                return;
              }
              Navigator.pop(ctx, c.text.trim());
            },
            child: const Text('Registrar'),
          ),
        ],
      ),
    );
    c.dispose();
    if (note != null && context.mounted) {
      DemoStore.instance.recordDelivery(order, 'Entrega incompleta', note);
      feedback(context, 'Incidencia registrada.');
    }
  }
}

class DeliveryListScreen extends StatelessWidget {
  const DeliveryListScreen({super.key});
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: DemoStore.instance,
    builder: (context, _) {
      final orders = DemoStore.instance.visibleOrders;
      return Scaffold(
        appBar: AppBar(title: const Text('Entregas asignadas')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Heading(
              'Mis entregas',
              'Selecciona un pedido para registrar el resultado.',
            ),
            const SizedBox(height: 12),
            if (orders.isEmpty)
              const Text('No hay entregas asignadas.')
            else
              ...orders.map(
                (o) => OrderTile(
                  order: o,
                  showCustomer: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderDetailScreen(orderId: o.id),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    },
  );
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final u = DemoStore.instance.user!;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Heading('Mi perfil', 'Datos de la sesión de demostración.'),
        const SizedBox(height: 25),
        const CircleAvatar(
          radius: 42,
          child: Icon(Icons.person_outline, size: 44),
        ),
        const SizedBox(height: 12),
        Text(
          u.name,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        Text(
          u.email,
          textAlign: TextAlign.center,
          style: const TextStyle(color: muted, fontSize: 12),
        ),
        const SizedBox(height: 20),
        Card(
          color: Colors.white,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.badge_outlined),
                title: const Text('Perfil'),
                subtitle: Text(u.role.label),
              ),
              ListTile(
                leading: const Icon(Icons.phone_outlined),
                title: const Text('Teléfono'),
                subtitle: Text(u.phone),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class StaffDashboard extends StatelessWidget {
  const StaffDashboard({super.key});
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: DemoStore.instance,
    builder: (context, _) => ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Heading(
          'Panel del expendio',
          'Resumen de la operación de demostración.',
        ),
        const SizedBox(height: 14),
        _metric(
          'Pedidos',
          '${DemoStore.instance.orders.length}',
          Icons.receipt_long,
        ),
        _metric(
          'Pendientes',
          '${DemoStore.instance.orders.where((o) => o.status == OrderStatus.pending).length}',
          Icons.pending_actions,
        ),
        const SizedBox(height: 10),
        const Text(
          'Usa la sección Pedidos para revisar y actualizar solicitudes.',
        ),
      ],
    ),
  );
}

class CourierDashboard extends StatelessWidget {
  const CourierDashboard({super.key});
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: DemoStore.instance,
    builder: (context, _) {
      final orders = DemoStore.instance.visibleOrders;
      return ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Heading(
            'Panel del repartidor',
            'Entregas asignadas al usuario actual.',
          ),
          const SizedBox(height: 14),
          _metric(
            'Entregas asignadas',
            '${orders.length}',
            Icons.local_shipping_outlined,
          ),
          _metric(
            'Pendientes',
            '${orders.where((o) => o.status != OrderStatus.delivered && o.status != OrderStatus.incomplete).length}',
            Icons.pending_actions,
          ),
        ],
      );
    },
  );
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: DemoStore.instance,
    builder: (context, _) {
      final s = DemoStore.instance;
      return ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Heading(
            'Panel administrativo',
            'Resumen general de PedidoLocal.',
          ),
          const SizedBox(height: 12),
          _metric(
            'Usuarios de prueba',
            '${s.users.length}',
            Icons.people_outline,
          ),
          _metric(
            'Productos',
            '${s.products.length}',
            Icons.inventory_2_outlined,
          ),
          _metric('Pedidos', '${s.orders.length}', Icons.receipt_long_outlined),
          const SizedBox(height: 14),
          const Text(
            'PEDIDOS RECIENTES',
            style: TextStyle(fontWeight: FontWeight.w800, color: muted),
          ),
          ...s.orders
              .take(4)
              .map(
                (o) => OrderTile(
                  order: o,
                  showCustomer: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderDetailScreen(orderId: o.id),
                    ),
                  ),
                ),
              ),
        ],
      );
    },
  );
}

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      const Heading(
        'Usuarios de prueba',
        'Las cuentas son fijas y no se crean desde el registro.',
      ),
      const SizedBox(height: 12),
      ...DemoStore.instance.users.map(
        (u) => Card(
          color: Colors.white,
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person_outline)),
            title: Text(u.name),
            subtitle: Text('${u.email}\n${u.role.label}'),
            isThreeLine: true,
          ),
        ),
      ),
    ],
  );
}

Widget _metric(String title, String value, IconData icon) => Card(
  color: Colors.white,
  elevation: 0,
  child: ListTile(
    leading: Icon(icon, color: blue, size: 28),
    title: Text(title, style: const TextStyle(fontSize: 12, color: muted)),
    trailing: Text(
      value,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
    ),
  ),
);

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  final VoidCallback onTap;
  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white,
    elevation: 0,
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFEAF2FB),
        child: Icon(icon, color: blue),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    ),
  );
}
