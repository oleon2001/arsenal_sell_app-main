import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../theme/palette.dart';
import '../../features/auth/bloc/auth_cubit.dart';
import '../../data/models/auth/user_profile.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthCubit, AuthState>(
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
      );

  PreferredSizeWidget _buildAppBar(BuildContext context, UserRole role) {
    return AppBar(
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
              const SnackBar(
                content: Text('Notificaciones próximamente'),
                duration: Duration(seconds: 2),
              ),
            );
          },
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
            const PopupMenuItem(
              value: 'profile',
              child: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 8),
                  Text('Mi Perfil'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'settings',
              child: Row(
                children: [
                  Icon(Icons.settings),
                  SizedBox(width: 8),
                  Text('Configuración'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'logout',
              child: Row(
                children: [
                  Icon(Icons.logout, color: AppPalette.error),
                  SizedBox(width: 8),
                  Text('Cerrar Sesión',
                      style: TextStyle(color: AppPalette.error)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _getAppBarTitle(BuildContext context) {
    final currentLocation = GoRouterState.of(context).matchedLocation;

    switch (currentLocation) {
      case '/dashboard':
        return const Text('Mapa en Vivo');
      case '/customers':
        return const Text('Clientes');
      case '/orders':
        return const Text('Pedidos');
      case '/payments':
        return const Text('Cobros');
      case '/deliveries':
        return const Text('Entregas');
      case '/supervisor':
        return const Text('Panel de Control');
      default:
        return const Text('Arsenal Sell App');
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
      BottomNavigationBar(
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
      );

  Widget _buildRepartidorNavigation(
          BuildContext context, String currentLocation) =>
      BottomNavigationBar(
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
      );

  Widget _buildSupervisorNavigation(
          BuildContext context, String currentLocation) =>
      BottomNavigationBar(
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
      );

  Widget _buildAdminNavigation(BuildContext context, String currentLocation) =>
      BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppPalette.admin,
        unselectedItemColor: AppPalette.textSecondary,
        currentIndex: _getNavigationIndex(currentLocation, [
          '/dashboard',
          '/customers',
          '/supervisor',
        ]),
        onTap: (index) => _navigateToIndex(context, index, [
          '/dashboard',
          '/customers',
          '/supervisor',
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
            icon: Icon(Icons.admin_panel_settings),
            label: 'Admin',
          ),
        ],
      );

  Widget _buildDrawer(BuildContext context, UserProfile user) => Drawer(
        child: Column(
          children: [
            // Header del drawer
            Container(
              padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
              decoration: BoxDecoration(
                color: _getRoleColor(user.role),
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
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Text(
                          user.fullName?.isNotEmpty == true
                              ? user.fullName![0].toUpperCase()
                              : '?',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: _getRoleColor(user.role),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.fullName ?? 'Usuario',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _getRoleLabel(user.role),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            if (user.email != null)
                              Text(
                                user.email!,
                                style: const TextStyle(
                                  color: Colors.white60,
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
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

                  const Divider(height: 1),

                  // Sección de herramientas
                  _buildDrawerSection(
                    context,
                    'Herramientas',
                    [
                      ListTile(
                        leading: const Icon(Icons.sync),
                        title: const Text('Sincronizar'),
                        subtitle: const Text('Actualizar datos'),
                        onTap: () {
                          Navigator.pop(context);
                          _showSyncDialog(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_on),
                        title: const Text('Mi Ubicación'),
                        subtitle: const Text('Ver ubicación actual'),
                        onTap: () {
                          Navigator.pop(context);
                          context.go('/dashboard');
                        },
                      ),
                    ],
                  ),

                  const Divider(height: 1),

                  // Sección de configuración
                  _buildDrawerSection(
                    context,
                    'Configuración',
                    [
                      ListTile(
                        leading: const Icon(Icons.settings),
                        title: const Text('Configuración'),
                        subtitle: const Text('Ajustes de la app'),
                        onTap: () {
                          Navigator.pop(context);
                          _showSettingsDialog(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.help_outline),
                        title: const Text('Ayuda'),
                        subtitle: const Text('Manual de usuario'),
                        onTap: () {
                          Navigator.pop(context);
                          _showHelpDialog(context);
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.info_outline),
                        title: const Text('Acerca de'),
                        subtitle: const Text('Información de la app'),
                        onTap: () {
                          Navigator.pop(context);
                          _showAboutDialog(context);
                        },
                      ),
                    ],
                  ),

                  const Divider(height: 1),

                  // Botón de cerrar sesión
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _showLogoutDialog(context),
                        icon: const Icon(Icons.logout),
                        label: const Text('Cerrar Sesión'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppPalette.error,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
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
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppPalette.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  List<Widget> _getDrawerItems(BuildContext context, UserRole role) {
    final commonItems = [
      ListTile(
        leading: const Icon(Icons.map),
        title: const Text('Mapa en Vivo'),
        subtitle: const Text('Ver ubicaciones'),
        onTap: () {
          Navigator.pop(context);
          context.go('/dashboard');
        },
      ),
      ListTile(
        leading: const Icon(Icons.people),
        title: const Text('Clientes'),
        subtitle: const Text('Gestionar clientes'),
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
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Pedidos'),
            subtitle: const Text('Crear y gestionar'),
            onTap: () {
              Navigator.pop(context);
              context.go('/orders');
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Cobros'),
            subtitle: const Text('Registrar pagos'),
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
            leading: const Icon(Icons.local_shipping),
            title: const Text('Entregas'),
            subtitle: const Text('Gestionar entregas'),
            onTap: () {
              Navigator.pop(context);
              context.go('/deliveries');
            },
          ),
        ]);
        break;
      case UserRole.supervisor:
      case UserRole.admin:
        roleSpecificItems.addAll([
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Panel de Control'),
            subtitle: const Text('Monitoreo en tiempo real'),
            onTap: () {
              Navigator.pop(context);
              context.go('/supervisor');
            },
          ),
          ListTile(
            leading: const Icon(Icons.analytics),
            title: const Text('Reportes'),
            subtitle: const Text('Análisis y estadísticas'),
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
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.logout, color: AppPalette.error),
              SizedBox(width: 8),
              Text('Cerrar Sesión'),
            ],
          ),
          content: const Text(
            '¿Estás seguro de que quieres cerrar sesión? '
            'Se perderán los datos no sincronizados.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context); // Cerrar drawer
                context.read<AuthCubit>().signOut();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.error,
                foregroundColor: Colors.white,
              ),
              child: const Text('Cerrar Sesión'),
            ),
          ],
        );
      },
    );
  }

  void _showSyncDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.sync),
              SizedBox(width: 8),
              Text('Sincronizar Datos'),
            ],
          ),
          content: const Text(
            '¿Deseas sincronizar todos los datos pendientes con el servidor?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // TODO: Implementar sincronización
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sincronización iniciada...'),
                    backgroundColor: AppPalette.success,
                  ),
                );
              },
              child: const Text('Sincronizar'),
            ),
          ],
        );
      },
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.settings),
              SizedBox(width: 8),
              Text('Configuración'),
            ],
          ),
          content: const Text('Configuración próximamente disponible.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.help_outline),
              SizedBox(width: 8),
              Text('Ayuda'),
            ],
          ),
          content: const Text('Manual de usuario próximamente disponible.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.info_outline),
              SizedBox(width: 8),
              Text('Acerca de'),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Arsenal Sell App',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 8),
              Text('Versión: 1.0.0'),
              Text('Control de Fuerza de Ventas'),
              SizedBox(height: 8),
              Text('© 2024 Arsenal Sell App'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showReportsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.analytics),
              SizedBox(width: 8),
              Text('Reportes'),
            ],
          ),
          content: const Text('Reportes y análisis próximamente disponibles.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
