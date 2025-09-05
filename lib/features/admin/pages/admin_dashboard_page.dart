import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
import '../../../data/models/auth/user_profile.dart';
import '../bloc/admin_cubit.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    context.read<AdminCubit>().initializeDashboard();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Panel de Administración'),
          backgroundColor: AppPalette.admin,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => context.read<AdminCubit>().refreshData(),
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => context.push('/admin/settings'),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: 'Resumen', icon: Icon(Icons.dashboard)),
              Tab(text: 'Usuarios', icon: Icon(Icons.people)),
              Tab(text: 'Sistema', icon: Icon(Icons.settings_applications)),
              Tab(text: 'Auditoría', icon: Icon(Icons.assignment)),
            ],
          ),
        ),
        body: BlocConsumer<AdminCubit, AdminState>(
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
              _buildUsersTab(state),
              _buildSystemTab(state),
              _buildAuditTab(state),
            ],
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(),
      );

  Widget _buildOverviewTab(AdminState state) => state.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (stats, users, systemInfo, auditLogs) => RefreshIndicator(
          onRefresh: () => context.read<AdminCubit>().refreshData(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Stats Cards
                _buildStatsCards(stats),
                const SizedBox(height: 16),

                // System Health
                _buildSystemHealthCard(systemInfo),
                const SizedBox(height: 16),

                // Recent Activity
                _buildRecentActivityCard(auditLogs),
              ],
            ),
          ),
        ),
        error: (message) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: AppPalette.error),
              const SizedBox(height: 16),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.read<AdminCubit>().refreshData(),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );

  Widget _buildUsersTab(AdminState state) => state.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (stats, users, systemInfo, auditLogs) => Column(
          children: [
            // User Management Header
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Gestión de Usuarios',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => context.push('/admin/users/new'),
                    icon: const Icon(Icons.add),
                    label: const Text('Nuevo Usuario'),
                  ),
                ],
              ),
            ),

            // Users List
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return _buildUserCard(user);
                },
              ),
            ),
          ],
        ),
        error: (message) => Center(child: Text('Error: $message')),
      );

  Widget _buildSystemTab(AdminState state) => state.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (stats, users, systemInfo, auditLogs) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildSystemInfoCard(systemInfo),
              const SizedBox(height: 16),
              _buildDatabaseStatusCard(),
              const SizedBox(height: 16),
              _buildBackupStatusCard(),
            ],
          ),
        ),
        error: (message) => Center(child: Text('Error: $message')),
      );

  Widget _buildAuditTab(AdminState state) => state.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (stats, users, systemInfo, auditLogs) => Column(
          children: [
            // Audit Header
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Logs de Auditoría',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () =>
                        context.read<AdminCubit>().exportAuditLogs(),
                    icon: const Icon(Icons.download),
                  ),
                ],
              ),
            ),

            // Audit Logs
            Expanded(
              child: ListView.builder(
                itemCount: auditLogs.length,
                itemBuilder: (context, index) {
                  final log = auditLogs[index];
                  return _buildAuditLogCard(log);
                },
              ),
            ),
          ],
        ),
        error: (message) => Center(child: Text('Error: $message')),
      );

  Widget _buildStatsCards(AdminStats stats) => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1.5,
        children: [
          _buildStatCard(
            'Total Usuarios',
            stats.totalUsers.toString(),
            Icons.people,
            AppPalette.primary,
          ),
          _buildStatCard(
            'Usuarios Activos',
            stats.activeUsers.toString(),
            Icons.person_check_circle,
            AppPalette.success,
          ),
          _buildStatCard(
            'Compañías',
            stats.totalCompanies.toString(),
            Icons.business,
            AppPalette.warning,
          ),
          _buildStatCard(
            'Sesiones Hoy',
            stats.todaySessions.toString(),
            Icons.login,
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
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );

  Widget _buildSystemHealthCard(SystemInfo systemInfo) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Estado del Sistema',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildHealthIndicator('Base de Datos', systemInfo.databaseStatus),
              _buildHealthIndicator('API', systemInfo.apiStatus),
              _buildHealthIndicator('Storage', systemInfo.storageStatus),
              _buildHealthIndicator('Autenticación', systemInfo.authStatus),
            ],
          ),
        ),
      );

  Widget _buildHealthIndicator(String service, String status) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(service),
            Row(
              children: [
                Icon(
                  status == 'OK' ? Icons.check_circle : Icons.error,
                  color: status == 'OK' ? AppPalette.success : AppPalette.error,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  status,
                  style: TextStyle(
                    color:
                        status == 'OK' ? AppPalette.success : AppPalette.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildRecentActivityCard(List<AuditLog> auditLogs) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Actividad Reciente',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...auditLogs.take(5).map((log) => _buildAuditLogItem(log)),
            ],
          ),
        ),
      );

  Widget _buildAuditLogItem(AuditLog log) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(
              _getActionIcon(log.action),
              size: 16,
              color: AppPalette.textSecondary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${log.userName} ${log.action}',
                style: const TextStyle(fontSize: 12),
              ),
            ),
            Text(
              _formatTime(log.timestamp),
              style: const TextStyle(
                  fontSize: 12, color: AppPalette.textSecondary),
            ),
          ],
        ),
      );

  Widget _buildUserCard(UserProfile user) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor:
                user.isActive ? AppPalette.success : AppPalette.error,
            child: Text(
              user.fullName?.substring(0, 1).toUpperCase() ?? 'U',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(user.fullName ?? 'Sin nombre'),
          subtitle: Text('${user.email} • ${user.role.name}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => context.push('/admin/users/${user.id}/edit'),
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () => _showUserActionsDialog(user),
                icon: const Icon(Icons.more_vert),
              ),
            ],
          ),
        ),
      );

  Widget _buildSystemInfoCard(SystemInfo systemInfo) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Información del Sistema',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildInfoRow('Versión', systemInfo.version),
              _buildInfoRow('Última Actualización', systemInfo.lastUpdate.toString()),
              _buildInfoRow('Uptime', systemInfo.uptime),
              _buildInfoRow('Memoria Usada', systemInfo.memoryUsage),
            ],
          ),
        ),
      );

  Widget _buildInfoRow(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );

  Widget _buildDatabaseStatusCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Estado de la Base de Datos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    context.read<AdminCubit>().testDatabaseConnection(),
                child: const Text('Probar Conexión'),
              ),
            ],
          ),
        ),
      );

  Widget _buildBackupStatusCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Respaldo y Restauración',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => context.read<AdminCubit>().createBackup(),
                    child: const Text('Crear Respaldo'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => context.read<AdminCubit>().restoreBackup(),
                    child: const Text('Restaurar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _buildAuditLogCard(AuditLog log) => Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          leading: Icon(_getActionIcon(log.action)),
          title: Text(log.action),
          subtitle: Text('${log.userName} • ${_formatTime(log.timestamp)}'),
          trailing: Text(log.resource),
        ),
      );

  Widget _buildFloatingActionButton() => FloatingActionButton(
        onPressed: () => _showQuickActionsDialog(),
        child: const Icon(Icons.add),
      );

  IconData _getActionIcon(String action) {
    switch (action.toLowerCase()) {
      case 'create':
        return Icons.add;
      case 'update':
        return Icons.edit;
      case 'delete':
        return Icons.delete;
      case 'login':
        return Icons.login;
      case 'logout':
        return Icons.logout;
      default:
        return Icons.info;
    }
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Ahora';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }

  void _showUserActionsDialog(UserProfile user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Acciones para ${user.fullName}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Editar Usuario'),
              onTap: () {
                Navigator.pop(context);
                context.push('/admin/users/${user.id}/edit');
              },
            ),
            ListTile(
              leading: Icon(user.isActive ? Icons.block : Icons.check_circle),
              title: Text(user.isActive ? 'Desactivar' : 'Activar'),
              onTap: () {
                Navigator.pop(context);
                context.read<AdminCubit>().toggleUserStatus(user.id);
              },
            ),
            ListTile(
              leading: const Icon(Icons.key),
              title: const Text('Resetear Contraseña'),
              onTap: () {
                Navigator.pop(context);
                context.read<AdminCubit>().resetUserPassword(user.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showQuickActionsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Acciones Rápidas'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person_add),
              title: const Text('Nuevo Usuario'),
              onTap: () {
                Navigator.pop(context);
                context.push('/admin/users/new');
              },
            ),
            ListTile(
              leading: const Icon(Icons.backup),
              title: const Text('Crear Respaldo'),
              onTap: () {
                Navigator.pop(context);
                context.read<AdminCubit>().createBackup();
              },
            ),
            ListTile(
              leading: const Icon(Icons.refresh),
              title: const Text('Limpiar Cache'),
              onTap: () {
                Navigator.pop(context);
                context.read<AdminCubit>().clearCache();
              },
            ),
          ],
        ),
      ),
    );
  }
}
