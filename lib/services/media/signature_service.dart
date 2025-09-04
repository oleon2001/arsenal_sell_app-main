import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import '../../config/logger.dart';

class SignatureService {
  static Future<Uint8List?> exportSignature(
      SignatureController controller) async {
    try {
      if (controller.isEmpty) {
        return null;
      }

      final image = await controller.toPngBytes(
        height: 300,
        width: 600,
      );

      return image;
    } catch (e) {
      logger.e('Export signature error: $e');
      return null;
    }
  }

  static SignatureController createController() => SignatureController(
        penStrokeWidth: 2,
        exportBackgroundColor: Colors.white,
      );

  static Widget buildSignaturePad(SignatureController controller) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Signature(
          controller: controller,
          backgroundColor: Colors.white,
          height: 200,
        ),
      );
}
