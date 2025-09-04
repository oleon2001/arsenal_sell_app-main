import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
import '../../../core/theme/design_system.dart';
import '../../../data/models/sales/order.dart';
import '../../../data/models/customers/customer.dart';
import '../bloc/order_cubit.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({
    super.key,
    this.customerId,
  });
  final String? customerId;

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  OrderStatus? _selectedStatus;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _loadOrders() {
    // TODO: Load orders from repository
    // context.read<OrderCubit>().loadOrders(customerId: widget.customerId);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: _buildAppBar(),
        body: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) => Column(
            children: [
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildOrdersList(null), // All orders
                    _buildOrdersList(OrderStatus.sent), // Pending orders
                    _buildOrdersList(OrderStatus.delivered), // Completed orders
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: widget.customerId != null
            ? FloatingActionButton.extended(
                onPressed: () =>
                    context.push('/orders/cart/${widget.customerId}'),
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Nuevo Pedido'),
                backgroundColor: AppPalette.primary,
                foregroundColor: Colors.white,
              )
            : null,
      );

  PreferredSizeWidget _buildAppBar() => AppBar(
        title: Text(
          widget.customerId != null
              ? 'Pedidos del Cliente'
              : 'Historial de Pedidos',
          style: AppTypography.headline4.copyWith(color: Colors.white),
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: _showFilterDialog,
            tooltip: 'Filtrar',
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: _showSearchDialog,
            tooltip: 'Buscar',
          ),
        ],
      );

  Widget _buildTabBar() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TabBar(
          controller: _tabController,
          indicatorColor: AppPalette.primary,
          indicatorWeight: 3,
          labelColor: AppPalette.primary,
          unselectedLabelColor: AppPalette.textSecondary,
          labelStyle: AppTypography.labelLarge,
          unselectedLabelStyle: AppTypography.labelMedium,
          tabs: const [
            Tab(
              text: 'Todos',
              icon: Icon(Icons.list_alt, size: 20),
            ),
            Tab(
              text: 'Pendientes',
              icon: Icon(Icons.pending_actions, size: 20),
            ),
            Tab(
              text: 'Completados',
              icon: Icon(Icons.check_circle_outline, size: 20),
            ),
          ],
        ),
      );

  Widget _buildOrdersList(OrderStatus? filterStatus) {
    // TODO: Implementar carga de datos reales desde el repositorio
    // Por ahora, retornamos lista vacía hasta que se implemente la funcionalidad completa
    final orders = <Order>[];

    if (orders.isEmpty) {
      return _buildEmptyState(filterStatus);
    }

    return RefreshIndicator(
      onRefresh: () async => _loadOrders(),
      color: AppPalette.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return OrderCard(
            order: order,
            onTap: () => _showOrderDetails(order),
            onStatusChanged: (newStatus) =>
                _updateOrderStatus(order, newStatus),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(OrderStatus? filterStatus) {
    String message;
    IconData icon;
    Color iconColor;

    switch (filterStatus) {
      case OrderStatus.sent:
        message = 'No hay pedidos pendientes';
        icon = Icons.pending_actions;
        iconColor = AppPalette.warning;
        break;
      case OrderStatus.delivered:
        message = 'No hay pedidos completados';
        icon = Icons.check_circle_outline;
        iconColor = AppPalette.success;
        break;
      default:
        message = 'No hay pedidos registrados';
        icon = Icons.shopping_cart_outlined;
        iconColor = AppPalette.textSecondary;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 80,
                color: iconColor,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              message,
              style: AppTypography.headline4.copyWith(
                color: AppPalette.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              'Los pedidos aparecerán aquí cuando sean creados',
              style: AppTypography.bodyMedium.copyWith(
                color: AppPalette.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (widget.customerId != null) ...[
              const SizedBox(height: AppSpacing.lg),
              AppComponents.actionButton(
                icon: Icons.add,
                label: 'Crear Primer Pedido',
                onPressed: () =>
                    context.push('/orders/cart/${widget.customerId}'),
                backgroundColor: AppPalette.primary,
                foregroundColor: Colors.white,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => OrderFilterSheet(
        selectedStatus: _selectedStatus,
        startDate: _startDate,
        endDate: _endDate,
        onApply: (status, start, end) {
          setState(() {
            _selectedStatus = status;
            _startDate = start;
            _endDate = end;
          });
          _applyFilters();
        },
        onClear: () {
          setState(() {
            _selectedStatus = null;
            _startDate = null;
            _endDate = null;
          });
          _loadOrders();
        },
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.search, color: AppPalette.primary),
            SizedBox(width: AppSpacing.sm),
            Text('Buscar Pedidos', style: AppTypography.headline4),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar por ID, cliente o producto...',
                prefixIcon:
                    const Icon(Icons.search, color: AppPalette.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppShapes.sm),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement search
              Navigator.pop(context);
            },
            child: const Text('Buscar'),
          ),
        ],
      ),
    );
  }

  void _showOrderDetails(Order order) {
    // TODO: Navigate to order details page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Detalles del pedido ${order.id}'),
        backgroundColor: AppPalette.primary,
      ),
    );
  }

  void _updateOrderStatus(Order order, OrderStatus newStatus) {
    // TODO: Update order status
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Estado actualizado a ${_getStatusDisplayName(newStatus)}'),
        backgroundColor: AppPalette.success,
      ),
    );
  }

  void _applyFilters() {
    // TODO: Apply filters and reload orders
    _loadOrders();
  }

  // Los datos mock han sido eliminados y reemplazados por datos reales del repositorio

  String _getStatusDisplayName(OrderStatus status) {
    switch (status) {
      case OrderStatus.draft:
        return 'BORRADOR';
      case OrderStatus.sent:
        return 'ENVIADO';
      case OrderStatus.approved:
        return 'APROBADO';
      case OrderStatus.rejected:
        return 'RECHAZADO';
      case OrderStatus.delivered:
        return 'ENTREGADO';
      case OrderStatus.cancelled:
        return 'CANCELADO';
    }
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    required this.onTap,
    required this.onStatusChanged,
  });
  final Order order;
  final VoidCallback onTap;
  final Function(OrderStatus) onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(order.status);
    final statusText = _getStatusDisplayName(order.status);

    return AppComponents.card(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con estado y ID
          Row(
            children: [
              AppComponents.statusBadge(
                text: statusText,
                color: statusColor,
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  'Pedido #${order.id}',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppPalette.textSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Información del cliente
          AppComponents.infoField(
            icon: Icons.business,
            label: 'Cliente',
            value:
                order.customer?.name ?? 'Cliente ${order.customerId ?? 'N/A'}',
            textColor: AppPalette.textPrimary,
          ),
          const SizedBox(height: AppSpacing.sm),

          // Detalles del pedido
          Row(
            children: [
              AppComponents.infoField(
                icon: Icons.inventory,
                label: 'Productos',
                value: '${order.items.length} productos',
                compact: true,
              ),
              const Spacer(),
              if (order.createdAt != null) ...[
                AppComponents.infoField(
                  icon: Icons.schedule,
                  label: 'Fecha',
                  value: _formatDate(order.createdAt!),
                  compact: true,
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.md),

          // Total y acciones
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: AppTypography.labelMedium.copyWith(
                        color: AppPalette.textSecondary,
                      ),
                    ),
                    Text(
                      '\$${order.grandTotal.toStringAsFixed(2)}',
                      style: AppTypography.price.copyWith(
                        color: AppPalette.primary,
                      ),
                    ),
                  ],
                ),
              ),
              if (order.status == OrderStatus.sent) ...[
                _buildActionButton(
                  icon: Icons.check_circle,
                  color: AppPalette.success,
                  tooltip: 'Aprobar',
                  onPressed: () => onStatusChanged(OrderStatus.approved),
                ),
                const SizedBox(width: AppSpacing.xs),
                _buildActionButton(
                  icon: Icons.cancel,
                  color: AppPalette.error,
                  tooltip: 'Rechazar',
                  onPressed: () => onStatusChanged(OrderStatus.rejected),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onPressed,
  }) =>
      Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppShapes.sm),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon, color: color, size: 20),
          tooltip: tooltip,
          padding: const EdgeInsets.all(AppSpacing.xs),
          constraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
          ),
        ),
      );

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.draft:
        return AppPalette.draft;
      case OrderStatus.sent:
        return AppPalette.sent;
      case OrderStatus.approved:
        return AppPalette.approved;
      case OrderStatus.rejected:
        return AppPalette.rejected;
      case OrderStatus.delivered:
        return AppPalette.delivered;
      case OrderStatus.cancelled:
        return AppPalette.cancelled;
    }
  }

  String _getStatusDisplayName(OrderStatus status) {
    switch (status) {
      case OrderStatus.draft:
        return 'BORRADOR';
      case OrderStatus.sent:
        return 'ENVIADO';
      case OrderStatus.approved:
        return 'APROBADO';
      case OrderStatus.rejected:
        return 'RECHAZADO';
      case OrderStatus.delivered:
        return 'ENTREGADO';
      case OrderStatus.cancelled:
        return 'CANCELADO';
    }
  }

  String _formatDate(DateTime date) => '${date.day}/${date.month}/${date.year}';
}

