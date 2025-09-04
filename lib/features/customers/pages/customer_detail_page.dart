import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/palette.dart';
import '../../../data/models/customers/customer.dart';
import '../../../data/models/visits/visit.dart';
import '../bloc/customers_cubit.dart';
import '../../visits/bloc/visits_cubit.dart';

class CustomerDetailPage extends StatefulWidget {
  const CustomerDetailPage({
    super.key,
    required this.customerId,
  });
  final String customerId;

  @override
  State<CustomerDetailPage> createState() => _CustomerDetailPageState();
}

class _CustomerDetailPageState extends State<CustomerDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Customer? _customer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadCustomer();
    _loadVisitHistory();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadCustomer() {
    // Load customer details from the customers list
    final customersState = context.read<CustomersCubit>().state;
    if (customersState is CustomersLoaded) {
      try {
        _customer = customersState.customers.firstWhere(
          (customer) => customer.id == widget.customerId,
        );
        setState(() {});
      } catch (e) {
        // If customer not found, show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cliente no encontrado: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // If customers are not loaded yet, load them first
      context.read<CustomersCubit>().loadCustomers();
    }
  }

  void _loadVisitHistory() {
    context.read<VisitsCubit>().loadVisitHistory(widget.customerId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomersCubit, CustomersState>(
      listener: (context, state) {
        if (state is CustomersLoaded && _customer == null) {
          _loadCustomer();
        }
      },
      child: _customer == null
          ? const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            )
          : Scaffold(
              appBar: AppBar(
                title: Text(_customer!.name),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () =>
                        context.push('/customers/edit/${widget.customerId}'),
                  ),
                ],
                bottom: TabBar(
                  controller: _tabController,
                  tabs: const [
                    Tab(text: 'Info', icon: Icon(Icons.info)),
                    Tab(text: 'Visitas', icon: Icon(Icons.location_on)),
                    Tab(text: 'Pedidos', icon: Icon(Icons.shopping_cart)),
                  ],
                ),
              ),
              body: TabBarView(
                controller: _tabController,
                children: [
                  _buildInfoTab(),
                  _buildVisitsTab(),
                  _buildOrdersTab(),
                ],
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () => _showVisitOptions(context),
                icon: const Icon(Icons.add_location),
                label: const Text('Nueva Visita'),
              ),
            ),
    );
  }

  Widget _buildInfoTab() => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact info card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Información de Contacto',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_customer!.email != null) ...[
                      _buildInfoRow(
                        Icons.email,
                        'Email',
                        _customer!.email!,
                        onTap: () => _launchEmail(_customer!.email!),
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (_customer!.phone != null) ...[
                      _buildInfoRow(
                        Icons.phone,
                        'Teléfono',
                        _customer!.phone!,
                        onTap: () => _launchPhone(_customer!.phone!),
                      ),
                      const SizedBox(height: 12),
                    ],
                    if (_customer!.address != null) ...[
                      _buildInfoRow(
                        Icons.location_on,
                        'Dirección',
                        _customer!.address!,
                        onTap: _launchMaps,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Stats card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Estadísticas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppPalette.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatItem(
                              'Visitas', '15', Icons.location_on),
                        ),
                        Expanded(
                          child: _buildStatItem(
                              'Pedidos', '8', Icons.shopping_cart),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildStatItem(
                              'Última Visita', '2 días', Icons.schedule),
                        ),
                        Expanded(
                          child: _buildStatItem(
                              'Total Ventas', r'$2,450', Icons.attach_money),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildVisitsTab() => BlocBuilder<VisitsCubit, VisitsState>(
        builder: (context, state) => state.when(
          initial: () => const Center(child: Text('Cargando...')),
          loading: () => const Center(child: CircularProgressIndicator()),
          activeVisit: (visit) => const Center(child: Text('Visita activa')),
          completed: (visit) => const Center(child: Text('Visita completada')),
          history: (visits) {
            if (visits.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.location_off,
                      size: 64,
                      color: AppPalette.textSecondary,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No hay visitas registradas',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppPalette.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () =>
                          context.go('/visit/history/${widget.customerId}'),
                      icon: const Icon(Icons.history),
                      label: const Text('Ver Historial Completo'),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                // Header with view all button
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Últimas ${visits.length} visitas',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () =>
                            context.go('/visit/history/${widget.customerId}'),
                        icon: const Icon(Icons.history),
                        label: const Text('Ver Todas'),
                      ),
                    ],
                  ),
                ),
                // Visits list
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: visits.length,
                    itemBuilder: (context, index) {
                      final visit = visits[index];
                      return VisitListTile(visit: visit);
                    },
                  ),
                ),
              ],
            );
          },
          error: (message) => Center(child: Text('Error: $message')),
        ),
      );

  Widget _buildOrdersTab() => const Center(
        child: Text('Historial de pedidos - TODO'),
      );

  Widget _buildInfoRow(IconData icon, String label, String value,
          {VoidCallback? onTap}) =>
      InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Icon(icon, size: 20, color: AppPalette.primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppPalette.textSecondary,
                      ),
                    ),
                    Text(
                      value,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                const Icon(Icons.chevron_right,
                    color: AppPalette.textSecondary),
            ],
          ),
        ),
      );

  Widget _buildStatItem(String label, String value, IconData icon) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppPalette.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppPalette.primary, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppPalette.primary,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: AppPalette.textSecondary,
              ),
            ),
          ],
        ),
      );

  void _showVisitOptions(BuildContext context) {
    // Verificar si ya hay una visita activa
    final visitsState = context.read<VisitsCubit>().state;
    if (visitsState is VisitsActiveVisit) {
      _showActiveVisitDialog(context);
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) => VisitOptionsSheet(customer: _customer!),
    );
  }

  void _showActiveVisitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.warning, color: Colors.orange),
            const SizedBox(width: 8),
            const Text('Visita Activa'),
          ],
        ),
        content: const Text(
          'Ya tienes una visita en progreso. Debes finalizar la visita actual antes de iniciar una nueva.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Entendido'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Navegar a la visita activa
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Redirigiendo a la visita activa...'),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPalette.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Ir a Visita Activa'),
          ),
        ],
      ),
    );
  }

  Future<void> _launchEmail(String email) async {
    final uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchPhone(String phone) async {
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchMaps() async {
    if (_customer!.latitude != null && _customer!.longitude != null) {
      final uri = Uri.parse(
          'https://www.google.com/maps/search/?api=1&query=${_customer!.latitude},${_customer!.longitude}');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  }
}

class VisitListTile extends StatelessWidget {
  const VisitListTile({super.key, required this.visit});
  final Visit visit;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _getPurposeColor(visit.purpose),
            child: Icon(
              _getPurposeIcon(visit.purpose),
              color: Colors.white,
              size: 20,
            ),
          ),
          title: Text(_getPurposeLabel(visit.purpose)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (visit.startedAt != null)
                Text('Inicio: ${_formatDateTime(visit.startedAt!)}'),
              if (visit.finishedAt != null)
                Text('Fin: ${_formatDateTime(visit.finishedAt!)}'),
              if (visit.notes?.isNotEmpty == true)
                Text('Notas: ${visit.notes}'),
            ],
          ),
          trailing: Icon(
            visit.finishedAt != null ? Icons.check_circle : Icons.schedule,
            color: visit.finishedAt != null
                ? AppPalette.success
                : AppPalette.warning,
          ),
        ),
      );

  Color _getPurposeColor(VisitPurpose purpose) {
    switch (purpose) {
      case VisitPurpose.venta:
        return AppPalette.success;
      case VisitPurpose.cobro:
        return AppPalette.warning;
      case VisitPurpose.entrega:
        return AppPalette.info;
      case VisitPurpose.auditoria:
        return AppPalette.primary;
      case VisitPurpose.devolucion:
        return AppPalette.error;
      default:
        return AppPalette.textSecondary;
    }
  }

  IconData _getPurposeIcon(VisitPurpose purpose) {
    switch (purpose) {
      case VisitPurpose.venta:
        return Icons.shopping_cart;
      case VisitPurpose.cobro:
        return Icons.payment;
      case VisitPurpose.entrega:
        return Icons.local_shipping;
      case VisitPurpose.auditoria:
        return Icons.assignment;
      case VisitPurpose.devolucion:
        return Icons.keyboard_return;
      default:
        return Icons.location_on;
    }
  }

  String _getPurposeLabel(VisitPurpose purpose) {
    switch (purpose) {
      case VisitPurpose.venta:
        return 'Venta';
      case VisitPurpose.cobro:
        return 'Cobro';
      case VisitPurpose.entrega:
        return 'Entrega';
      case VisitPurpose.visita:
        return 'Visita General';
      case VisitPurpose.auditoria:
        return 'Auditoría';
      case VisitPurpose.devolucion:
        return 'Devolución';
      case VisitPurpose.otro:
        return 'Otro';
    }
  }

  String _formatDateTime(DateTime dateTime) =>
      '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
}

