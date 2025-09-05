import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/widgets/app_scaffold.dart';
import '../features/auth/bloc/auth_cubit.dart';
import '../features/auth/pages/sign_in_page.dart';
import '../features/auth/pages/sign_up_page.dart';
import '../features/customers/pages/customer_detail_page.dart';
import '../features/customers/pages/customer_form_page.dart';
import '../features/customers/pages/customers_list_page.dart';
import '../features/deliveries/pages/deliveries_page.dart';
import '../features/map/pages/live_map_page.dart';
import '../features/orders/pages/cart_page.dart';
import '../features/orders/pages/order_history_page.dart';
import '../features/payments/pages/payments_page.dart';
import '../features/supervisor/pages/supervisor_dashboard_page.dart';
import '../features/visits/pages/visit_checkin_page.dart';
import '../features/visits/pages/visit_forms_page.dart';
import '../features/visits/pages/visit_history_page.dart';
import '../features/visits/pages/visit_photos_page.dart';
import '../features/visits/pages/visit_signature_page.dart';
import '../features/admin/pages/admin_dashboard_page.dart';
import '../features/admin/pages/user_form_page.dart';
import '../features/admin/pages/system_settings_page.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/dashboard',
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Página no encontrada: ${state.matchedLocation}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/dashboard'),
              child: const Text('Ir al Inicio'),
            ),
          ],
        ),
      ),
    ),
    redirect: (context, state) {
      final authState = context.read<AuthCubit>().state;
      final isAuthenticated = authState is Authenticated;
      final isGoingToSignIn = state.matchedLocation == '/sign-in';
      final isGoingToSignUp = state.matchedLocation == '/sign-up';
      final isGoingToRoot = state.matchedLocation == '/';

      // Si no está autenticado y no va a sign-in o sign-up, redirigir a sign-in
      if (!isAuthenticated && !isGoingToSignIn && !isGoingToSignUp) {
        return '/sign-in';
      }

      // Si está autenticado y va a sign-in o sign-up, redirigir a dashboard
      if (isAuthenticated && (isGoingToSignIn || isGoingToSignUp)) {
        return '/dashboard';
      }

      // Si está autenticado y va a root, redirigir a dashboard
      if (isAuthenticated && isGoingToRoot) {
        return '/dashboard';
      }

      // Si no está autenticado y va a root, redirigir a sign-in
      if (!isAuthenticated && isGoingToRoot) {
        return '/sign-in';
      }

      return null;
    },
    routes: [
      // Root route redirect
      GoRoute(
        path: '/',
        redirect: (context, state) => '/dashboard',
      ),

      // Auth routes
      GoRoute(
        path: '/sign-in',
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: '/sign-up',
        builder: (context, state) => const SignUpPage(),
      ),

      // Main app shell
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => AppScaffold(child: child),
        routes: [
          // Dashboard/Map
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const LiveMapPage(),
          ),

          // Customers
          GoRoute(
            path: '/customers',
            builder: (context, state) => const CustomersListPage(),
          ),
          GoRoute(
            path: '/customers/new',
            builder: (context, state) => const CustomerFormPage(),
          ),
          GoRoute(
            path: '/customers/:id',
            builder: (context, state) => CustomerDetailPage(
              customerId: state.pathParameters['id']!,
            ),
          ),

          // Visits
          GoRoute(
            path: '/visit/checkin/:customerId',
            builder: (context, state) => VisitCheckinPage(
              customerId: state.pathParameters['customerId']!,
              purpose: state.uri.queryParameters['purpose'],
            ),
          ),
          GoRoute(
            path: '/visit/forms/:visitId',
            builder: (context, state) => VisitFormsPage(
              visitId: state.pathParameters['visitId']!,
            ),
          ),
          GoRoute(
            path: '/visit/history/:customerId',
            builder: (context, state) => VisitHistoryPage(
              customerId: state.pathParameters['customerId']!,
            ),
          ),
          GoRoute(
            path: '/visit/photos/:visitId',
            builder: (context, state) => VisitPhotosPage(
              visitId: state.pathParameters['visitId']!,
            ),
          ),
          GoRoute(
            path: '/visit/signature/:visitId',
            builder: (context, state) => VisitSignaturePage(
              visitId: state.pathParameters['visitId']!,
            ),
          ),

          // Orders
          GoRoute(
            path: '/orders',
            builder: (context, state) => const OrderHistoryPage(),
          ),
          GoRoute(
            path: '/orders/cart/:customerId',
            builder: (context, state) => CartPage(
              customerId: state.pathParameters['customerId']!,
            ),
          ),

          // Deliveries
          GoRoute(
            path: '/deliveries',
            builder: (context, state) => const DeliveriesPage(),
          ),

          // Payments
          GoRoute(
            path: '/payments',
            builder: (context, state) => const PaymentsPage(),
          ),

          // Supervisor
          GoRoute(
            path: '/supervisor',
            builder: (context, state) => const SupervisorDashboardPage(),
          ),

          // Admin routes
          GoRoute(
            path: '/admin',
            builder: (context, state) => const AdminDashboardPage(),
          ),
          GoRoute(
            path: '/admin/settings',
            builder: (context, state) => const SystemSettingsPage(),
          ),
          GoRoute(
            path: '/admin/users/new',
            builder: (context, state) => const UserFormPage(),
          ),
          GoRoute(
            path: '/admin/users/:userId/edit',
            builder: (context, state) => UserFormPage(
              userId: state.pathParameters['userId']!,
            ),
          ),
        ],
      ),
    ],
  );
}
