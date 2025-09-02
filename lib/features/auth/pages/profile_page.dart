import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
import '../../../data/models/auth/user_profile.dart';
import '../bloc/auth_cubit.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isEditing = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Mi Perfil'),
          actions: [
            if (!_isEditing)
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => setState(() => _isEditing = true),
              ),
            if (_isEditing)
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: _saveProfile,
              ),
          ],
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.runtimeType.toString() == '_Unauthenticated') {
              context.go('/sign-in');
            } else if (state.runtimeType.toString() == '_Error') {
              final errorState = state as dynamic;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errorState.message),
                  backgroundColor: AppPalette.error,
                ),
              );
            }
          },
          builder: (context, state) {
            final stateType = state.runtimeType.toString();

            if (stateType == '_Initial' || stateType == '_Loading') {
              return const Center(child: CircularProgressIndicator());
            } else if (stateType == '_Authenticated') {
              final authState = state as dynamic;
              return _buildProfileContent(authState.user);
            } else if (stateType == '_Unauthenticated') {
              return const Center(child: Text('No autenticado'));
            } else if (stateType == '_Error') {
              final errorState = state as dynamic;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: AppPalette.error,
                    ),
                    const SizedBox(height: 16),
                    Text(errorState.message),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<AuthCubit>().checkAuthStatus(),
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Estado desconocido'));
            }
          },
        ),
      );

  Widget _buildProfileContent(UserProfile user) {
    // Populate controllers when switching to edit mode
    if (_isEditing && _fullNameController.text.isEmpty) {
      _fullNameController.text = user.fullName ?? '';
      _phoneController.text = user.phone ?? '';
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Profile Avatar
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _getRoleColor(user.role).withOpacity(0.1),
                border: Border.all(
                  color: _getRoleColor(user.role),
                  width: 3,
                ),
              ),
              child: Icon(
                _getRoleIcon(user.role),
                size: 48,
                color: _getRoleColor(user.role),
              ),
            ),
            const SizedBox(height: 24),

            // Role Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _getRoleColor(user.role),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _getRoleDisplayName(user.role),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Profile Information
            _buildProfileCard(user),
            const SizedBox(height: 24),

            // Settings Section
            _buildSettingsSection(),
            const SizedBox(height: 24),

            // Statistics Section
            _buildStatisticsSection(user),
            const SizedBox(height: 32),

            // Sign Out Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _showSignOutDialog,
                icon: const Icon(Icons.logout),
                label: const Text('Cerrar Sesión'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(UserProfile user) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Información Personal',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Email (read-only)
              _buildInfoField(
                'Email',
                user.email ?? 'No especificado',
                Icons.email,
                enabled: false,
              ),
              const SizedBox(height: 16),

              // Full Name
              _isEditing
                  ? TextFormField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre Completo',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'El nombre es requerido';
                        }
                        return null;
                      },
                    )
                  : _buildInfoField(
                      'Nombre Completo',
                      user.fullName ?? 'No especificado',
                      Icons.person,
                    ),
              const SizedBox(height: 16),

              // Phone
              _isEditing
                  ? TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Teléfono',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value?.isNotEmpty == true) {
                          if (!RegExp(r'^\+?[\d\s\-\(\)]+$').hasMatch(value!)) {
                            return 'Formato de teléfono inválido';
                          }
                        }
                        return null;
                      },
                    )
                  : _buildInfoField(
                      'Teléfono',
                      user.phone ?? 'No especificado',
                      Icons.phone,
                    ),
              const SizedBox(height: 16),

              // Company ID (read-only)
              _buildInfoField(
                'ID de Empresa',
                user.companyId ?? 'No asignado',
                Icons.business,
                enabled: false,
              ),
              const SizedBox(height: 16),

              // Account Status
              Row(
                children: [
                  Icon(
                    user.isActive ? Icons.check_circle : Icons.cancel,
                    color:
                        user.isActive ? AppPalette.success : AppPalette.error,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    user.isActive ? 'Cuenta Activa' : 'Cuenta Inactiva',
                    style: TextStyle(
                      color:
                          user.isActive ? AppPalette.success : AppPalette.error,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              if (_isEditing) ...[
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => _isEditing = false),
                        child: const Text('Cancelar'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        child: const Text('Guardar'),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      );

  Widget _buildInfoField(
    String label,
    String value,
    IconData icon, {
    bool enabled = true,
  }) =>
      Row(
        children: [
          Icon(
            icon,
            color: enabled ? AppPalette.textSecondary : AppPalette.textDisabled,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: enabled
                        ? AppPalette.textSecondary
                        : AppPalette.textDisabled,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: enabled
                        ? AppPalette.textPrimary
                        : AppPalette.textDisabled,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  Widget _buildSettingsSection() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Configuración',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildSettingsTile(
                'Notificaciones',
                'Configurar alertas y notificaciones',
                Icons.notifications,
                () => _showNotificationSettings(),
              ),
              _buildSettingsTile(
                'Ubicación',
                'Configurar servicios de ubicación',
                Icons.location_on,
                () => _showLocationSettings(),
              ),
              _buildSettingsTile(
                'Sincronización',
                'Configurar sincronización de datos',
                Icons.sync,
                () => _showSyncSettings(),
              ),
              _buildSettingsTile(
                'Acerca de',
                'Información de la aplicación',
                Icons.info,
                () => _showAboutDialog(),
              ),
            ],
          ),
        ),
      );

  Widget _buildSettingsTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) =>
      ListTile(
        leading: Icon(icon, color: AppPalette.primary),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      );

  Widget _buildStatisticsSection(UserProfile user) => Card(
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
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      'Visitas Hoy',
                      '12',
                      Icons.location_on,
                      AppPalette.info,
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      'Esta Semana',
                      '48',
                      Icons.calendar_today,
                      AppPalette.success,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      'Pedidos',
                      '8',
                      Icons.shopping_cart,
                      AppPalette.warning,
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      'Cobros',
                      '5',
                      Icons.payment,
                      AppPalette.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _buildStatItem(
          String label, String value, IconData icon, Color color) =>
      Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
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
        ),
      );

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement profile update
      setState(() => _isEditing = false);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Perfil actualizado exitosamente'),
          backgroundColor: AppPalette.success,
        ),
      );
    }
  }

  void _showSignOutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthCubit>().signOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPalette.error,
            ),
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }

  void _showNotificationSettings() {
    // TODO: Implement notification settings
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Configuración de notificaciones')),
    );
  }

  void _showLocationSettings() {
    // TODO: Implement location settings
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Configuración de ubicación')),
    );
  }

  void _showSyncSettings() {
    // TODO: Implement sync settings
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Configuración de sincronización')),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Arsenal Sell App',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: AppPalette.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.business_center,
          color: Colors.white,
          size: 24,
        ),
      ),
      children: const [
        Text('Control de Fuerza de Ventas'),
        SizedBox(height: 8),
        Text(
            'Gestiona tu equipo de ventas y optimiza tus procesos comerciales.'),
      ],
    );
  }

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return AppPalette.admin;
      case UserRole.supervisor:
        return AppPalette.supervisor;
      case UserRole.vendedor:
        return AppPalette.vendedor;
      case UserRole.repartidor:
        return AppPalette.repartidor;
    }
  }

  IconData _getRoleIcon(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return Icons.admin_panel_settings;
      case UserRole.supervisor:
        return Icons.supervisor_account;
      case UserRole.vendedor:
        return Icons.person_pin;
      case UserRole.repartidor:
        return Icons.local_shipping;
    }
  }

  String _getRoleDisplayName(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return 'Administrador';
      case UserRole.supervisor:
        return 'Supervisor';
      case UserRole.vendedor:
        return 'Vendedor';
      case UserRole.repartidor:
        return 'Repartidor';
    }
  }
}
