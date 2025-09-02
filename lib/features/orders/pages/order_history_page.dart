import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
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
        appBar: AppBar(
          title: Text(widget.customerId != null
              ? 'Pedidos del Cliente'
              : 'Historial de Pedidos'),
          actions: [
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: _showFilterDialog,
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: _showSearchDialog,
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: 'Todos', icon: Icon(Icons.list)),
              Tab(text: 'Pendientes', icon: Icon(Icons.pending)),
              Tab(text: 'Completados', icon: Icon(Icons.check_circle)),
            ],
          ),
        ),
        body: BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            return TabBarView(
              controller: _tabController,
              children: [
                _buildOrdersList(null), // All orders
                _buildOrdersList(OrderStatus.sent), // Pending orders
                _buildOrdersList(OrderStatus.delivered), // Completed orders
              ],
            );
          },
        ),
        floatingActionButton: widget.customerId != null
            ? FloatingActionButton(
                onPressed: () =>
                    context.push('/orders/cart/${widget.customerId}'),
                child: const Icon(Icons.add_shopping_cart),
              )
            : null,
      );

  Widget _buildOrdersList(OrderStatus? filterStatus) {
    // Mock data for demonstration
    final orders = _getMockOrders()
        .where((order) => filterStatus == null || order.status == filterStatus)
        .toList();

    if (orders.isEmpty) {
      return _buildEmptyState(filterStatus);
    }

    return RefreshIndicator(
      onRefresh: () async => _loadOrders(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
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

    switch (filterStatus) {
      case OrderStatus.sent:
        message = 'No hay pedidos pendientes';
        icon = Icons.pending_actions;
        break;
      case OrderStatus.delivered:
        message = 'No hay pedidos completados';
        icon = Icons.check_circle_outline;
        break;
      default:
        message = 'No hay pedidos registrados';
        icon = Icons.shopping_cart_outlined;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 80,
            color: AppPalette.textSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              color: AppPalette.textSecondary,
            ),
          ),
          if (widget.customerId != null) ...[
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () =>
                  context.push('/orders/cart/${widget.customerId}'),
              icon: const Icon(Icons.add),
              label: const Text('Crear Primer Pedido'),
            ),
          ],
        ],
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
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
        title: const Text('Buscar Pedidos'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Buscar por cliente, número de pedido...',
            prefixIcon: Icon(Icons.search),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _performSearch();
            },
            child: const Text('Buscar'),
          ),
        ],
      ),
    );
  }

  void _applyFilters() {
    // TODO: Apply filters to order list
    _loadOrders();
  }

  void _performSearch() {
    // TODO: Perform search
    _loadOrders();
  }

  void _showOrderDetails(Order order) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => OrderDetailsSheet(order: order),
    );
  }

  void _updateOrderStatus(Order order, OrderStatus newStatus) {
    // TODO: Update order status
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Estado del pedido actualizado a ${_getStatusDisplayName(newStatus)}'),
        backgroundColor: AppPalette.success,
      ),
    );
  }

  List<Order> _getMockOrders() => [
        Order(
          id: '00000000-0000-0000-0000-000000000001',
          companyId: '705abd4b-c5a7-4a6b-be9c-e2da93df3987',
          customerId: '00000000-0000-0000-0000-000000000002',
          status: OrderStatus.sent,
          subtotal: 2500.0,
          grandTotal: 2875.0,
          createdAt: DateTime.now().subtract(const Duration(hours: 2)),
          items: [
            OrderItem(
              id: '00000000-0000-0000-0000-000000000003',
              orderId: '00000000-0000-0000-0000-000000000001',
              productId: '00000000-0000-0000-0000-000000000004',
              qty: 2,
              price: 1000.0,
              total: 2000.0,
            ),
            OrderItem(
              id: '00000000-0000-0000-0000-000000000005',
              orderId: '00000000-0000-0000-0000-000000000001',
              productId: '00000000-0000-0000-0000-000000000006',
              qty: 1,
              price: 500.0,
              total: 500.0,
            ),
          ],
        ),
        Order(
          id: '00000000-0000-0000-0000-000000000007',
          companyId: '705abd4b-c5a7-4a6b-be9c-e2da93df3987',
          customerId: '00000000-0000-0000-0000-000000000008',
          status: OrderStatus.delivered,
          subtotal: 1800.0,
          grandTotal: 2070.0,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          items: [
            OrderItem(
              id: '00000000-0000-0000-0000-000000000009',
              orderId: '00000000-0000-0000-0000-000000000007',
              productId: '00000000-0000-0000-0000-000000000010',
              qty: 3,
              price: 600.0,
              total: 1800.0,
            ),
          ],
        ),
        Order(
          id: '00000000-0000-0000-0000-000000000011',
          companyId: '705abd4b-c5a7-4a6b-be9c-e2da93df3987',
          customerId: '00000000-0000-0000-0000-000000000002',
          status: OrderStatus.draft,
          subtotal: 750.0,
          grandTotal: 862.5,
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          items: [
            OrderItem(
              id: '00000000-0000-0000-0000-000000000012',
              orderId: '00000000-0000-0000-0000-000000000011',
              productId: '00000000-0000-0000-0000-000000000013',
              qty: 1,
              price: 750.0,
              total: 750.0,
            ),
          ],
        ),
      ];

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
                        color: _getStatusColor(order.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _getStatusDisplayName(order.status),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getStatusColor(order.status),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      'Pedido #${order.id}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppPalette.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Customer info
                Row(
                  children: [
                    const Icon(Icons.business,
                        size: 16, color: AppPalette.textSecondary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Cliente ${order.customerId}', // Would show customer name
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Order details
                Row(
                  children: [
                    const Icon(Icons.inventory,
                        size: 16, color: AppPalette.textSecondary),
                    const SizedBox(width: 8),
                    Text(
                      '${order.items.length} productos',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppPalette.textSecondary,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.schedule,
                        size: 16, color: AppPalette.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(order.createdAt),
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppPalette.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Total and actions
                Row(
                  children: [
                    Text(
                      '\$${order.grandTotal.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.primary,
                      ),
                    ),
                    const Spacer(),
                    if (order.status == OrderStatus.sent) ...[
                      IconButton(
                        onPressed: () => onStatusChanged(OrderStatus.approved),
                        icon: const Icon(Icons.check_circle,
                            color: AppPalette.success),
                        tooltip: 'Aprobar',
                      ),
                      IconButton(
                        onPressed: () => onStatusChanged(OrderStatus.rejected),
                        icon: const Icon(Icons.cancel, color: AppPalette.error),
                        tooltip: 'Rechazar',
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.draft:
        return AppPalette.textSecondary;
      case OrderStatus.sent:
        return AppPalette.warning;
      case OrderStatus.approved:
        return AppPalette.info;
      case OrderStatus.rejected:
        return AppPalette.error;
      case OrderStatus.delivered:
        return AppPalette.success;
      case OrderStatus.cancelled:
        return AppPalette.textDisabled;
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

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day}/${date.month}/${date.year}';
  }
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
              value: _selectedStatus,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Seleccionar estado',
              ),
              items: OrderStatus.values.map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(_getStatusDisplayName(status)),
                );
              }).toList(),
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
          ...order.items.map((item) => _buildItemRow(item)),
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
