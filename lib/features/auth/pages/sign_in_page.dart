import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(errorState.message),
                  backgroundColor: AppPalette.error,
                ),
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
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
                              // Logo
                              Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: AppPalette.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.business_center,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 24),

                              // Title
                              const Text(
                                'Arsenal Sell App',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppPalette.primary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Control de Fuerza de Ventas',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppPalette.textSecondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 32),

                              // Email Field
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email_outlined),
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Email es requerido';
                                  }
                                  if (!RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value!)) {
                                    return 'Email inválido';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              // Password Field
                              TextFormField(
                                controller: _passwordController,
                                obscureText: _obscurePassword,
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  prefixIcon: const Icon(Icons.lock_outlined),
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value?.isEmpty ?? true) {
                                    return 'Contraseña es requerida';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),

                              // Sign In Button
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton(
                                  onPressed:
                                      state.runtimeType.toString() == '_Loading'
                                          ? null
                                          : _signIn,
                                  child: state.runtimeType.toString() ==
                                          '_Loading'
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          ),
                                        )
                                      : const Text(
                                          'Iniciar Sesión',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                ),
                              ),
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

  void _signIn() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().signIn(
            _emailController.text.trim(),
            _passwordController.text,
          );
    }
  }
}