class VisitOptionsSheet extends StatelessWidget {
  const VisitOptionsSheet({super.key, required this.customer});
  final Customer customer;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Seleccionar tipo de visita',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: [
                _VisitOptionTile(
                  icon: Icons.visibility,
                  label: 'Visita General',
                  color: AppPalette.info,
                  onTap: () => _startVisit(context, VisitPurpose.visita),
                ),
                _VisitOptionTile(
                  icon: Icons.shopping_cart,
                  label: 'Venta',
                  color: AppPalette.success,
                  onTap: () => _startVisit(context, VisitPurpose.venta),
                ),
                _VisitOptionTile(
                  icon: Icons.payment,
                  label: 'Cobro',
                  color: AppPalette.warning,
                  onTap: () => _startVisit(context, VisitPurpose.cobro),
                ),
                _VisitOptionTile(
                  icon: Icons.local_shipping,
                  label: 'Entrega',
                  color: AppPalette.primary,
                  onTap: () => _startVisit(context, VisitPurpose.entrega),
                ),
              ],
            ),
          ],
        ),
      );

  void _startVisit(BuildContext context, VisitPurpose purpose) {
    Navigator.of(context).pop();
    context.push('/visit/checkin/${customer.id}?purpose=${purpose.name}');
  }
}

class _VisitOptionTile extends StatelessWidget {
  const _VisitOptionTile({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: color),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
}
