import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:signature/signature.dart';
import '../../../core/theme/palette.dart';
import '../../../services/media/signature_service.dart';
import '../bloc/visits_cubit.dart';

class VisitSignaturePage extends StatefulWidget {
  const VisitSignaturePage({
    super.key,
    required this.visitId,
  });
  final String visitId;

  @override
  State<VisitSignaturePage> createState() => _VisitSignaturePageState();
}

class _VisitSignaturePageState extends State<VisitSignaturePage> {
  late SignatureController _signatureController;
  final _signerNameController = TextEditingController();
  Uint8List? _signatureData;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureService.createController();
  }

  @override
  void dispose() {
    _signatureController.dispose();
    _signerNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Firma del Cliente'),
          actions: [
            TextButton(
              onPressed: _signatureData != null ? _finishVisit : null,
              child: Text(
                'Finalizar',
                style: TextStyle(
                  color: _signatureData != null ? Colors.white : Colors.white54,
                ),
              ),
            ),
          ],
        ),
        body: BlocConsumer<VisitsCubit, VisitsState>(
          listener: (context, state) {
            state.whenOrNull(
              completed: (visit) {
                context.go('/dashboard');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Visita completada exitosamente'),
                    backgroundColor: AppPalette.success,
                  ),
                );
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
          builder: (context, state) => SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Instructions
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppPalette.info.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppPalette.info.withOpacity(0.3)),
                  ),
                  child: const Text(
                    'Solicita al cliente que firme en el área designada para confirmar la visita.',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppPalette.info,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),

                // Signer name
                const Text(
                  'Nombre del firmante',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _signerNameController,
                  decoration: const InputDecoration(
                    hintText: 'Nombre completo',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),

                // Signature pad
                const Text(
                  'Firma',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Signature(
                    controller: _signatureController,
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // Signature controls
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _clearSignature,
                        icon: const Icon(Icons.clear),
                        label: const Text('Limpiar'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _captureSignature,
                        icon: const Icon(Icons.check),
                        label: const Text('Capturar'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppPalette.success,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Preview signature
                if (_signatureData != null) ...[
                  const Text(
                    'Firma capturada',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppPalette.success),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.memory(
                      _signatureData!,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],

                // Finish visit button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: state.maybeWhen(
                      loading: () => null,
                      orElse: () =>
                          _signatureData != null ? _finishVisit : null,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPalette.success,
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
                        'Finalizar Visita',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Future<void> _captureSignature() async {
    try {
      final signatureData =
          await SignatureService.exportSignature(_signatureController);
      if (signatureData != null) {
        setState(() {
          _signatureData = signatureData;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Firma capturada exitosamente'),
            backgroundColor: AppPalette.success,
          ),
        );
      } else {
        _showError('Por favor, dibuja una firma antes de capturar');
      }
    } catch (e) {
      _showError('Error al capturar firma: $e');
    }
  }

  void _clearSignature() {
    _signatureController.clear();
    setState(() {
      _signatureData = null;
    });
  }

  void _finishVisit() {
    if (_signatureData == null) {
      _showError('Firma requerida para finalizar la visita');
      return;
    }

    if (_signerNameController.text.isEmpty) {
      _showError('Nombre del firmante requerido');
      return;
    }

    context.read<VisitsCubit>().finishVisit(
          visitId: widget.visitId,
          notes: 'Firmado por: ${_signerNameController.text}',
        );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppPalette.error,
      ),
    );
  }
}
