import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
import '../../../core/theme/design_system.dart';
import '../bloc/auth_cubit.dart';
import '../../../data/models/auth/user_profile.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  UserRole _selectedRole = UserRole.vendedor;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Crear Cuenta',
              style: AppTypography.headline4.copyWith(
                color: Colors.white,
              )),
          backgroundColor: AppPalette.primary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            final stateType = state.runtimeType.toString();
            if (stateType == '_Authenticated') {
              context.go('/dashboard');
            } else if (stateType == '_Error') {
              final errorState = state as dynamic;
              setState(() => _isLoading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errorState.message),
                  backgroundColor: AppPalette.error,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            } else if (stateType == '_Loading') {
              setState(() => _isLoading = true);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header de bienvenida
                      _buildWelcomeHeader(),
                      const SizedBox(height: AppSpacing.xl),

                      // Formulario de registro
                      _buildRegistrationForm(),
                      const SizedBox(height: AppSpacing.lg),

                      // Términos y condiciones
                      _buildTermsAndConditions(),
                      const SizedBox(height: AppSpacing.lg),

                      // Botón de registro
                      _buildSignUpButton(),
                      const SizedBox(height: AppSpacing.md),

                      // Enlace para iniciar sesión
                      _buildSignInLink(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );

  Widget _buildWelcomeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icono y título
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppPalette.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppShapes.sm),
              ),
              child: Icon(
                Icons.person_add,
                color: AppPalette.primary,
                size: 32,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Únete a Arsenal Sell App',
                    style: AppTypography.headline3.copyWith(
                      color: AppPalette.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Crea tu cuenta para comenzar',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppPalette.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),

        // Descripción
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppPalette.primaryContainer,
            borderRadius: BorderRadius.circular(AppShapes.sm),
            border: Border.all(
              color: AppPalette.primary.withOpacity(0.2),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.info_outline,
                color: AppPalette.primary,
                size: 20,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Selecciona tu rol para acceder a las funcionalidades específicas de tu trabajo',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppPalette.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRegistrationForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Información Personal',
          style: AppTypography.headline4.copyWith(
            color: AppPalette.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        // Nombre completo
        TextFormField(
          controller: _fullNameController,
          decoration: InputDecoration(
            labelText: 'Nombre Completo',
            hintText: 'Ej: Juan Pérez García',
            prefixIcon: Icon(Icons.person, color: AppPalette.primary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppShapes.sm),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppShapes.sm),
              borderSide: BorderSide(color: AppPalette.primary, width: 2),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa tu nombre completo';
            }
            if (value.trim().split(' ').length < 2) {
              return 'Por favor ingresa tu nombre y apellido';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.md),

        // Email
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Correo Electrónico',
            hintText: 'ejemplo@empresa.com',
            prefixIcon: Icon(Icons.email, color: AppPalette.primary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppShapes.sm),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppShapes.sm),
              borderSide: BorderSide(color: AppPalette.primary, width: 2),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa tu correo electrónico';
            }
            if (!value.contains('@')) {
              return 'Por favor ingresa un correo válido';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.md),

        // Teléfono
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            labelText: 'Teléfono (Opcional)',
            hintText: '+58 412-123-4567',
            prefixIcon: Icon(Icons.phone, color: AppPalette.primary),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppShapes.sm),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppShapes.sm),
              borderSide: BorderSide(color: AppPalette.primary, width: 2),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Selección de rol
        Text(
          'Selecciona tu Rol',
          style: AppTypography.headline4.copyWith(
            color: AppPalette.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        Row(
          children: [
            Expanded(
              child: _buildRoleCard(
                role: UserRole.vendedor,
                title: 'Vendedor',
                description: 'Gestiona clientes y pedidos',
                icon: Icons.shopping_cart,
                color: AppPalette.vendedor,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildRoleCard(
                role: UserRole.repartidor,
                title: 'Repartidor',
                description: 'Gestiona entregas y rutas',
                icon: Icons.local_shipping,
                color: AppPalette.repartidor,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),

        // Contraseña
        Text(
          'Seguridad',
          style: AppTypography.headline4.copyWith(
            color: AppPalette.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),

        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            hintText: 'Mínimo 6 caracteres',
            prefixIcon: Icon(Icons.lock, color: AppPalette.primary),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                color: AppPalette.textSecondary,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppShapes.sm),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppShapes.sm),
              borderSide: BorderSide(color: AppPalette.primary, width: 2),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor ingresa una contraseña';
            }
            if (value.length < 6) {
              return 'La contraseña debe tener al menos 6 caracteres';
            }
            return null;
          },
        ),
        const SizedBox(height: AppSpacing.md),

        // Confirmar contraseña
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          decoration: InputDecoration(
            labelText: 'Confirmar Contraseña',
            hintText: 'Repite tu contraseña',
            prefixIcon: Icon(Icons.lock_outline, color: AppPalette.primary),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: AppPalette.textSecondary,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppShapes.sm),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppShapes.sm),
              borderSide: BorderSide(color: AppPalette.primary, width: 2),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor confirma tu contraseña';
            }
            if (value != _passwordController.text) {
              return 'Las contraseñas no coinciden';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildRoleCard({
    required UserRole role,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    final isSelected = _selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = role;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : AppPalette.surface,
          borderRadius: BorderRadius.circular(AppShapes.sm),
          border: Border.all(
            color: isSelected ? color : AppPalette.divider,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? color : AppPalette.textSecondary,
              size: 32,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              title,
              style: AppTypography.labelLarge.copyWith(
                color: isSelected ? color : AppPalette.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              description,
              style: AppTypography.bodySmall.copyWith(
                color: isSelected ? color : AppPalette.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      children: [
        Checkbox(
          value: _acceptTerms,
          onChanged: (value) {
            setState(() {
              _acceptTerms = value ?? false;
            });
          },
          activeColor: AppPalette.primary,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _acceptTerms = !_acceptTerms;
              });
            },
            child: RichText(
              text: TextSpan(
                style: AppTypography.bodyMedium.copyWith(
                  color: AppPalette.textSecondary,
                ),
                children: [
                  const TextSpan(text: 'Acepto los '),
                  TextSpan(
                    text: 'Términos y Condiciones',
                    style: TextStyle(
                      color: AppPalette.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(text: ' y la '),
                  TextSpan(
                    text: 'Política de Privacidad',
                    style: TextStyle(
                      color: AppPalette.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      child: _isLoading
          ? ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.buttonPadding,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text('Creando Cuenta...', style: AppTypography.labelLarge),
                ],
              ),
            )
          : ElevatedButton(
              onPressed: _acceptTerms ? _handleSignUp : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _acceptTerms ? AppPalette.primary : AppPalette.textDisabled,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.buttonPadding,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person_add, color: Colors.white),
                  const SizedBox(width: AppSpacing.sm),
                  Text('Crear Cuenta', style: AppTypography.labelLarge),
                ],
              ),
            ),
    );
  }

  Widget _buildSignInLink() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '¿Ya tienes cuenta? ',
            style: AppTypography.bodyMedium.copyWith(
              color: AppPalette.textSecondary,
            ),
          ),
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Inicia Sesión',
              style: AppTypography.bodyMedium.copyWith(
                color: AppPalette.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      if (!_acceptTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Debes aceptar los términos y condiciones'),
            backgroundColor: AppPalette.warning,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      context.read<AuthCubit>().signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            fullName: _fullNameController.text.trim(),
            phone: _phoneController.text.trim().isEmpty
                ? null
                : _phoneController.text.trim(),
            role: _selectedRole,
          );
    }
  }
}