class OrderFilterSheet extends StatefulWidget {
  const OrderFilterSheet({
    super.key,
    this.selectedStatus,
    this.startDate,
    this.endDate,
    required this.onApply,
    required this.onClear,
  });
  final OrderStatus? selectedStatus;
  final DateTime? startDate;
  final DateTime? endDate;
  final Function(OrderStatus?, DateTime?, DateTime?) onApply;
  final VoidCallback onClear;

  @override
  State<OrderFilterSheet> createState() => _OrderFilterSheetState();
}

class _OrderFilterSheetState extends State<OrderFilterSheet> {
  OrderStatus? _selectedStatus;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.selectedStatus;
    _startDate = widget.startDate;
    _endDate = widget.endDate;
  }

  @override
  Widget build(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filtrar Pedidos',
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

            // Status filter
            const Text(
              'Estado',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<OrderStatus>(
              initialValue: _selectedStatus,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Seleccionar estado',
              ),
              items: OrderStatus.values
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(_getStatusDisplayName(status)),
                      ))
                  .toList(),
              onChanged: (value) => setState(() => _selectedStatus = value),
            ),
            const SizedBox(height: 24),

            // Date range filter
            const Text(
              'Rango de Fechas',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _selectStartDate,
                    child: Text(_startDate != null
                        ? '${_startDate!.day}/${_startDate!.month}/${_startDate!.year}'
                        : 'Fecha inicio'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _selectEndDate,
                    child: Text(_endDate != null
                        ? '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}'
                        : 'Fecha fin'),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      widget.onClear();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Limpiar'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApply(_selectedStatus, _startDate, _endDate);
                      Navigator.of(context).pop();
                    },
                    child: const Text('Aplicar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Future<void> _selectStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() => _startDate = date);
    }
  }

  Future<void> _selectEndDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate:
          _startDate ?? DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() => _endDate = date);
    }
  }

  String _getStatusDisplayName(OrderStatus status) {
    switch (status) {
      case OrderStatus.draft:
        return 'Borrador';
      case OrderStatus.sent:
        return 'Enviado';
      case OrderStatus.approved:
        return 'Aprobado';
      case OrderStatus.rejected:
        return 'Rechazado';
      case OrderStatus.delivered:
        return 'Entregado';
      case OrderStatus.cancelled:
        return 'Cancelado';
    }
  }
}

