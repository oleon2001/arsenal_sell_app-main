import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
import '../bloc/admin_cubit.dart';

class SystemSettingsPage extends StatefulWidget {
  const SystemSettingsPage({super.key});

  @override
  State<SystemSettingsPage> createState() => _SystemSettingsPageState();
}

class _SystemSettingsPageState extends State<SystemSettingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Configuración del Sistema'),
          backgroundColor: AppPalette.admin,
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveSettings,
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: const [
              Tab(text: 'General', icon: Icon(Icons.settings)),
              Tab(text: 'Seguridad', icon: Icon(Icons.security)),
              Tab(text: 'Base de Datos', icon: Icon(Icons.storage)),
              Tab(text: 'Respaldos', icon: Icon(Icons.backup)),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildGeneralSettings(),
            _buildSecuritySettings(),
            _buildDatabaseSettings(),
            _buildBackupSettings(),
          ],
        ),
      );

  Widget _buildGeneralSettings() => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSystemInfoCard(),
            const SizedBox(height: 16),
            _buildApplicationSettingsCard(),
            const SizedBox(height: 16),
            _buildNotificationSettingsCard(),
          ],
        ),
      );

  Widget _buildSecuritySettings() => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildPasswordPolicyCard(),
            const SizedBox(height: 16),
            _buildSessionSettingsCard(),
            const SizedBox(height: 16),
            _buildAccessControlCard(),
          ],
        ),
      );

  Widget _buildDatabaseSettings() => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildConnectionSettingsCard(),
            const SizedBox(height: 16),
            _buildMaintenanceCard(),
            const SizedBox(height: 16),
            _buildPerformanceCard(),
          ],
        ),
      );

  Widget _buildBackupSettings() => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildBackupConfigurationCard(),
            const SizedBox(height: 16),
            _buildBackupHistoryCard(),
            const SizedBox(height: 16),
            _buildRestoreCard(),
          ],
        ),
      );

  Widget _buildSystemInfoCard() => Card(
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
              _buildInfoRow('Versión de la Aplicación', '1.0.0'),
              _buildInfoRow('Versión de Flutter', '3.16.0'),
              _buildInfoRow('Versión de Dart', '3.2.0'),
              _buildInfoRow('Plataforma', 'Android/iOS'),
              _buildInfoRow('Última Actualización', '2024-01-15'),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _checkForUpdates(),
                icon: const Icon(Icons.update),
                label: const Text('Verificar Actualizaciones'),
              ),
            ],
          ),
        ),
      );

  Widget _buildApplicationSettingsCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Configuración de la Aplicación',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Modo Oscuro'),
                subtitle: const Text('Activar tema oscuro para la aplicación'),
                value: false, // TODO: Get from settings
                onChanged: (value) {
                  // TODO: Update dark mode setting
                },
              ),
              SwitchListTile(
                title: const Text('Notificaciones Push'),
                subtitle: const Text('Recibir notificaciones en tiempo real'),
                value: true, // TODO: Get from settings
                onChanged: (value) {
                  // TODO: Update push notifications setting
                },
              ),
              SwitchListTile(
                title: const Text('Sincronización Automática'),
                subtitle: const Text('Sincronizar datos automáticamente'),
                value: true, // TODO: Get from settings
                onChanged: (value) {
                  // TODO: Update auto sync setting
                },
              ),
            ],
          ),
        ),
      );

  Widget _buildNotificationSettingsCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Configuración de Notificaciones',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Nuevos Pedidos'),
                subtitle:
                    const Text('Notificar cuando se reciban nuevos pedidos'),
                value: true,
                onChanged: (value) {},
              ),
              SwitchListTile(
                title: const Text('Cambios de Estado'),
                subtitle:
                    const Text('Notificar cambios en el estado de pedidos'),
                value: true,
                onChanged: (value) {},
              ),
              SwitchListTile(
                title: const Text('Recordatorios'),
                subtitle: const Text('Recordatorios de tareas pendientes'),
                value: false,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      );

  Widget _buildPasswordPolicyCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Política de Contraseñas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Longitud Mínima',
                  hintText: '8',
                ),
                keyboardType: TextInputType.number,
                initialValue: '8',
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Requerir Mayúsculas'),
                subtitle: const Text(
                    'La contraseña debe contener al menos una letra mayúscula'),
                value: true,
                onChanged: (value) {},
              ),
              SwitchListTile(
                title: const Text('Requerir Números'),
                subtitle: const Text(
                    'La contraseña debe contener al menos un número'),
                value: true,
                onChanged: (value) {},
              ),
              SwitchListTile(
                title: const Text('Requerir Símbolos'),
                subtitle: const Text(
                    'La contraseña debe contener al menos un símbolo especial'),
                value: false,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      );

  Widget _buildSessionSettingsCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Configuración de Sesiones',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Tiempo de Expiración (minutos)',
                  hintText: '30',
                ),
                keyboardType: TextInputType.number,
                initialValue: '30',
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Sesión Única'),
                subtitle:
                    const Text('Permitir solo una sesión activa por usuario'),
                value: false,
                onChanged: (value) {},
              ),
              SwitchListTile(
                title: const Text('Recordar Dispositivo'),
                subtitle: const Text('Recordar dispositivos confiables'),
                value: true,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      );

  Widget _buildAccessControlCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Control de Acceso',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Autenticación de Dos Factores'),
                subtitle: const Text('Requerir 2FA para todos los usuarios'),
                value: false,
                onChanged: (value) {},
              ),
              SwitchListTile(
                title: const Text('IP Whitelist'),
                subtitle: const Text('Restringir acceso por IP'),
                value: false,
                onChanged: (value) {},
              ),
              SwitchListTile(
                title: const Text('Horario de Acceso'),
                subtitle: const Text('Restringir acceso por horario'),
                value: false,
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      );

  Widget _buildConnectionSettingsCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Configuración de Conexión',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'URL de la Base de Datos',
                  hintText: 'https://your-project.supabase.co',
                ),
                initialValue: 'https://your-project.supabase.co',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Timeout de Conexión (segundos)',
                  hintText: '30',
                ),
                keyboardType: TextInputType.number,
                initialValue: '30',
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () =>
                    context.read<AdminCubit>().testDatabaseConnection(),
                icon: const Icon(Icons.network_check),
                label: const Text('Probar Conexión'),
              ),
            ],
          ),
        ),
      );

  Widget _buildMaintenanceCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Mantenimiento',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _optimizeDatabase(),
                icon: const Icon(Icons.speed),
                label: const Text('Optimizar Base de Datos'),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () => _cleanupOldData(),
                icon: const Icon(Icons.cleaning_services),
                label: const Text('Limpiar Datos Antiguos'),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () => _rebuildIndexes(),
                icon: const Icon(Icons.build),
                label: const Text('Reconstruir Índices'),
              ),
            ],
          ),
        ),
      );

  Widget _buildPerformanceCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rendimiento',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildInfoRow('Conexiones Activas', '12'),
              _buildInfoRow('Consultas por Minuto', '45'),
              _buildInfoRow('Tiempo de Respuesta Promedio', '120ms'),
              _buildInfoRow('Uso de Memoria', '2.1 GB'),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _showPerformanceMetrics(),
                icon: const Icon(Icons.analytics),
                label: const Text('Ver Métricas Detalladas'),
              ),
            ],
          ),
        ),
      );

  Widget _buildBackupConfigurationCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Configuración de Respaldos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Respaldos Automáticos'),
                subtitle: const Text('Crear respaldos automáticamente'),
                value: true,
                onChanged: (value) {},
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Frecuencia (días)',
                  hintText: '7',
                ),
                keyboardType: TextInputType.number,
                initialValue: '7',
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Retención (días)',
                  hintText: '30',
                ),
                keyboardType: TextInputType.number,
                initialValue: '30',
              ),
            ],
          ),
        ),
      );

  Widget _buildBackupHistoryCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Historial de Respaldos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.backup),
                    title: Text('Respaldo ${index + 1}'),
                    subtitle: Text('2024-01-${15 - index} 10:30'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.download),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );

  Widget _buildRestoreCard() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Restauración',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => _showRestoreDialog(),
                icon: const Icon(Icons.restore),
                label: const Text('Restaurar desde Respaldo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.warning,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: () => _createBackup(),
                icon: const Icon(Icons.backup),
                label: const Text('Crear Respaldo Manual'),
              ),
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

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Configuración guardada exitosamente'),
        backgroundColor: AppPalette.success,
      ),
    );
  }

  void _checkForUpdates() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verificando actualizaciones...'),
        backgroundColor: AppPalette.info,
      ),
    );
  }

  void _optimizeDatabase() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Optimizando base de datos...'),
        backgroundColor: AppPalette.info,
      ),
    );
  }

  void _cleanupOldData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Limpiando datos antiguos...'),
        backgroundColor: AppPalette.info,
      ),
    );
  }

  void _rebuildIndexes() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Reconstruyendo índices...'),
        backgroundColor: AppPalette.info,
      ),
    );
  }

  void _showPerformanceMetrics() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Métricas de Rendimiento'),
        content: const Text(
            'Aquí se mostrarían las métricas detalladas del sistema.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _showRestoreDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restaurar desde Respaldo'),
        content: const Text(
          '¿Está seguro de que desea restaurar desde un respaldo? Esta acción sobrescribirá todos los datos actuales.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AdminCubit>().restoreBackup();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPalette.warning,
              foregroundColor: Colors.white,
            ),
            child: const Text('Restaurar'),
          ),
        ],
      ),
    );
  }

  void _createBackup() {
    context.read<AdminCubit>().createBackup();
  }
}
