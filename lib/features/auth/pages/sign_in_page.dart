import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
import '../../../core/theme/design_system.dart';
import '../bloc/auth_cubit.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController =
      TextEditingController(text: 'oswaldoleon72@gmail.com');
  final _passwordController = TextEditingController(text: '123456');
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: constraints.maxHeight * 0.05,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight -
                            (constraints.maxHeight * 0.1),
                      ),
                      child: IntrinsicHeight(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Logo y branding
                              _buildLogoSection(),
                              const SizedBox(height: AppSpacing.xl),

                              // Formulario de inicio de sesión
                              _buildSignInForm(),
                              const SizedBox(height: AppSpacing.lg),

                              // Botón de inicio de sesión
                              _buildSignInButton(),
                              const SizedBox(height: AppSpacing.lg),

                              // Enlaces adicionales
                              _buildAdditionalLinks(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      );

  Widget _buildLogoSection() {
    return Column(
      children: [
        // Logo principal
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            gradient: AppPalette.primaryGradient,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppPalette.primary.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.business_center,
            size: 60,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Título de la aplicación
        Text(
          'Arsenal Sell App',
          style: AppTypography.headline2.copyWith(
            color: AppPalette.primary,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),

        // Subtítulo
        Text(
          'Control de Fuerza de Ventas',
          style: AppTypography.bodyLarge.copyWith(
            color: AppPalette.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildSignInForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Título del formulario
        Text(
          'Iniciar Sesión',
          style: AppTypography.headline3.copyWith(
            color: AppPalette.textPrimary,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Ingresa tus credenciales para continuar',
          style: AppTypography.bodyMedium.copyWith(
            color: AppPalette.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),

        // Campo de email
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

        // Campo de contraseña
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Contraseña',
            hintText: 'Ingresa tu contraseña',
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
              return 'Por favor ingresa tu contraseña';
            }
            if (value.length < 6) {
              return 'La contraseña debe tener al menos 6 caracteres';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSignInButton() {
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
                  Text('Iniciando Sesión...', style: AppTypography.labelLarge),
                ],
              ),
            )
          : AppComponents.actionButton(
              icon: Icons.login,
              label: 'Iniciar Sesión',
              onPressed: _handleSignIn,
              backgroundColor: AppPalette.primary,
              foregroundColor: Colors.white,
            ),
    );
  }

  Widget _buildAdditionalLinks() {
    return Column(
      children: [
        // Enlace para recuperar contraseña
        TextButton(
          onPressed: () {
            // TODO: Implementar recuperación de contraseña
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Función próximamente disponible'),
                backgroundColor: AppPalette.info,
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
          child: Text(
            '¿Olvidaste tu contraseña?',
            style: AppTypography.bodyMedium.copyWith(
              color: AppPalette.primary,
            ),
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Separador
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Row(
            children: [
              Expanded(child: Divider(color: AppPalette.divider)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Text(
                  '¿Eres nuevo?',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppPalette.textSecondary,
                  ),
                ),
              ),
              Expanded(child: Divider(color: AppPalette.divider)),
            ],
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        // Botón de registro prominente
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppPalette.secondaryContainer,
            borderRadius: BorderRadius.circular(AppShapes.md),
            border: Border.all(
              color: AppPalette.secondary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.person_add,
                    color: AppPalette.secondary,
                    size: 24,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    '¿No tienes cuenta?',
                    style: AppTypography.labelLarge.copyWith(
                      color: AppPalette.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Crea tu cuenta para comenzar a gestionar ventas y entregas',
                style: AppTypography.bodySmall.copyWith(
                  color: AppPalette.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                width: double.infinity,
                child: AppComponents.actionButton(
                  icon: Icons.person_add,
                  label: 'Crear Cuenta',
                  onPressed: () => context.push('/sign-up'),
                  backgroundColor: AppPalette.secondary,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signIn(
            _emailController.text.trim(),
            _passwordController.text,
          );
    }
  }
}
