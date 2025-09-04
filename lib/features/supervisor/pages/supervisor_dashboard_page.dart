import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/theme/palette.dart';
import '../../../data/models/geo/location_sample.dart';
import '../../../data/models/visits/visit.dart';
import '../../../data/models/auth/user_profile.dart';
import '../bloc/supervisor_cubit.dart';

class SupervisorDashboardPage extends StatefulWidget {
  const SupervisorDashboardPage({super.key});

  @override
  State<SupervisorDashboardPage> createState() =>
      _SupervisorDashboardPageState();
}

class _SupervisorDashboardPageState extends State<SupervisorDashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<SupervisorCubit>().initializeDashboard();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Panel de Supervisor'),
          backgroundColor: AppPalette.supervisor,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => context.read<SupervisorCubit>().refreshData(),
            ),
            IconButton(
              icon: const Icon(Icons.message),
              onPressed: _showTeamMessageDialog,
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: 'Resumen', icon: Icon(Icons.dashboard)),
              Tab(text: 'Equipo', icon: Icon(Icons.people)),
              Tab(text: 'Reportes', icon: Icon(Icons.analytics)),
            ],
          ),
        ),
        body: BlocConsumer<SupervisorCubit, SupervisorState>(
          listener: (context, state) {
            state.whenOrNull(
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
          builder: (context, state) => TabBarView(
            controller: _tabController,
            children: [
              _buildOverviewTab(state),
              _buildTeamTab(state),
              _buildReportsTab(state),
            ],
          ),
        ),
      );

  Widget _buildOverviewTab(SupervisorState state) => state.when(
        initial: () => const Center(child: Text('Inicializando...')),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (teamLocations, todayStats, activeVisits, teamMembers,
                isRefreshing, isLoadingMember, selectedMemberDetails) =>
            RefreshIndicator(
          onRefresh: () => context.read<SupervisorCubit>().refreshData(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Stats Cards
                _buildStatsCards(todayStats),
                const SizedBox(height: 16),

                // Team Map
                _buildTeamMap(teamLocations),
                const SizedBox(height: 16),

                // Active Visits
                _buildActiveVisitsSection(activeVisits),
              ],
            ),
          ),
        ),
        loadingReport: () => const Center(child: CircularProgressIndicator()),
        reportLoaded: (report) =>
            const Center(child: Text('Error cargando datos')),
        error: (message) => const Center(child: Text('Error cargando datos')),
      );

  Widget _buildTeamTab(SupervisorState state) => state.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (teamLocations, todayStats, activeVisits, teamMembers,
                isRefreshing, isLoadingMember, selectedMemberDetails) =>
            Column(
          children: [
            // Team member list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: teamLocations.length,
                itemBuilder: (context, index) {
                  final location = teamLocations[index];
                  return TeamMemberCard(
                    location: location,
                    onTap: () => context
                        .read<SupervisorCubit>()
                        .loadTeamMember(location.userId),
                  );
                },
              ),
            ),

            // Member details panel
            if (selectedMemberDetails != null)
              _buildMemberDetailsPanel(selectedMemberDetails),
          ],
        ),
        loadingReport: () => const Center(child: CircularProgressIndicator()),
        reportLoaded: (report) =>
            const Center(child: CircularProgressIndicator()),
        error: (message) => const Center(child: CircularProgressIndicator()),
      );

  Widget _buildReportsTab(SupervisorState state) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Report period selector
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Generar Reporte',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () =>
                                _generateReport(ReportPeriod.today),
                            child: const Text('Hoy'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => _generateReport(ReportPeriod.week),
                            child: const Text('Esta Semana'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () =>
                                _generateReport(ReportPeriod.month),
                            child: const Text('Este Mes'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Report display
            Expanded(
              child: state.when(
                initial: () => const Center(
                  child: Text('Selecciona un período para generar el reporte'),
                ),
                loading: () => const Center(
                  child: Text('Selecciona un período para generar el reporte'),
                ),
                loaded: (teamLocations, todayStats, activeVisits, teamMembers,
                        isRefreshing, isLoadingMember, selectedMemberDetails) =>
                    const Center(
                  child: Text('Selecciona un período para generar el reporte'),
                ),
                reportLoaded: _buildReportView,
                loadingReport: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (message) => const Center(
                  child: Text('Selecciona un período para generar el reporte'),
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildStatsCards(SupervisorStats stats) => GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        children: [
          _buildStatCard(
            'Visitas Hoy',
            '${stats.completedVisits}/${stats.totalVisits}',
            Icons.location_on,
            AppPalette.primary,
          ),
          _buildStatCard(
            'Pedidos',
            '${stats.totalOrders}',
            Icons.shopping_cart,
            AppPalette.success,
          ),
          _buildStatCard(
            'Ventas',
            '\$${stats.totalSales.toStringAsFixed(0)}',
            Icons.attach_money,
            AppPalette.warning,
          ),
          _buildStatCard(
            'Equipo Activo',
            '${stats.teamMembersActive}',
            Icons.people,
            AppPalette.info,
          ),
        ],
      );

  Widget _buildStatCard(
          String title, String value, IconData icon, Color color) =>
      Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppPalette.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );

  Widget _buildTeamMap(List<LocationSample> teamLocations) => SizedBox(
        height: 300,
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: GoogleMap(
              onMapCreated: (controller) => _mapController = controller,
              initialCameraPosition: const CameraPosition(
                target: LatLng(19.4326, -99.1332), // Mexico City
                zoom: 11,
              ),
              markers: teamLocations
                  .map((location) => Marker(
                        markerId: MarkerId(location.userId),
                        position: LatLng(location.latitude, location.longitude),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueBlue,
                        ),
                        infoWindow: InfoWindow(
                          title: 'Equipo ${location.userId}',
                          snippet: 'Actualizado: ${_formatTime(location.at)}',
                        ),
                      ))
                  .toSet(),
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
            ),
          ),
        ),
      );

  Widget _buildActiveVisitsSection(List<Visit> activeVisits) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Visitas Activas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${activeVisits.length}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppPalette.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (activeVisits.isEmpty)
                const Center(
                  child: Text(
                    'No hay visitas activas',
                    style: TextStyle(color: AppPalette.textSecondary),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: activeVisits.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final visit = activeVisits[index];
                    return ActiveVisitTile(visit: visit);
                  },
                ),
            ],
          ),
        ),
      );

  Widget _buildMemberDetailsPanel(TeamMemberDetails memberDetails) => Container(
        height: 300,
        margin: const EdgeInsets.all(16),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      memberDetails.user.fullName ?? 'Usuario',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () =>
                          context.read<SupervisorCubit>().clearSelectedMember(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildMemberStat(
                        'Visitas',
                        '${memberDetails.performance.visitsToday}',
                        Icons.location_on,
                      ),
                    ),
                    Expanded(
                      child: _buildMemberStat(
                        'Pedidos',
                        '${memberDetails.performance.ordersToday}',
                        Icons.shopping_cart,
                      ),
                    ),
                    Expanded(
                      child: _buildMemberStat(
                        'Ventas',
                        '\$${memberDetails.performance.salesAmount.toStringAsFixed(0)}',
                        Icons.attach_money,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget _buildMemberStat(String label, String value, IconData icon) => Column(
        children: [
          Icon(icon, color: AppPalette.primary),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
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
      );

  Widget _buildReportView(PerformanceReport report) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reporte de Rendimiento',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      report.period,
                      style: const TextStyle(
                        color: AppPalette.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildReportStat(
                            'Total Visitas',
                            '${report.totalVisits}',
                          ),
                        ),
                        Expanded(
                          child: _buildReportStat(
                            'Pedidos',
                            '${report.totalOrders}',
                          ),
                        ),
                        Expanded(
                          child: _buildReportStat(
                            'Ventas',
                            '\$${report.totalSales.toStringAsFixed(0)}',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Top performers
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Mejores Vendedores',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: report.topPerformers.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final performer = report.topPerformers[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: AppPalette.primary,
                            child: Text('${index + 1}'),
                          ),
                          title: Text(performer.userName),
                          subtitle: Text(
                              '${performer.visits} visitas • ${performer.orders} pedidos'),
                          trailing: Text(
                            '\$${performer.sales.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppPalette.success,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _buildReportStat(String label, String value) => Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
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
            textAlign: TextAlign.center,
          ),
        ],
      );

  void _generateReport(ReportPeriod period) {
    final now = DateTime.now();
    DateTime startDate;
    final DateTime endDate = now;

    switch (period) {
      case ReportPeriod.today:
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case ReportPeriod.week:
        startDate = now.subtract(Duration(days: now.weekday - 1));
        break;
      case ReportPeriod.month:
        startDate = DateTime(now.year, now.month);
        break;
    }

    context.read<SupervisorCubit>().loadPerformanceReport(
          startDate: startDate,
          endDate: endDate,
        );
  }

  void _showTeamMessageDialog() {
    showDialog(
      context: context,
      builder: (context) => const TeamMessageDialog(),
    );
  }

  String _formatTime(DateTime dateTime) =>
      '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}

class TeamMemberCard extends StatelessWidget {
  const TeamMemberCard({
    super.key,
    required this.location,
    required this.onTap,
  });
  final LocationSample location;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: AppPalette.success,
            child: Icon(Icons.person, color: Colors.white),
          ),
          title: Text('Usuario ${location.userId}'),
          subtitle: Text('Última actualización: ${_formatTime(location.at)}'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: AppPalette.success,
              ),
              Text(
                '${location.accuracyM?.toStringAsFixed(0) ?? 'N/A'}m',
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
          onTap: onTap,
        ),
      );

  String _formatTime(DateTime dateTime) =>
      '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}

class ActiveVisitTile extends StatelessWidget {
  const ActiveVisitTile({super.key, required this.visit});
  final Visit visit;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: CircleAvatar(
          backgroundColor: AppPalette.warning,
          child: Icon(_getPurposeIcon(), color: Colors.white, size: 20),
        ),
        title: Text(visit.customer?.name ?? 'Cliente'),
        subtitle: Text(
          'Iniciada: ${visit.startedAt != null ? _formatTime(visit.startedAt!) : 'N/A'}',
        ),
        trailing: Text(_getPurposeLabel()),
      );

  IconData _getPurposeIcon() {
    switch (visit.purpose) {
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

  String _getPurposeLabel() {
    switch (visit.purpose) {
      case VisitPurpose.venta:
        return 'Venta';
      case VisitPurpose.cobro:
        return 'Cobro';
      case VisitPurpose.entrega:
        return 'Entrega';
      case VisitPurpose.visita:
        return 'Visita';
      case VisitPurpose.auditoria:
        return 'Auditoría';
      case VisitPurpose.devolucion:
        return 'Devolución';
      case VisitPurpose.otro:
        return 'Otro';
    }
  }

  String _formatTime(DateTime dateTime) =>
      '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}

class TeamMessageDialog extends StatefulWidget {
  const TeamMessageDialog({super.key});

  @override
  State<TeamMessageDialog> createState() => _TeamMessageDialogState();
}

class _TeamMessageDialogState extends State<TeamMessageDialog> {
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Mensaje al Equipo'),
        content: TextField(
          controller: _messageController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Escribe tu mensaje...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<SupervisorCubit>().sendTeamMessage(
                    message: _messageController.text,
                  );
              Navigator.of(context).pop();
            },
            child: const Text('Enviar'),
          ),
        ],
      );

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}

enum ReportPeriod { today, week, month }
