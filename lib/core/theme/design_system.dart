import 'package:flutter/material.dart';
import 'palette.dart';

/// Sistema de Diseño Arsenal Sell App
/// Define espaciado, tipografía y componentes consistentes

class AppSpacing {
  // Espaciado base usando múltiplos de 4
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // Espaciado específico para componentes
  static const double cardPadding = 16.0;
  static const double buttonPadding = 12.0;
  static const double inputPadding = 12.0;
  static const double listItemSpacing = 12.0;
}

class AppTypography {
  // Headlines
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.25,
    height: 1.3,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  static const TextStyle headline4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.4,
  );

  // Body text
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.25,
    height: 1.4,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
    height: 1.3,
  );

  // Labels
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.3,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.2,
  );

  // Special text
  static const TextStyle price = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.15,
    height: 1.2,
  );

  static const TextStyle status = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.2,
  );
}

class AppShapes {
  // Border radius
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;

  // Card shapes
  static const RoundedRectangleBorder cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(12)),
  );

  static const RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  static const RoundedRectangleBorder inputShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );
}

class AppShadows {
  static const List<BoxShadow> card = [
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: 8,
      offset: Offset(0, 2),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> elevated = [
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: 12,
      offset: Offset(0, 4),
      spreadRadius: 0,
    ),
  ];

  static const List<BoxShadow> floating = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 16,
      offset: Offset(0, 6),
      spreadRadius: 0,
    ),
  ];
}

class AppAnimations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);

  static const Curve defaultCurve = Curves.easeInOut;
  static const Curve bounceCurve = Curves.elasticOut;
  static const Curve slideCurve = Curves.easeOutCubic;
}

/// Componentes de UI reutilizables
class AppComponents {
  /// Tarjeta estándar con sombra y bordes redondeados
  static Widget card({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? backgroundColor,
    VoidCallback? onTap,
    bool elevated = true,
  }) {
    Widget content = Container(
      padding: padding ?? const EdgeInsets.all(AppSpacing.cardPadding),
      margin:
          margin ?? const EdgeInsets.only(bottom: AppSpacing.listItemSpacing),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppPalette.surface,
        borderRadius: BorderRadius.circular(AppShapes.md),
        boxShadow: elevated ? AppShadows.card : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppShapes.md),
          child: content,
        ),
      );
    }

    return content;
  }

  /// Badge de estado con colores semánticos
  static Widget statusBadge({
    required String text,
    required Color color,
    bool outlined = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: outlined ? Colors.transparent : color.withOpacity(0.1),
        border: outlined ? Border.all(color: color, width: 1) : null,
        borderRadius: BorderRadius.circular(AppShapes.xs),
      ),
      child: Text(
        text,
        style: AppTypography.status.copyWith(
          color: outlined ? color : color,
        ),
      ),
    );
  }

  /// Botón de acción con icono y texto
  static Widget actionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    Color? backgroundColor,
    Color? foregroundColor,
    bool outlined = false,
  }) {
    final style = outlined
        ? OutlinedButton.styleFrom(
            foregroundColor: foregroundColor ?? AppPalette.primary,
            side: BorderSide(color: foregroundColor ?? AppPalette.primary),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.buttonPadding,
            ),
          )
        : ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppPalette.primary,
            foregroundColor: foregroundColor ?? Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.buttonPadding,
            ),
          );

    return outlined
        ? OutlinedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
            style: style,
          )
        : ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
            style: style,
          );
  }

  /// Campo de información con icono
  static Widget infoField({
    required IconData icon,
    required String label,
    String? value,
    Color? iconColor,
    Color? textColor,
    bool compact = false,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: compact ? 14 : 16,
          color: iconColor ?? AppPalette.textSecondary,
        ),
        SizedBox(width: compact ? AppSpacing.xs : AppSpacing.sm),
        Expanded(
          child: Text(
            value ?? label,
            style:
                (compact ? AppTypography.bodySmall : AppTypography.bodyMedium)
                    .copyWith(color: textColor),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  /// Separador visual con texto opcional
  static Widget sectionDivider({String? title}) {
    return Column(
      children: [
        if (title != null) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Row(
              children: [
                Expanded(
                  child:
                      Divider(color: AppPalette.textDisabled.withOpacity(0.3)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Text(
                    title,
                    style: AppTypography.labelMedium.copyWith(
                      color: AppPalette.textSecondary,
                    ),
                  ),
                ),
                Expanded(
                  child:
                      Divider(color: AppPalette.textDisabled.withOpacity(0.3)),
                ),
              ],
            ),
          ),
        ] else ...[
          const Divider(color: AppPalette.textDisabled),
        ],
      ],
    );
  }
}
