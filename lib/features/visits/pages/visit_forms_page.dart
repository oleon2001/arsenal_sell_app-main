import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/palette.dart';

import '../bloc/visits_cubit.dart';

class VisitFormsPage extends StatefulWidget {
  const VisitFormsPage({
    super.key,
    required this.visitId,
  });
  final String visitId;

  @override
  State<VisitFormsPage> createState() => _VisitFormsPageState();
}

class _VisitFormsPageState extends State<VisitFormsPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Formularios de Visita'),
          actions: [
            TextButton(
              onPressed: () => context.push('/visit/photos/${widget.visitId}'),
              child: const Text(
                'Siguiente',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: BlocBuilder<VisitsCubit, VisitsState>(
          builder: (context, state) {
            return state.maybeWhen(
              activeVisit: (visit) =>
                  _buildFormContent(visit.customer?.name ?? 'Cliente'),
              orElse: () => const Center(child: CircularProgressIndicator()),
            );
          },
        ),
      );

  Widget _buildFormContent(String customerName) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Customer info
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.person, color: AppPalette.primary),
                      const SizedBox(width: 8),
                      Text(
                        customerName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Dynamic form fields
              _buildFormSection('Información General', [
                _buildTextFormField(
                  'observaciones',
                  'Observaciones',
                  maxLines: 3,
                ),
                _buildDropdownField(
                  'estado_cliente',
                  'Estado del Cliente',
                  ['Activo', 'Inactivo', 'Prospecto', 'Moroso'],
                ),
                _buildSwitchField(
                  'acepta_promociones',
                  'Acepta promociones',
                ),
              ]),

              _buildFormSection('Información Comercial', [
                _buildTextFormField(
                  'ultimo_pedido',
                  'Último Pedido',
                  keyboardType: TextInputType.datetime,
                ),
                _buildTextFormField(
                  'monto_promedio',
                  'Monto Promedio',
                  keyboardType: TextInputType.number,
                  prefix: '\$',
                ),
                _buildDropdownField(
                  'frecuencia_compra',
                  'Frecuencia de Compra',
                  ['Semanal', 'Quincenal', 'Mensual', 'Trimestral'],
                ),
              ]),

              _buildFormSection('Satisfacción', [
                _buildRatingField(
                  'satisfaccion_servicio',
                  'Satisfacción con el Servicio',
                ),
                _buildRatingField(
                  'satisfaccion_productos',
                  'Satisfacción con los Productos',
                ),
                _buildTextFormField(
                  'sugerencias',
                  'Sugerencias',
                  maxLines: 2,
                ),
              ]),

              const SizedBox(height: 32),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _saveAndContinue,
                  child: const Text('Continuar a Fotos'),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _buildFormSection(String title, List<Widget> fields) => Column(
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
          ...fields.map((field) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: field,
              )),
          const SizedBox(height: 16),
        ],
      );

  Widget _buildTextFormField(
    String key,
    String label, {
    TextInputType? keyboardType,
    int maxLines = 1,
    String? prefix,
  }) =>
      TextFormField(
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixText: prefix,
          border: const OutlineInputBorder(),
        ),
        onSaved: (value) => _formData[key] = value,
      );

  Widget _buildDropdownField(String key, String label, List<String> options) =>
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: options
            .map((option) => DropdownMenuItem(
                  value: option,
                  child: Text(option),
                ))
            .toList(),
        onChanged: (value) => _formData[key] = value,
      );

  Widget _buildSwitchField(String key, String label) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Switch(
            value: _formData[key] ?? false,
            onChanged: (value) {
              setState(() {
                _formData[key] = value;
              });
            },
          ),
        ],
      );

  Widget _buildRatingField(String key, String label) {
    final rating = _formData[key] ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        Row(
          children: List.generate(
              5,
              (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _formData[key] = index + 1;
                      });
                    },
                    child: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: AppPalette.warning,
                      size: 32,
                    ),
                  )),
        ),
      ],
    );
  }

  void _saveAndContinue() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      // TODO: Save form data
      context.push('/visit/photos/${widget.visitId}');
    }
  }
}