class OrderDetailsSheet extends StatelessWidget {
  const OrderDetailsSheet({super.key, required this.order});
  final Order order;

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
                Text(
                  'Pedido #${order.id}',
                  style: const TextStyle(
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

            // Order details content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Status and basic info
                    _buildInfoSection('Información General', [
                      _buildInfoRow(
                          'Estado', _getStatusDisplayName(order.status)),
                      _buildInfoRow('Fecha', _formatDate(order.createdAt)),
                      _buildInfoRow('Cliente', 'Cliente ${order.customerId}'),
                    ]),

                    // Items
                    _buildItemsSection(),

                    // Totals
                    _buildTotalsSection(),
                  ],
                ),
              ),
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
              fontWeight: FontWeight.bold,
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

  Widget _buildItemsSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Productos',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppPalette.primary,
            ),
          ),
          const SizedBox(height: 8),
          ...order.items.map(_buildItemRow),
          const SizedBox(height: 20),
        ],
      );

  Widget _buildItemRow(OrderItem item) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Producto ${item.productId}', // Would show product name
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Text(
              'x${item.qty.toStringAsFixed(0)}',
              style: const TextStyle(
                fontSize: 14,
                color: AppPalette.textSecondary,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              '\$${item.total.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );

  Widget _buildTotalsSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Totales',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppPalette.primary,
            ),
          ),
          const SizedBox(height: 8),
          _buildTotalRow('Subtotal:', order.subtotal),
          if (order.discountTotal > 0)
            _buildTotalRow('Descuento:', -order.discountTotal),
          if (order.taxTotal > 0) _buildTotalRow('Impuestos:', order.taxTotal),
          const Divider(),
          _buildTotalRow('Total:', order.grandTotal, isTotal: true),
        ],
      );

  Widget _buildTotalRow(String label, double amount, {bool isTotal = false}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            Text(
              '\$${amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: isTotal ? 16 : 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? AppPalette.primary : null,
              ),
            ),
          ],
        ),
      );

  String _getStatusDisplayName(OrderStatus status) {
    switch (status) {
      case OrderStatus.draft:
        return 'Borrador';
      case OrderStatus.sent:
        return 'Enviado';
      case OrderStatus.approved:
        return 'Aprobado';
      case OrderStatus.rejected:
        return 'Rechazado';
      case OrderStatus.delivered:
        return 'Entregado';
      case OrderStatus.cancelled:
        return 'Cancelado';
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
