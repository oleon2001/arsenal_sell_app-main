import 'package:arsenal_sell_app/config/logger.dart';
import 'package:arsenal_sell_app/data/models/companies/company.dart';
import 'package:arsenal_sell_app/data/remote/supabase_client.dart';

class CompaniesRepository {
  final SupabaseService _supabase = SupabaseService();

  Future<List<Company>> getCompanies() async {
    try {
      final response = await _supabase.getCompanies();
      return response;
    } catch (e) {
      logger.e('Get companies error: $e');
      rethrow;
    }
  }

  Future<Company?> getCompanyById(String id) async {
    try {
      final companies = await getCompanies();
      return companies.where((c) => c.id == id).firstOrNull;
    } catch (e) {
      logger.e('Get company by ID error: $e');
      return null;
    }
  }
}
