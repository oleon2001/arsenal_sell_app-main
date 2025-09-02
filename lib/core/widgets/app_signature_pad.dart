import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import '../theme/palette.dart';

class AppSignaturePad extends StatefulWidget {
  const AppSignaturePad({
    super.key,
    required this.controller,
    this.title,
    this.height = 200,
  });
  final SignatureController controller;
  final String? title;
  final double height;

  @override
  State<AppSignaturePad> createState() => _AppSignaturePadState();
}

class _AppSignaturePadState extends State<AppSignaturePad> {
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            Text(
              widget.title!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
          ],
          Container(
            height: widget.height,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Signature(
              controller: widget.controller,
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
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
                  onPressed: _exportSignature,
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppPalette.success,
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  void _clearSignature() {
    widget.controller.clear();
  }

  Future<void> _exportSignature() async {
    if (widget.controller.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, dibuja una firma antes de guardar'),
          backgroundColor: AppPalette.warning,
        ),
      );
      return;
    }

    try {
      final signature = await widget.controller.toPngBytes();
      if (signature != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Firma guardada exitosamente'),
            backgroundColor: AppPalette.success,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al guardar firma: $e'),
          backgroundColor: AppPalette.error,
        ),
      );
    }
  }
}
