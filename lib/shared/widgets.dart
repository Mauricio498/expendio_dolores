import 'package:flutter/material.dart';

import '../models/models.dart';

const blue = Color(0xFF07549A);
const ink = Color(0xFF182230);
const muted = Color(0xFF778292);
const border = Color(0xFFE4E8EE);

void feedback(BuildContext context, String text, {bool error = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        backgroundColor: error
            ? const Color(0xFFB3261E)
            : const Color(0xFF243447),
      ),
    );
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
  });
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: 48,
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon ?? Icons.arrow_forward, size: 18),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: blue,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}

class Heading extends StatelessWidget {
  final String title, subtitle;
  const Heading(this.title, this.subtitle, {super.key});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 23,
          fontWeight: FontWeight.w900,
          color: ink,
        ),
      ),
      const SizedBox(height: 5),
      Text(subtitle, style: const TextStyle(fontSize: 12, color: muted)),
    ],
  );
}

class StatusPill extends StatelessWidget {
  final OrderStatus status;
  const StatusPill(this.status, {super.key});
  @override
  Widget build(BuildContext context) {
    final c = switch (status) {
      OrderStatus.pending => const Color(0xFFB7791F),
      OrderStatus.confirmed || OrderStatus.preparing => const Color(0xFF1769AA),
      OrderStatus.inDelivery => const Color(0xFF7B56A5),
      OrderStatus.delivered => const Color(0xFF27804A),
      OrderStatus.incomplete => const Color(0xFFC47B22),
      OrderStatus.cancelled => const Color(0xFFC93434),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: c.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.label,
        style: TextStyle(color: c, fontSize: 10, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;
  const ProductTile({super.key, required this.product, required this.onAdd});
  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: border),
      borderRadius: BorderRadius.circular(14),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            color: product.color,
            width: double.infinity,
            child: Icon(product.icon, size: 55, color: const Color(0xFF7A6045)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
              Text(
                product.category,
                style: const TextStyle(color: muted, fontSize: 10),
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: blue,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: onAdd,
                    constraints: const BoxConstraints.tightFor(
                      width: 32,
                      height: 32,
                    ),
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.add_circle, color: blue),
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

class OrderTile extends StatelessWidget {
  final DemoOrder order;
  final bool showCustomer;
  final VoidCallback onTap;
  const OrderTile({
    super.key,
    required this.order,
    required this.onTap,
    this.showCustomer = false,
  });
  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: const BorderSide(color: border),
    ),
    child: InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    order.id,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                ),
                StatusPill(order.status),
              ],
            ),
            if (showCustomer) ...[
              const SizedBox(height: 7),
              Text(
                order.customerName,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: 6),
            Text(
              '${order.lines.length} productos · ${order.deliveryType}',
              style: const TextStyle(fontSize: 11, color: muted),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order.createdAt.day}/${order.createdAt.month} · ${order.createdAt.hour.toString().padLeft(2, '0')}:${order.createdAt.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 11, color: muted),
                ),
                Text(
                  '\$${order.total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: blue,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
