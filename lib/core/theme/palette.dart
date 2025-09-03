import 'package:flutter/material.dart';

class AppPalette {
  // Primary colors
  static const Color primary = Color(0xFF1E88E5);
  static const Color primaryDark = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFF90CAF9);
  static const Color primaryContainer = Color(0xFFE3F2FD);

  // Secondary colors
  static const Color secondary = Color(0xFF26A69A);
  static const Color secondaryDark = Color(0xFF00695C);
  static const Color secondaryLight = Color(0xFF80CBC4);
  static const Color secondaryContainer = Color(0xFFE0F2F1);

  // Status colors
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF388E3C);
  static const Color successContainer = Color(0xFFE8F5E8);

  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);
  static const Color warningContainer = Color(0xFFFFF3E0);

  static const Color error = Color(0xFFE53935);
  static const Color errorLight = Color(0xFFEF5350);
  static const Color errorDark = Color(0xFFC62828);
  static const Color errorContainer = Color(0xFFFFEBEE);

  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);
  static const Color infoDark = Color(0xFF1976D2);
  static const Color infoContainer = Color(0xFFE3F2FD);

  // Neutral colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF3F3F3);
  static const Color surfaceDark = Color(0xFF121212);
  static const Color surfaceVariantDark = Color(0xFF1E1E1E);

  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textDisabled = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnSecondary = Color(0xFFFFFFFF);
  static const Color textOnSurface = Color(0xFF212121);
  static const Color textOnSurfaceDark = Color(0xFFFFFFFF);

  // Role colors
  static const Color vendedor = Color(0xFF2196F3);
  static const Color vendedorLight = Color(0xFF64B5F6);
  static const Color vendedorDark = Color(0xFF1976D2);
  static const Color vendedorContainer = Color(0xFFE3F2FD);

  static const Color repartidor = Color(0xFF4CAF50);
  static const Color repartidorLight = Color(0xFF81C784);
  static const Color repartidorDark = Color(0xFF388E3C);
  static const Color repartidorContainer = Color(0xFFE8F5E8);

  static const Color supervisor = Color(0xFFFF9800);
  static const Color supervisorLight = Color(0xFFFFB74D);
  static const Color supervisorDark = Color(0xFFF57C00);
  static const Color supervisorContainer = Color(0xFFFFF3E0);

  static const Color admin = Color(0xFF9C27B0);
  static const Color adminLight = Color(0xFFBA68C8);
  static const Color adminDark = Color(0xFF7B1FA2);
  static const Color adminContainer = Color(0xFFF3E5F5);

  // Order status colors
  static const Color draft = Color(0xFF9E9E9E);
  static const Color draftLight = Color(0xFFBDBDBD);
  static const Color draftDark = Color(0xFF757575);
  static const Color draftContainer = Color(0xFFF5F5F5);

  static const Color sent = Color(0xFFFF9800);
  static const Color sentLight = Color(0xFFFFB74D);
  static const Color sentDark = Color(0xFFF57C00);
  static const Color sentContainer = Color(0xFFFFF3E0);

  static const Color approved = Color(0xFF2196F3);
  static const Color approvedLight = Color(0xFF64B5F6);
  static const Color approvedDark = Color(0xFF1976D2);
  static const Color approvedContainer = Color(0xFFE3F2FD);

  static const Color rejected = Color(0xFFE53935);
  static const Color rejectedLight = Color(0xFFEF5350);
  static const Color rejectedDark = Color(0xFFC62828);
  static const Color rejectedContainer = Color(0xFFFFEBEE);

  static const Color delivered = Color(0xFF4CAF50);
  static const Color deliveredLight = Color(0xFF81C784);
  static const Color deliveredDark = Color(0xFF388E3C);
  static const Color deliveredContainer = Color(0xFFE8F5E8);

  static const Color cancelled = Color(0xFF9E9E9E);
  static const Color cancelledLight = Color(0xFFBDBDBD);
  static const Color cancelledDark = Color(0xFF757575);
  static const Color cancelledContainer = Color(0xFFF5F5F5);

  // Additional utility colors
  static const Color divider = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF424242);
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);

  // Gradient colors
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [success, successDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warningGradient = LinearGradient(
    colors: [warning, warningDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Helper methods
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'draft':
      case 'borrador':
        return draft;
      case 'sent':
      case 'enviado':
        return sent;
      case 'approved':
      case 'aprobado':
        return approved;
      case 'rejected':
      case 'rechazado':
        return rejected;
      case 'delivered':
      case 'entregado':
        return delivered;
      case 'cancelled':
      case 'cancelado':
        return cancelled;
      default:
        return textSecondary;
    }
  }

  static Color getRoleColor(String role) {
    switch (role.toLowerCase()) {
      case 'vendedor':
        return vendedor;
      case 'repartidor':
        return repartidor;
      case 'supervisor':
        return supervisor;
      case 'admin':
      case 'administrador':
        return admin;
      default:
        return primary;
    }
  }
}
