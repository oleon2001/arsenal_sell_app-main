import '../../config/logger.dart';
import '../models/forms/form_response.dart';
import '../models/forms/form_template.dart';
import '../remote/supabase_client.dart';

class FormsRepository {
  final SupabaseService _supabase = SupabaseService();

  Future<List<FormTemplate>> getFormTemplates() async {
    try {
      // TODO: Implement get form templates
      return [];
    } catch (e) {
      logger.e('Get form templates error: $e');
      return [];
    }
  }

  Future<FormResponse> submitFormResponse(FormResponse response) async {
    try {
      // TODO: Implement submit form response
      return response;
    } catch (e) {
      logger.e('Submit form response error: $e');
      rethrow;
    }
  }

  Future<List<FormResponse>> getFormResponses({
    String? templateId,
    String? customerId,
    String? visitId,
  }) async {
    try {
      // TODO: Implement get form responses
      return [];
    } catch (e) {
      logger.e('Get form responses error: $e');
      return [];
    }
  }
}
