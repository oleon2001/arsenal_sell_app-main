import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/theme/palette.dart';
import '../../../core/utils/uuid_generator.dart';
import '../../../data/models/customers/customer.dart';
import '../../../data/models/companies/company.dart';
import '../../../data/repositories/companies_repository.dart';
import '../../../services/location/location_service.dart';
import '../bloc/customers_cubit.dart';

class CustomerFormPage extends StatefulWidget {
  const CustomerFormPage({
    super.key,
    this.customerId,
  });
  final String? customerId;

  @override
  State<CustomerFormPage> createState() => _CustomerFormPageState();
}

class _CustomerFormPageState extends State<CustomerFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  bool _isLocationSet = false;
  double? _latitude;
  double? _longitude;
  bool _isLoadingLocation = false;

  // Company selection
  Company? _selectedCompany;
  List<Company> _companies = [];
  bool _isLoadingCompanies = false;

  bool get _isEditing => widget.customerId != null;

  @override
  void initState() {
    super.initState();
    _loadCompanies();
    if (_isEditing) {
      _loadCustomer();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _loadCompanies() async {
    setState(() {
      _isLoadingCompanies = true;
    });

    try {
      final companiesRepository = CompaniesRepository();
      final companies = await companiesRepository.getCompanies();
      setState(() {
        _companies = companies;
        // Seleccionar la primera compañía por defecto
        if (companies.isNotEmpty) {
          _selectedCompany = companies.first;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al cargar compañías: $e'),
          backgroundColor: AppPalette.error,
        ),
      );
    } finally {
      setState(() {
        _isLoadingCompanies = false;
      });
    }
  }

  void _loadCustomer() {
    // TODO: Load customer data for editing
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(_isEditing ? 'Editar Cliente' : 'Nuevo Cliente'),
          actions: [
            TextButton(
              onPressed: _saveCustomer,
              child: const Text(
                'Guardar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: BlocConsumer<CustomersCubit, CustomersState>(
          listener: (context, state) {
            if (state is CustomersLoaded) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      _isEditing ? 'Cliente actualizado' : 'Cliente creado'),
                  backgroundColor: AppPalette.success,
                ),
              );
            } else if (state.runtimeType.toString() == '_Error') {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text((state as dynamic).message),
                  backgroundColor: AppPalette.error,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Basic info section
                    _buildSection(
                      'Información Básica',
                      [
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nombre *',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'Nombre es requerido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _codeController,
                          decoration: const InputDecoration(
                            labelText: 'Código',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),

                    // Company selection section
                    _buildSection(
                      'Compañía',
                      [
                        if (_isLoadingCompanies)
                          const Center(
                            child: CircularProgressIndicator(),
                          )
                        else if (_companies.isEmpty)
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppPalette.warning.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppPalette.warning),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.warning, color: AppPalette.warning),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'No hay compañías disponibles. Contacta al administrador.',
                                    style: TextStyle(color: AppPalette.warning),
                                  ),
                                ),
                              ],
                            ),
                          )
                        else ...[
                          DropdownButtonFormField<Company>(
                            value: _selectedCompany,
                            decoration: const InputDecoration(
                              labelText: 'Compañía *',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.business),
                            ),
                            items: _companies.map((Company company) {
                              return DropdownMenuItem<Company>(
                                value: company,
                                child: Text(company.name),
                              );
                            }).toList(),
                            onChanged: (Company? newValue) {
                              setState(() {
                                _selectedCompany = newValue;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Debes seleccionar una compañía';
                              }
                              return null;
                            },
                          ),
                          if (_selectedCompany != null) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppPalette.primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppPalette.primary),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.business,
                                    color: AppPalette.primary,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Compañía seleccionada:',
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppPalette.textSecondary,
                                          ),
                                        ),
                                        Text(
                                          _selectedCompany!.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppPalette.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ],
                    ),

                    // Contact info section
                    _buildSection(
                      'Información de Contacto',
                      [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value?.isNotEmpty == true) {
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value!)) {
                                return 'Email inválido';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            labelText: 'Teléfono',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),

                    // Address section
                    _buildSection(
                      'Dirección y Ubicación',
                      [
                        TextFormField(
                          controller: _addressController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            labelText: 'Dirección',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Location section
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _isLocationSet
                                ? AppPalette.success.withOpacity(0.1)
                                : AppPalette.warning.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: _isLocationSet
                                  ? AppPalette.success
                                  : AppPalette.warning,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    _isLocationSet
                                        ? Icons.location_on
                                        : Icons.location_off,
                                    color: _isLocationSet
                                        ? AppPalette.success
                                        : AppPalette.warning,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _isLocationSet
                                        ? 'Ubicación configurada'
                                        : 'Ubicación no configurada',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: _isLocationSet
                                          ? AppPalette.success
                                          : AppPalette.warning,
                                    ),
                                  ),
                                ],
                              ),
                              if (_isLocationSet) ...[
                                const SizedBox(height: 8),
                                Text(
                                  'Lat: ${_latitude?.toStringAsFixed(6)}\nLng: ${_longitude?.toStringAsFixed(6)}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppPalette.textSecondary,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 12),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: _isLoadingLocation
                                      ? null
                                      : _getCurrentLocation,
                                  icon: _isLoadingLocation
                                      ? const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2),
                                        )
                                      : const Icon(Icons.my_location),
                                  label: Text(_isLoadingLocation
                                      ? 'Obteniendo...'
                                      : 'Obtener Ubicación Actual'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppPalette.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Save button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: state.runtimeType.toString() == '_Loading'
                            ? null
                            : _saveCustomer,
                        child: state.runtimeType.toString() == '_Loading'
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : Text(
                                _isEditing
                                    ? 'Actualizar Cliente'
                                    : 'Crear Cliente',
                                style: const TextStyle(fontSize: 16),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );

  Widget _buildSection(String title, List<Widget> children) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppPalette.primary,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
          const SizedBox(height: 24),
        ],
      );

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      final position = await LocationService().getCurrentLocation();
      if (position != null) {
        setState(() {
          _latitude = position.latitude;
          _longitude = position.longitude;
          _isLocationSet = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ubicación obtenida exitosamente'),
            backgroundColor: AppPalette.success,
          ),
        );
      } else {
        throw Exception('No se pudo obtener la ubicación');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al obtener ubicación: $e'),
          backgroundColor: AppPalette.error,
        ),
      );
    } finally {
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  void _saveCustomer() {
    if (_formKey.currentState?.validate() ?? false) {
      final customer = Customer(
        id: widget.customerId ?? UuidGenerator.generateFromNow(),
        companyId:
            _selectedCompany?.id ?? 'current_company_id', // TODO: Get from auth
        code: _codeController.text.isNotEmpty ? _codeController.text : null,
        name: _nameController.text,
        email: _emailController.text.isNotEmpty ? _emailController.text : null,
        phone: _phoneController.text.isNotEmpty ? _phoneController.text : null,
        address:
            _addressController.text.isNotEmpty ? _addressController.text : null,
        latitude: _latitude,
        longitude: _longitude,
      );

      context.read<CustomersCubit>().createCustomer(customer);
    }
  }
}
