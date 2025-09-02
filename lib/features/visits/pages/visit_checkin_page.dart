import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';
import '../../../data/models/customers/customer.dart';
import '../../../data/models/visits/visit.dart';
import '../bloc/visits_cubit.dart';

class VisitCheckinPage extends StatefulWidget {
  const VisitCheckinPage({
    super.key,
    required this.customerId,
    this.purpose,
  });
  final String customerId;
  final String? purpose;

  @override
  State<VisitCheckinPage> createState() => _VisitCheckinPageState();
}

class _VisitCheckinPageState extends State<VisitCheckinPage> {
  final _notesController = TextEditingController();
  VisitPurpose _selectedPurpose = VisitPurpose.visita;
  Customer? _customer;

  @override
  void initState() {
    super.initState();
    _loadCustomer();
    if (widget.purpose != null) {
      _selectedPurpose = _parseVisitPurpose(widget.purpose!);
    }
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _loadCustomer() {
    // TODO: Load customer from repository
    _customer = Customer(
      id: widget.customerId,
      companyId: 'company_id',
      name: 'Cliente Ejemplo',
      address: 'Dirección del cliente',
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Iniciar Visita'),
        ),
        body: BlocConsumer<VisitsCubit, VisitsState>(
          listener: (context, state) {
            state.whenOrNull(
              activeVisit: (visit) {
                context.go('/visit/forms/${visit.id}');
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: AppPalette.error,
                  ),
                );
              },
            );
          },
          builder: (context, state) {
            if (_customer == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Customer info card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _customer!.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (_customer!.address != null) ...[
                            Row(
                              children: [
                                const Icon(Icons.location_on, size: 16),
                                const SizedBox(width: 4),
                                Expanded(child: Text(_customer!.address!)),
                              ],
                            ),
                            const SizedBox(height: 4),
                          ],
                          if (_customer!.phone != null) ...[
                            Row(
                              children: [
                                const Icon(Icons.phone, size: 16),
                                const SizedBox(width: 4),
                                Text(_customer!.phone!),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Purpose selection
                  const Text(
                    'Propósito de la visita',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<VisitPurpose>(
                    value: _selectedPurpose,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    items: VisitPurpose.values.map((purpose) {
                      return DropdownMenuItem(
                        value: purpose,
                        child: Text(_getVisitPurposeLabel(purpose)),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedPurpose = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  // Notes
                  const Text(
                    'Notas (opcional)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _notesController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Agregar notas sobre la visita...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Start visit button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: state.maybeWhen(
                        loading: () => null,
                        orElse: () => _startVisit,
                      ),
                      child: state.maybeWhen(
                        loading: () => const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                        orElse: () => const Text(
                          'Iniciar Visita',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );

  void _startVisit() {
    context.read<VisitsCubit>().startVisit(
          customer: _customer!,
          purpose: _selectedPurpose,
          notes:
              _notesController.text.isNotEmpty ? _notesController.text : null,
        );
  }

  VisitPurpose _parseVisitPurpose(String purpose) {
    switch (purpose.toLowerCase()) {
      case 'venta':
        return VisitPurpose.venta;
      case 'cobro':
        return VisitPurpose.cobro;
      case 'entrega':
        return VisitPurpose.entrega;
      case 'auditoria':
        return VisitPurpose.auditoria;
      case 'devolucion':
        return VisitPurpose.devolucion;
      default:
        return VisitPurpose.visita;
    }
  }

  String _getVisitPurposeLabel(VisitPurpose purpose) {
    switch (purpose) {
      case VisitPurpose.venta:
        return 'Venta';
      case VisitPurpose.cobro:
        return 'Cobro';
      case VisitPurpose.entrega:
        return 'Entrega';
      case VisitPurpose.visita:
        return 'Visita General';
      case VisitPurpose.auditoria:
        return 'Auditoría';
      case VisitPurpose.devolucion:
        return 'Devolución';
      case VisitPurpose.otro:
        return 'Otro';
    }
  }
}
