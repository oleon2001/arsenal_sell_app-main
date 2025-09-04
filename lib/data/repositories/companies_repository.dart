import '../../config/logger.dart';
import '../models/companies/company.dart';
import '../remote/supabase_client.dart';

class CompaniesRepository {
  final SupabaseService _supabase = SupabaseService();

  Future<List<Company>> getCompanies() async {
    try {
      logger.i('🏢 CompaniesRepository: Iniciando carga de compañías...');
      final response = await _supabase.getCompanies();
      logger.i('🏢 CompaniesRepository: ${response.length} compañías cargadas');
      return response;
    } catch (e) {
      logger.e('🏢 CompaniesRepository error: $e');
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

  Future<Company> createCompany(Company company) async {
    try {
      final response = await _supabase.createCompany(company);
      return response;
    } catch (e) {
      logger.e('Create company error: $e');
      rethrow;
    }
  }
}
