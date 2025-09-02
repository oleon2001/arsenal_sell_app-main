class Validators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email es requerido';
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Formato de email inválido';
    }

    return null;
  }

  // Phone validation
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Phone is usually optional
    }

    // Remove all non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length < 10) {
      return 'Teléfono debe tener al menos 10 dígitos';
    }

    if (digitsOnly.length > 15) {
      return 'Teléfono no puede tener más de 15 dígitos';
    }

    return null;
  }

  // Required field validation
  static String? validateRequired(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'Campo'} es requerido';
    }
    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contraseña es requerida';
    }

    if (value.length < 6) {
      return 'Contraseña debe tener al menos 6 caracteres';
    }

    return null;
  }

  // Numeric validation
  static String? validateNumeric(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'Campo'} es requerido';
    }

    if (double.tryParse(value) == null) {
      return '${fieldName ?? 'Campo'} debe ser un número válido';
    }

    return null;
  }

  // Positive number validation
  static String? validatePositiveNumber(String? value, [String? fieldName]) {
    final numericValidation = validateNumeric(value, fieldName);
    if (numericValidation != null) return numericValidation;

    final number = double.parse(value!);
    if (number <= 0) {
      return '${fieldName ?? 'Campo'} debe ser mayor que cero';
    }

    return null;
  }

  // Name validation
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nombre es requerido';
    }

    if (value.trim().length < 2) {
      return 'Nombre debe tener al menos 2 caracteres';
    }

    if (value.trim().length > 50) {
      return 'Nombre no puede tener más de 50 caracteres';
    }

    // Check for valid characters (letters, spaces, apostrophes, hyphens)
    final nameRegex = RegExp(r"^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ\s'-]+$");
    if (!nameRegex.hasMatch(value.trim())) {
      return 'Nombre contiene caracteres inválidos';
    }

    return null;
  }

  // Address validation
  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Address is usually optional
    }

    if (value.trim().length < 10) {
      return 'Dirección debe tener al menos 10 caracteres';
    }

    if (value.trim().length > 200) {
      return 'Dirección no puede tener más de 200 caracteres';
    }

    return null;
  }

  // Coordinates validation
  static String? validateLatitude(double? value) {
    if (value == null) return 'Latitud es requerida';
    if (value < -90 || value > 90) {
      return 'Latitud debe estar entre -90 y 90 grados';
    }
    return null;
  }

  static String? validateLongitude(double? value) {
    if (value == null) return 'Longitud es requerida';
    if (value < -180 || value > 180) {
      return 'Longitud debe estar entre -180 y 180 grados';
    }
    return null;
  }

  // Code validation (customer code, product SKU, etc.)
  static String? validateCode(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return null; // Code is usually optional
    }

    if (value.length < 2) {
      return '${fieldName ?? 'Código'} debe tener al menos 2 caracteres';
    }

    if (value.length > 20) {
      return '${fieldName ?? 'Código'} no puede tener más de 20 caracteres';
    }

    // Allow alphanumeric and some special characters
    final codeRegex = RegExp(r'^[a-zA-Z0-9\-_]+$');
    if (!codeRegex.hasMatch(value)) {
      return '${fieldName ?? 'Código'} solo puede contener letras, números, guiones y guiones bajos';
    }

    return null;
  }

  // Quantity validation
  static String? validateQuantity(String? value) =>
      validatePositiveNumber(value, 'Cantidad');

  // Price validation
  static String? validatePrice(String? value) =>
      validatePositiveNumber(value, 'Precio');

  // Notes validation
  static String? validateNotes(String? value, {int maxLength = 500}) {
    if (value == null || value.isEmpty) {
      return null; // Notes are usually optional
    }

    if (value.length > maxLength) {
      return 'Notas no pueden tener más de $maxLength caracteres';
    }

    return null;
  }

  // Date validation
  static String? validateDate(DateTime? value, [String? fieldName]) {
    if (value == null) {
      return '${fieldName ?? 'Fecha'} es requerida';
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final valueDate = DateTime(value.year, value.month, value.day);

    if (valueDate.isBefore(today)) {
      return '${fieldName ?? 'Fecha'} no puede ser anterior a hoy';
    }

    return null;
  }

  // URL validation
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null; // URL is usually optional
    }

    final urlRegex = RegExp(
        r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$');

    if (!urlRegex.hasMatch(value)) {
      return 'Formato de URL inválido';
    }

    return null;
  }

  // Custom validation combiner
  static String? validateMultiple(
      String? value, List<String? Function(String?)> validators) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) return result;
    }
    return null;
  }

  // File size validation
  static String? validateFileSize(int? fileSizeBytes, int maxSizeBytes) {
    if (fileSizeBytes == null) return 'Tamaño de archivo no disponible';

    if (fileSizeBytes > maxSizeBytes) {
      final maxSizeMB = (maxSizeBytes / (1024 * 1024)).toStringAsFixed(1);
      return 'Archivo debe ser menor a ${maxSizeMB}MB';
    }

    return null;
  }

  // Image file validation
  static String? validateImageFile(String? fileName) {
    if (fileName == null || fileName.isEmpty) {
      return 'Nombre de archivo requerido';
    }

    final allowedExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
    final extension = fileName.split('.').last.toLowerCase();

    if (!allowedExtensions.contains(extension)) {
      return 'Formato de imagen no válido. Use: ${allowedExtensions.join(', ')}';
    }

    return null;
  }

  // Geofence radius validation
  static String? validateGeofenceRadius(String? value) {
    final numericValidation = validatePositiveNumber(value, 'Radio');
    if (numericValidation != null) return numericValidation;

    final radius = double.parse(value!);
    if (radius < 5) {
      return 'Radio mínimo es 5 metros';
    }

    if (radius > 1000) {
      return 'Radio máximo es 1000 metros';
    }

    return null;
  }
}
