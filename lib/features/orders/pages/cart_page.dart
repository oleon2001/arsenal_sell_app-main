import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
import '../../../data/models/sales/order.dart';
import '../../../data/models/sales/product.dart';
import '../../../data/repositories/products_repository.dart';
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
              builder: (context, state) => TextButton(
                onPressed: state.maybeWhen(
                  editing: (order) =>
                      order.items.isNotEmpty ? () => _saveOrder(context) : null,
                  orElse: () => null,
                ),
                child: const Text(
                  'Guardar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
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
          builder: (context, state) => state.when(
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
          ),
        ),
        floatingActionButton: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) => state.maybeWhen(
            editing: (order) => FloatingActionButton(
              onPressed: () => _showProductSelector(context),
              child: const Icon(Icons.add),
            ),
            orElse: () => const SizedBox.shrink(),
          ),
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => ProductSelectorSheet(customerId: customerId),
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

class ProductSelectorSheet extends StatefulWidget {
  final String customerId;

  const ProductSelectorSheet({
    super.key,
    required this.customerId,
  });

  @override
  State<ProductSelectorSheet> createState() => _ProductSelectorSheetState();
}

class _ProductSelectorSheetState extends State<ProductSelectorSheet> {
  final ProductsRepository _productsRepository = ProductsRepository();
  final TextEditingController _searchController = TextEditingController();

  List<ProductWithPrice> _products = [];
  List<ProductWithPrice> _filteredProducts = [];
  bool _isLoading = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadProducts();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
      _filterProducts();
    });
  }

  void _filterProducts() {
    if (_searchQuery.isEmpty) {
      _filteredProducts = _products;
    } else {
      _filteredProducts = _products.where((product) {
        return product.product.name
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            (product.product.sku
                    ?.toLowerCase()
                    .contains(_searchQuery.toLowerCase()) ??
                false);
      }).toList();
    }
  }

  Future<void> _loadProducts() async {
    try {
      setState(() => _isLoading = true);
      final products = await _productsRepository.getProductsWithPrices();
      setState(() {
        _products = products;
        _filteredProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error cargando productos: $e')),
        );
      }
    }
  }

  void _addProductToCart(ProductWithPrice productWithPrice) {
    // TODO: Necesitamos obtener el Product desde ProductWithPrice
    // Por ahora, creamos un Product temporal usando el modelo de sales
    final product = Product(
      id: productWithPrice.product.id,
      name: productWithPrice.product.name,
      sku: productWithPrice.product.sku,
      tax: productWithPrice.product.tax ?? 0.0,
      active: productWithPrice.product.active,
      companyId: productWithPrice.product.companyId,
      createdAt: productWithPrice.product.createdAt,
    );

    context
        .read<OrderCubit>()
        .addItem(product, 1, productWithPrice.priceValue ?? 0.0);
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${productWithPrice.product.name} agregado al carrito'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Seleccionar Productos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Barra de búsqueda
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Buscar productos...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Lista de productos
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredProducts.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              size: 64,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              _searchQuery.isEmpty
                                  ? 'No hay productos disponibles'
                                  : 'No se encontraron productos',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          final productWithPrice = _filteredProducts[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(
                                productWithPrice.product.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (productWithPrice.product.unit != null)
                                    Text(
                                        'Unidad: ${productWithPrice.product.unit}'),
                                  Text(
                                    productWithPrice.formattedPrice,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () =>
                                    _addProductToCart(productWithPrice),
                                icon: const Icon(Icons.add_circle),
                                color: AppPalette.primary,
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
