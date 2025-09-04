import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../config/logger.dart';
import '../data/models/auth/user_profile.dart';
import '../features/auth/bloc/auth_cubit.dart';

class AuthGuard {
  static String? redirectIfUnauthenticated(
    BuildContext context,
    GoRouterState state,
  ) {
    final authState = context.read<AuthCubit>().state;
    final isAuthenticated = authState is Authenticated;
    final isGoingToSignIn = state.matchedLocation == '/sign-in';

    logger.d(
        'Auth guard: isAuthenticated=$isAuthenticated, location=${state.matchedLocation}');

    if (!isAuthenticated && !isGoingToSignIn) {
      return '/sign-in';
    }

    if (isAuthenticated && isGoingToSignIn) {
      return '/dashboard';
    }

    return null;
  }
}

class RoleGuard {
  /// Check if user has required role for accessing a route
  static String? checkRole(
    BuildContext context,
    GoRouterState state,
    List<UserRole> allowedRoles,
  ) {
    final authState = context.read<AuthCubit>().state;

    if (authState is! Authenticated) {
      return '/sign-in';
    }

    final userRole = authState.user.role;

    if (!allowedRoles.contains(userRole)) {
      logger.w('Access denied for role $userRole to ${state.matchedLocation}');
      return '/dashboard'; // Redirect to dashboard if role not allowed
    }

    return null;
  }

  /// Supervisor and Admin only routes
  static String? supervisorOrAdminOnly(
    BuildContext context,
    GoRouterState state,
  ) =>
      checkRole(context, state, [UserRole.supervisor, UserRole.admin]);

  /// Admin only routes
  static String? adminOnly(
    BuildContext context,
    GoRouterState state,
  ) =>
      checkRole(context, state, [UserRole.admin]);

  /// Vendedor routes (also allow supervisors and admins)
  static String? vendedorAccess(
    BuildContext context,
    GoRouterState state,
  ) =>
      checkRole(context, state, [
        UserRole.vendedor,
        UserRole.supervisor,
        UserRole.admin,
      ]);

  /// Repartidor routes (also allow supervisors and admins)
  static String? repartidorAccess(
    BuildContext context,
    GoRouterState state,
  ) =>
      checkRole(context, state, [
        UserRole.repartidor,
        UserRole.supervisor,
        UserRole.admin,
      ]);

  /// Routes accessible by field workers (vendedor + repartidor)
  static String? fieldWorkerAccess(
    BuildContext context,
    GoRouterState state,
  ) =>
      checkRole(context, state, [
        UserRole.vendedor,
        UserRole.repartidor,
        UserRole.supervisor,
        UserRole.admin,
      ]);
}

class FeatureGuard {
  /// Check if user's company has access to specific features
  static String? checkFeatureAccess(
    BuildContext context,
    GoRouterState state,
    String featureKey,
  ) {
    final authState = context.read<AuthCubit>().state;

    if (authState is! Authenticated) {
      return '/sign-in';
    }

    // TODO: Implement feature flags based on company subscription
    // For now, allow all features
    return null;
  }

  /// Check if orders feature is available
  static String? ordersFeatureGuard(
    BuildContext context,
    GoRouterState state,
  ) =>
      checkFeatureAccess(context, state, 'orders');

  /// Check if payments feature is available
  static String? paymentsFeatureGuard(
    BuildContext context,
    GoRouterState state,
  ) =>
      checkFeatureAccess(context, state, 'payments');

  /// Check if deliveries feature is available
  static String? deliveriesFeatureGuard(
    BuildContext context,
    GoRouterState state,
  ) =>
      checkFeatureAccess(context, state, 'deliveries');

  /// Check if supervisor dashboard is available
  static String? supervisorFeatureGuard(
    BuildContext context,
    GoRouterState state,
  ) =>
      checkFeatureAccess(context, state, 'supervisor_dashboard');
}

class LocationGuard {
  /// Check if location permissions are granted for location-dependent routes
  static String? checkLocationPermission(
    BuildContext context,
    GoRouterState state,
  ) {
    // TODO: Implement location permission check
    // For routes that require location (visits, tracking, etc.)
    return null;
  }
}

