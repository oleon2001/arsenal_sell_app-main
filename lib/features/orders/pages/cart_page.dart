import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
import '../../../data/models/sales/order.dart';
import '../bloc/order_cubit.dart';

class CartPage extends StatelessWidget {
  const CartPage({
    super.key,
    required this.customerId,
  });
  final String customerId;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Carrito de Compras'),
          actions: [
            BlocBuilder<OrderCubit, OrderState>(
              builder: (context, state) {
                return TextButton(
                  onPressed: state.maybeWhen(
                    editing: (order) => order.items.isNotEmpty
                        ? () => _saveOrder(context)
                        : null,
                    orElse: () => null,
                  ),
                  child: const Text(
                    'Guardar',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<OrderCubit, OrderState>(
          listener: (context, state) {
            state.whenOrNull(
              saved: (order) {
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pedido guardado exitosamente'),
                    backgroundColor: AppPalette.success,
                  ),
                );
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: AppPalette.error,
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            return state.when(
              initial: () {
                // Auto-create new order
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<OrderCubit>().createNewOrder(customerId);
                });
                return const Center(child: CircularProgressIndicator());
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              editing: (order) => _buildCartContent(context, order),
              saving: () => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Guardando pedido...'),
                  ],
                ),
              ),
              saved: (order) => _buildOrderSaved(context, order),
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppPalette.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            return state.maybeWhen(
              editing: (order) => FloatingActionButton(
                onPressed: () => _showProductSelector(context),
                child: const Icon(Icons.add),
              ),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      );

  Widget _buildCartContent(BuildContext context, Order order) {
    if (order.items.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: AppPalette.textSecondary,
            ),
            SizedBox(height: 16),
            Text(
              'Carrito vacío',
              style: TextStyle(
                fontSize: 18,
                color: AppPalette.textSecondary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Agrega productos usando el botón +',
              style: TextStyle(
                fontSize: 14,
                color: AppPalette.textDisabled,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Items list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: order.items.length,
            itemBuilder: (context, index) {
              final item = order.items[index];
              return CartItemTile(
                item: item,
                onQuantityChanged: (newQty) {
                  context
                      .read<OrderCubit>()
                      .updateItemQuantity(item.id, newQty);
                },
                onRemove: () {
                  context.read<OrderCubit>().removeItem(item.id);
                },
              );
            },
          ),
        ),

        // Order summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildSummaryRow(
                  'Subtotal:', '\$${order.subtotal.toStringAsFixed(2)}'),
              if (order.discountTotal > 0) ...[
                const SizedBox(height: 4),
                _buildSummaryRow('Descuento:',
                    '-\$${order.discountTotal.toStringAsFixed(2)}'),
              ],
              if (order.taxTotal > 0) ...[
                const SizedBox(height: 4),
                _buildSummaryRow(
                    'Impuestos:', '\$${order.taxTotal.toStringAsFixed(2)}'),
              ],
              const Divider(),
              _buildSummaryRow(
                'Total:',
                '\$${order.grandTotal.toStringAsFixed(2)}',
                isTotal: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppPalette.primary : null,
            ),
          ),
        ],
      );

  Widget _buildOrderSaved(BuildContext context, Order order) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              size: 80,
              color: AppPalette.success,
            ),
            const SizedBox(height: 16),
            const Text(
              'Pedido Guardado',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Total: \$${order.grandTotal.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                color: AppPalette.primary,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Volver al Inicio'),
            ),
          ],
        ),
      );

  void _showProductSelector(BuildContext context) {
    // TODO: Implement product selector
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => const ProductSelectorSheet(),
    );
  }

  void _saveOrder(BuildContext context) {
    context.read<OrderCubit>().saveOrder();
  }
}

class CartItemTile extends StatelessWidget {
  const CartItemTile({
    super.key,
    required this.item,
    required this.onQuantityChanged,
    required this.onRemove,
  });
  final OrderItem item;
  final Function(double) onQuantityChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Product info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product?.name ?? 'Producto',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Precio: \$${item.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppPalette.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),

              // Quantity controls
              Row(
                children: [
                  IconButton(
                    onPressed: item.qty > 1
                        ? () => onQuantityChanged(item.qty - 1)
                        : null,
                    icon: const Icon(Icons.remove_circle_outline),
                    color: AppPalette.error,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.qty.toStringAsFixed(0),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  IconButton(
                    onPressed: () => onQuantityChanged(item.qty + 1),
                    icon: const Icon(Icons.add_circle_outline),
                    color: AppPalette.success,
                  ),
                ],
              ),

              // Total and remove
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${item.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    onPressed: onRemove,
                    icon: const Icon(Icons.delete_outline),
                    color: AppPalette.error,
                    iconSize: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

class ProductSelectorSheet extends StatelessWidget {
  const ProductSelectorSheet({super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Seleccionar Producto',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(),

            // Search
            TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar productos...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                // TODO: Implement product search
              },
            ),
            const SizedBox(height: 16),

            // Products list
            Expanded(
              child: ListView.builder(
                itemCount: 10, // TODO: Use real products
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Producto $index'),
                    subtitle: Text('\$${(index + 1) * 10}.00'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // TODO: Add product to cart
                        Navigator.of(context).pop();
                      },
                      child: const Text('Agregar'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
}
