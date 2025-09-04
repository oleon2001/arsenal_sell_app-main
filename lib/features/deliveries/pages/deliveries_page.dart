import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
import '../../../data/models/sales/order.dart';
import '../bloc/deliveries_cubit.dart';

class DeliveriesPage extends StatefulWidget {
  const DeliveriesPage({super.key});

  @override
  State<DeliveriesPage> createState() => _DeliveriesPageState();
}

class _DeliveriesPageState extends State<DeliveriesPage> {
  @override
  void initState() {
    super.initState();
    context.read<DeliveriesCubit>().loadDeliveries();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Entregas'),
          actions: [
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: () => context
                  .read<DeliveriesCubit>()
                  .loadDeliveries(forceSync: true),
            ),
          ],
        ),
        body: BlocBuilder<DeliveriesCubit, DeliveriesState>(
          builder: (context, state) {
            if (state.runtimeType.toString() == '_Initial') {
              return const Center(child: Text('Cargando entregas...'));
            } else if (state.runtimeType.toString() == '_Loading') {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DeliveriesLoaded) {
              final deliveries = state.deliveries;
              if (deliveries.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.local_shipping_outlined,
                        size: 64,
                        color: AppPalette.textSecondary,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No hay entregas pendientes',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppPalette.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return RefreshIndicator(
                onRefresh: () => context
                    .read<DeliveriesCubit>()
                    .loadDeliveries(forceSync: true),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: deliveries.length,
                  itemBuilder: (context, index) {
                    final delivery = deliveries[index];
                    return DeliveryCard(
                      delivery: delivery,
                      onTap: () => _showDeliveryDetails(delivery),
                    );
                  },
                ),
              );
            } else if (state.runtimeType.toString() == '_Error') {
              final message = (state as dynamic).message;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppPalette.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<DeliveriesCubit>().loadDeliveries(),
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      );

  void _showDeliveryDetails(delivery) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DeliveryDetailsSheet(delivery: delivery),
    );
  }
}

class DeliveryCard extends StatelessWidget {
  const DeliveryCard({
    super.key,
    required this.delivery,
    required this.onTap,
  });
  final dynamic delivery;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor('PENDING').withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'PENDIENTE',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor('PENDING'),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Pedido #12345',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppPalette.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Customer info
                const Row(
                  children: [
                    Icon(
                      Icons.business,
                      size: 16,
                      color: AppPalette.textSecondary,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Tienda Ejemplo',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Address
                const Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppPalette.textSecondary,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Calle Ejemplo 123, Colonia, Ciudad',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppPalette.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Footer with amount and items
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppPalette.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '5 productos',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppPalette.primary,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      r'$1,250.00',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Color _getStatusColor(String status) {
    switch (status) {
      case 'PENDING':
        return AppPalette.warning;
      case 'PARTIAL':
        return AppPalette.info;
      case 'DELIVERED':
        return AppPalette.success;
      case 'REJECTED':
        return AppPalette.error;
      default:
        return AppPalette.textSecondary;
    }
  }
}

class DeliveryDetailsSheet extends StatelessWidget {
  const DeliveryDetailsSheet({
    super.key,
    required this.delivery,
  });
  final dynamic delivery;

  @override
  Widget build(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Detalles de Entrega',
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

            // Delivery info
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoSection('Cliente', [
                      _buildInfoRow('Nombre', 'Tienda Ejemplo'),
                      _buildInfoRow(
                          'Dirección', 'Calle Ejemplo 123, Colonia, Ciudad'),
                      _buildInfoRow('Teléfono', '+52 55 1234 5678'),
                    ]),
                    _buildInfoSection('Pedido', [
                      _buildInfoRow('Número', '#12345'),
                      _buildInfoRow('Fecha', '07/08/2025'),
                      _buildInfoRow('Total', r'$1,250.00'),
                    ]),
                    _buildInfoSection('Productos', [
                      _buildProductRow('Producto A', 2, r'$500.00'),
                      _buildProductRow('Producto B', 1, r'$300.00'),
                      _buildProductRow('Producto C', 3, r'$450.00'),
                    ]),
                  ],
                ),
              ),
            ),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _confirmDelivery(context, false),
                    icon: const Icon(Icons.close),
                    label: const Text('Rechazar'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppPalette.error,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _confirmDelivery(context, true),
                    icon: const Icon(Icons.check),
                    label: const Text('Entregar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPalette.success,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildInfoSection(String title, List<Widget> children) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppPalette.primary,
            ),
          ),
          const SizedBox(height: 8),
          ...children,
          const SizedBox(height: 20),
        ],
      );

  Widget _buildInfoRow(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            SizedBox(
              width: 80,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppPalette.textSecondary,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );

  Widget _buildProductRow(String name, int qty, String total) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Text(
              'x$qty',
              style: const TextStyle(
                fontSize: 14,
                color: AppPalette.textSecondary,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              total,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );

  void _confirmDelivery(BuildContext context, bool delivered) {
    Navigator.of(context).pop();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(delivered ? 'Confirmar Entrega' : 'Rechazar Entrega'),
        content: Text(delivered
            ? '¿Confirmas que se entregaron todos los productos?'
            : '¿Estás seguro de rechazar esta entrega?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement delivery confirmation
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  delivered ? AppPalette.success : AppPalette.error,
            ),
            child: Text(delivered ? 'Confirmar' : 'Rechazar'),
          ),
        ],
      ),
    );
  }
}
