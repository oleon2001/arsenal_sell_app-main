import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../theme/palette.dart';
import '../theme/design_system.dart';
import '../../features/auth/bloc/auth_cubit.dart';
import '../../data/models/auth/user_profile.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          // Si el usuario se desautentica, navegar a la página de inicio de sesión
          if (state.runtimeType.toString() == '_Unauthenticated') {
            // Usar un delay pequeño para asegurar que la navegación funcione correctamente
            Future.delayed(const Duration(milliseconds: 100), () {
              if (context.mounted) {
                context.go('/sign-in');
              }
            });
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            // Check if state is authenticated
            if (state is Authenticated) {
              final user = state.user;
              return Scaffold(
                appBar: _buildAppBar(context, user.role),
                body: child,
                bottomNavigationBar: _buildBottomNavigation(context, user),
                drawer: _buildDrawer(context, user),
              );
            }
            return child;
          },
        ),
      );

  PreferredSizeWidget _buildAppBar(BuildContext context, UserRole role) =>
      AppBar(
        title: _getAppBarTitle(context),
        backgroundColor: _getRoleColor(role),
        elevation: 2,
        actions: [
          // Botón de notificaciones
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // TODO: Implementar notificaciones
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Notificaciones próximamente'),
                  backgroundColor: AppPalette.primary,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            tooltip: 'Notificaciones',
          ),
          // Botón de perfil rápido
          PopupMenuButton<String>(
            icon: const Icon(Icons.account_circle),
            onSelected: (value) {
              switch (value) {
                case 'profile':
                  // TODO: Navegar a perfil
                  break;
                case 'settings':
                  // TODO: Navegar a configuración
                  break;
                case 'logout':
                  _showLogoutDialog(context);
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person, color: AppPalette.primary),
                    const SizedBox(width: AppSpacing.sm),
                    Text('Mi Perfil', style: AppTypography.labelLarge),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings, color: AppPalette.primary),
                    const SizedBox(width: AppSpacing.sm),
                    Text('Configuración', style: AppTypography.labelLarge),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(Icons.logout, color: AppPalette.error),
                    const SizedBox(width: AppSpacing.sm),
                    Text('Cerrar Sesión',
                        style: AppTypography.labelLarge.copyWith(
                          color: AppPalette.error,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ],
      );

  Widget _getAppBarTitle(BuildContext context) {
    final currentLocation = GoRouterState.of(context).matchedLocation;

    switch (currentLocation) {
      case '/dashboard':
        return Text('Mapa en Vivo',
            style: AppTypography.headline4.copyWith(
              color: Colors.white,
            ));
      case '/customers':
        return Text('Clientes',
            style: AppTypography.headline4.copyWith(
              color: Colors.white,
            ));
      case '/orders':
        return Text('Pedidos',
            style: AppTypography.headline4.copyWith(
              color: Colors.white,
            ));
      case '/payments':
        return Text('Cobros',
            style: AppTypography.headline4.copyWith(
              color: Colors.white,
            ));
      case '/deliveries':
        return Text('Entregas',
            style: AppTypography.headline4.copyWith(
              color: Colors.white,
            ));
      case '/supervisor':
        return Text('Panel de Control',
            style: AppTypography.headline4.copyWith(
              color: Colors.white,
            ));
      case '/admin':
        return Text('Panel de Administración',
            style: AppTypography.headline4.copyWith(
              color: Colors.white,
            ));
      default:
        return Text('Arsenal Sell App',
            style: AppTypography.headline4.copyWith(
              color: Colors.white,
            ));
    }
  }

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return AppPalette.admin;
      case UserRole.supervisor:
        return AppPalette.supervisor;
      case UserRole.vendedor:
        return AppPalette.primary;
      case UserRole.repartidor:
        return AppPalette.repartidor;
    }
  }

  Widget _buildBottomNavigation(BuildContext context, UserProfile user) {
    final currentLocation = GoRouterState.of(context).matchedLocation;

    // Different navigation based on role
    switch (user.role) {
      case UserRole.vendedor:
        return _buildVendedorNavigation(context, currentLocation);
      case UserRole.repartidor:
        return _buildRepartidorNavigation(context, currentLocation);
      case UserRole.supervisor:
        return _buildSupervisorNavigation(context, currentLocation);
      case UserRole.admin:
        return _buildAdminNavigation(context, currentLocation);
    }
  }

  Widget _buildVendedorNavigation(
          BuildContext context, String currentLocation) =>
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppPalette.primary,
          unselectedItemColor: AppPalette.textSecondary,
          currentIndex: _getNavigationIndex(currentLocation, [
            '/dashboard',
            '/customers',
            '/orders',
            '/payments',
          ]),
          onTap: (index) => _navigateToIndex(context, index, [
            '/dashboard',
            '/customers',
            '/orders',
            '/payments',
          ]),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Mapa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Clientes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Pedidos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Cobros',
            ),
          ],
        ),
      );

  Widget _buildRepartidorNavigation(
          BuildContext context, String currentLocation) =>
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppPalette.repartidor,
          unselectedItemColor: AppPalette.textSecondary,
          currentIndex: _getNavigationIndex(currentLocation, [
            '/dashboard',
            '/deliveries',
            '/customers',
          ]),
          onTap: (index) => _navigateToIndex(context, index, [
            '/dashboard',
            '/deliveries',
            '/customers',
          ]),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Ruta',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_shipping),
              label: 'Entregas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Clientes',
            ),
          ],
        ),
      );

  Widget _buildSupervisorNavigation(
          BuildContext context, String currentLocation) =>
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppPalette.supervisor,
          unselectedItemColor: AppPalette.textSecondary,
          currentIndex: _getNavigationIndex(currentLocation, [
            '/supervisor',
            '/dashboard',
            '/customers',
            '/orders',
          ]),
          onTap: (index) => _navigateToIndex(context, index, [
            '/supervisor',
            '/dashboard',
            '/customers',
            '/orders',
          ]),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Panel',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Campo',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Clientes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics),
              label: 'Reportes',
            ),
          ],
        ),
      );

  Widget _buildAdminNavigation(BuildContext context, String currentLocation) =>
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppPalette.admin,
          unselectedItemColor: AppPalette.textSecondary,
          currentIndex: _getNavigationIndex(currentLocation, [
            '/admin',
            '/dashboard',
            '/customers',
            '/supervisor',
          ]),
          onTap: (index) => _navigateToIndex(context, index, [
            '/admin',
            '/dashboard',
            '/customers',
            '/supervisor',
          ]),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.admin_panel_settings),
              label: 'Admin',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Mapa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Clientes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Panel',
            ),
          ],
        ),
      );

  Widget _buildDrawer(BuildContext context, UserProfile user) => Drawer(
        child: Column(
          children: [
            // Header del drawer
            Container(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md, 60, AppSpacing.md, AppSpacing.md),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    _getRoleColor(user.role),
                    _getRoleColor(user.role).withOpacity(0.8),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSpacing.sm),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          user.fullName?.isNotEmpty == true
                              ? user.fullName![0].toUpperCase()
                              : '?',
                          style: AppTypography.headline3.copyWith(
                            color: _getRoleColor(user.role),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.fullName ?? 'Usuario',
                              style: AppTypography.headline4.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xs,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius:
                                    BorderRadius.circular(AppShapes.sm),
                              ),
                              child: Text(
                                _getRoleLabel(user.role),
                                style: AppTypography.labelMedium.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            if (user.email != null) ...[
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                user.email!,
                                style: AppTypography.bodySmall.copyWith(
                                  color: Colors.white70,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Contenido del drawer
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Sección de navegación principal
                  _buildDrawerSection(
                    context,
                    'Navegación',
                    _getDrawerItems(context, user.role),
                  ),

                  AppComponents.sectionDivider(),

                  // Sección de herramientas
                  _buildDrawerSection(
                    context,
                    'Herramientas',
                    [
                      ListTile(
                        leading:
                            const Icon(Icons.sync, color: AppPalette.primary),
                        title: const Text('Sincronizar',
                            style: AppTypography.bodyMedium),
                        subtitle: const Text('Actualizar datos',
                            style: AppTypography.bodySmall),
                        onTap: () {
                          Navigator.pop(context);
                          _showSyncDialog(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_on,
                            color: AppPalette.primary),
                        title: const Text('Mi Ubicación',
                            style: AppTypography.bodyMedium),
                        subtitle: const Text('Ver ubicación actual',
                            style: AppTypography.bodySmall),
                        onTap: () {
                          Navigator.pop(context);
                          context.go('/dashboard');
                        },
                      ),
                    ],
                  ),

                  AppComponents.sectionDivider(),

                  // Sección de configuración
                  _buildDrawerSection(
                    context,
                    'Configuración',
                    [
                      ListTile(
                        leading: const Icon(Icons.settings,
                            color: AppPalette.primary),
                        title: const Text('Configuración',
                            style: AppTypography.bodyMedium),
                        subtitle: const Text('Ajustes de la app',
                            style: AppTypography.bodySmall),
                        onTap: () {
                          Navigator.pop(context);
                          _showSettingsDialog(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.help_outline,
                            color: AppPalette.primary),
                        title: const Text('Ayuda',
                            style: AppTypography.bodyMedium),
                        subtitle: const Text('Manual de usuario',
                            style: AppTypography.bodySmall),
                        onTap: () {
                          Navigator.pop(context);
                          _showHelpDialog(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.info_outline,
                            color: AppPalette.primary),
                        title: const Text('Acerca de',
                            style: AppTypography.bodyMedium),
                        subtitle: const Text('Información de la app',
                            style: AppTypography.bodySmall),
                        onTap: () {
                          Navigator.pop(context);
                          _showAboutDialog(context);
                        },
                      ),
                    ],
                  ),

                  AppComponents.sectionDivider(),

                  // Botón de cerrar sesión
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: SizedBox(
                      width: double.infinity,
                      child: AppComponents.actionButton(
                        icon: Icons.logout,
                        label: 'Cerrar Sesión',
                        onPressed: () => _showLogoutDialog(context),
                        backgroundColor: AppPalette.error,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildDrawerSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.md, AppSpacing.md, AppSpacing.md, AppSpacing.sm),
            child: Text(
              title,
              style: AppTypography.labelMedium.copyWith(
                color: AppPalette.textSecondary,
                letterSpacing: 0.5,
              ),
            ),
          ),
          ...children,
        ],
      );

  List<Widget> _getDrawerItems(BuildContext context, UserRole role) {
    final commonItems = [
      ListTile(
        leading: const Icon(Icons.map, color: AppPalette.primary),
        title: const Text('Mapa en Vivo', style: AppTypography.bodyMedium),
        subtitle: const Text('Ver ubicaciones', style: AppTypography.bodySmall),
        onTap: () {
          Navigator.pop(context);
          context.go('/dashboard');
        },
      ),
      ListTile(
        leading: const Icon(Icons.people, color: AppPalette.primary),
        title: const Text('Clientes', style: AppTypography.bodyMedium),
        subtitle:
            const Text('Gestionar clientes', style: AppTypography.bodySmall),
        onTap: () {
          Navigator.pop(context);
          context.go('/customers');
        },
      ),
    ];

    final roleSpecificItems = <Widget>[];

    switch (role) {
      case UserRole.vendedor:
        roleSpecificItems.addAll([
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: AppPalette.primary),
            title: const Text('Pedidos', style: AppTypography.bodyMedium),
            subtitle:
                const Text('Crear y gestionar', style: AppTypography.bodySmall),
            onTap: () {
              Navigator.pop(context);
              context.go('/orders');
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment, color: AppPalette.primary),
            title: const Text('Cobros', style: AppTypography.bodyMedium),
            subtitle:
                const Text('Registrar pagos', style: AppTypography.bodySmall),
            onTap: () {
              Navigator.pop(context);
              context.go('/payments');
            },
          ),
        ]);
        break;
      case UserRole.repartidor:
        roleSpecificItems.addAll([
          ListTile(
            leading:
                const Icon(Icons.local_shipping, color: AppPalette.primary),
            title: const Text('Entregas', style: AppTypography.bodyMedium),
            subtitle: const Text('Gestionar entregas',
                style: AppTypography.bodySmall),
            onTap: () {
              Navigator.pop(context);
              context.go('/deliveries');
            },
          ),
        ]);
        break;
      case UserRole.supervisor:
        roleSpecificItems.addAll([
          ListTile(
            leading: const Icon(Icons.dashboard, color: AppPalette.primary),
            title:
                const Text('Panel de Control', style: AppTypography.bodyMedium),
            subtitle: const Text('Monitoreo en tiempo real',
                style: AppTypography.bodySmall),
            onTap: () {
              Navigator.pop(context);
              context.go('/supervisor');
            },
          ),
          ListTile(
            leading: const Icon(Icons.analytics, color: AppPalette.primary),
            title: const Text('Reportes', style: AppTypography.bodyMedium),
            subtitle: const Text('Análisis y estadísticas',
                style: AppTypography.bodySmall),
            onTap: () {
              Navigator.pop(context);
              _showReportsDialog(context);
            },
          ),
        ]);
        break;
      case UserRole.admin:
        roleSpecificItems.addAll([
          ListTile(
            leading:
                const Icon(Icons.admin_panel_settings, color: AppPalette.admin),
            title: const Text('Panel de Administración',
                style: AppTypography.bodyMedium),
            subtitle: const Text('Gestión del sistema',
                style: AppTypography.bodySmall),
            onTap: () {
              Navigator.pop(context);
              context.go('/admin');
            },
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: AppPalette.primary),
            title:
                const Text('Panel de Control', style: AppTypography.bodyMedium),
            subtitle: const Text('Monitoreo en tiempo real',
                style: AppTypography.bodySmall),
            onTap: () {
              Navigator.pop(context);
              context.go('/supervisor');
            },
          ),
          ListTile(
            leading: const Icon(Icons.analytics, color: AppPalette.primary),
            title: const Text('Reportes', style: AppTypography.bodyMedium),
            subtitle: const Text('Análisis y estadísticas',
                style: AppTypography.bodySmall),
            onTap: () {
              Navigator.pop(context);
              _showReportsDialog(context);
            },
          ),
        ]);
        break;
    }

    return [...commonItems, ...roleSpecificItems];
  }

  static int _getNavigationIndex(String currentLocation, List<String> routes) {
    for (int i = 0; i < routes.length; i++) {
      if (currentLocation.startsWith(routes[i])) {
        return i;
      }
    }
    return 0;
  }

  static void _navigateToIndex(
      BuildContext context, int index, List<String> routes) {
    if (index < routes.length) {
      context.go(routes[index]);
    }
  }

  static String _getRoleLabel(UserRole role) {
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

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.logout, color: AppPalette.error),
            const SizedBox(width: AppSpacing.sm),
            Text('Cerrar Sesión', style: AppTypography.headline4),
          ],
        ),
        content: Text(
          '¿Estás seguro de que quieres cerrar sesión? '
          'Se perderán los datos no sincronizados.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Cerrar diálogo
              Navigator.pop(context); // Cerrar drawer

              // Cerrar sesión - el BlocListener se encargará de la navegación
              await context.read<AuthCubit>().signOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppPalette.error,
              foregroundColor: Colors.white,
            ),
            child: Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }

  void _showSyncDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.sync, color: AppPalette.primary),
            const SizedBox(width: AppSpacing.sm),
            Text('Sincronizar Datos', style: AppTypography.headline4),
          ],
        ),
        content: Text(
          '¿Deseas sincronizar todos los datos pendientes con el servidor?',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implementar sincronización
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Sincronización iniciada...'),
                  backgroundColor: AppPalette.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text('Sincronizar'),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.settings, color: AppPalette.primary),
            const SizedBox(width: AppSpacing.sm),
            Text('Configuración', style: AppTypography.headline4),
          ],
        ),
        content: Text(
          'Configuración próximamente disponible.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.help_outline, color: AppPalette.primary),
            const SizedBox(width: AppSpacing.sm),
            Text('Ayuda', style: AppTypography.headline4),
          ],
        ),
        content: Text(
          'Manual de usuario próximamente disponible.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.info_outline, color: AppPalette.primary),
            const SizedBox(width: AppSpacing.sm),
            Text('Acerca de', style: AppTypography.headline4),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Arsenal Sell App',
              style: AppTypography.headline4.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text('Versión: 1.0.0', style: AppTypography.bodyMedium),
            Text('Control de Fuerza de Ventas',
                style: AppTypography.bodyMedium),
            const SizedBox(height: AppSpacing.sm),
            Text('© 2024 Arsenal Sell App', style: AppTypography.bodySmall),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showReportsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.analytics, color: AppPalette.primary),
            const SizedBox(width: AppSpacing.sm),
            Text('Reportes', style: AppTypography.headline4),
          ],
        ),
        content: Text(
          'Reportes y análisis próximamente disponibles.',
          style: AppTypography.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