class OnboardingGuard {
  /// Check if user has completed onboarding
  static String? checkOnboardingCompleted(
    BuildContext context,
    GoRouterState state,
  ) {
    final authState = context.read<AuthCubit>().state;

    if (authState is! Authenticated) {
      return '/sign-in';
    }

    // TODO: Check if user has completed onboarding
    // This could be stored in user profile or preferences
    const hasCompletedOnboarding = true; // Mock for now

    if (!hasCompletedOnboarding) {
      return '/onboarding';
    }

    return null;
  }
}

class VisitGuard {
  /// Check if user can start a new visit (no active visit)
  static String? checkCanStartVisit(
    BuildContext context,
    GoRouterState state,
  ) {
    // TODO: Check if user has an active visit
    // If there's an active visit, redirect to that visit
    return null;
  }

  /// Check if user has an active visit for visit-related routes
  static String? requireActiveVisit(
    BuildContext context,
    GoRouterState state,
  ) {
    // TODO: Check if user has an active visit
    // If no active visit, redirect to dashboard
    return null;
  }
}

class NetworkGuard {
  /// Check network connectivity for online-only features
  static String? checkOnlineRequired(
    BuildContext context,
    GoRouterState state,
  ) {
    // TODO: Check network connectivity
    // Show offline page if required feature needs internet
    return null;
  }
}

class CompanyGuard {
  /// Check if user belongs to a company
  static String? requireCompanyMembership(
    BuildContext context,
    GoRouterState state,
  ) {
    final authState = context.read<AuthCubit>().state;

    if (authState is! Authenticated) {
      return '/sign-in';
    }

    if (authState.user.companyId == null) {
      logger.w('User has no company assigned');
      return '/no-company'; // Would need to create this page
    }

    return null;
  }
}

/// Utility class to combine multiple guards
class GuardCombiner {
  static String? combineGuards(
    BuildContext context,
    GoRouterState state,
    List<String? Function(BuildContext, GoRouterState)> guards,
  ) {
    for (final guard in guards) {
      final redirect = guard(context, state);
      if (redirect != null) {
        return redirect;
      }
    }
    return null;
  }

  /// Common guard combination for authenticated routes
  static String? authenticatedRoute(
    BuildContext context,
    GoRouterState state,
  ) =>
      combineGuards(context, state, [
        AuthGuard.redirectIfUnauthenticated,
        CompanyGuard.requireCompanyMembership,
        OnboardingGuard.checkOnboardingCompleted,
      ]);

  /// Common guard combination for supervisor routes
  static String? supervisorRoute(
    BuildContext context,
    GoRouterState state,
  ) =>
      combineGuards(context, state, [
        authenticatedRoute,
        RoleGuard.supervisorOrAdminOnly,
        FeatureGuard.supervisorFeatureGuard,
      ]);

  /// Common guard combination for field worker routes
  static String? fieldWorkerRoute(
    BuildContext context,
    GoRouterState state,
  ) =>
      combineGuards(context, state, [
        authenticatedRoute,
        RoleGuard.fieldWorkerAccess,
        LocationGuard.checkLocationPermission,
      ]);

  /// Common guard combination for visit routes
  static String? visitRoute(
    BuildContext context,
    GoRouterState state,
  ) =>
      combineGuards(context, state, [
        fieldWorkerRoute,
        VisitGuard.checkCanStartVisit,
      ]);

  /// Common guard combination for order routes
  static String? orderRoute(
    BuildContext context,
    GoRouterState state,
  ) =>
      combineGuards(context, state, [
        authenticatedRoute,
        RoleGuard.vendedorAccess,
        FeatureGuard.ordersFeatureGuard,
      ]);

  /// Common guard combination for delivery routes
  static String? deliveryRoute(
    BuildContext context,
    GoRouterState state,
  ) =>
      combineGuards(context, state, [
        authenticatedRoute,
        RoleGuard.repartidorAccess,
        FeatureGuard.deliveriesFeatureGuard,
      ]);
}

/// Helper extension for role checking
extension UserRoleExtension on UserRole {
  bool get isAdmin => this == UserRole.admin;
  bool get isSupervisor => this == UserRole.supervisor;
  bool get isVendedor => this == UserRole.vendedor;
  bool get isRepartidor => this == UserRole.repartidor;

  bool get canAccessSupervisorFeatures => isAdmin || isSupervisor;
  bool get canAccessAllFeatures => isAdmin;
  bool get isFieldWorker => isVendedor || isRepartidor;
}
