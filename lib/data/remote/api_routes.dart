class ApiRoutes {
  // Base endpoints
  static const String auth = '/auth/v1';
  static const String rest = '/rest/v1';
  static const String storage = '/storage/v1';
  static const String functions = '/functions/v1';

  // Auth endpoints
  static const String signIn = '$auth/token?grant_type=password';
  static const String signUp = '$auth/signup';
  static const String signOut = '$auth/logout';
  static const String refreshToken = '$auth/token?grant_type=refresh_token';
  static const String resetPassword = '$auth/recover';

  // User profile
  static const String profiles = '$rest/profiles';
  static String profile(String userId) => '$profiles?id=eq.$userId';

  // Companies and warehouses
  static const String companies = '$rest/companies';
  static const String warehouses = '$rest/warehouses';
  static String companyWarehouses(String companyId) =>
      '$warehouses?company_id=eq.$companyId';

  // Customers
  static const String customers = '$rest/customers';
  static String customerById(String id) => '$customers?id=eq.$id';
  static String customersByCompany(String companyId) =>
      '$customers?company_id=eq.$companyId';
  static String customersNearby(double lat, double lng, double radiusKm) =>
      '$customers?location=ov.CIRCLE(POINT($lng $lat),$radiusKm)';

  // Visits
  static const String visits = '$rest/visits';
  static String visitById(String id) => '$visits?id=eq.$id';
  static String visitsByCustomer(String customerId) =>
      '$visits?customer_id=eq.$customerId&order=started_at.desc';
  static String visitsByUser(String userId) =>
      '$visits?user_id=eq.$userId&order=started_at.desc';
  static String pendingVisits() => '$visits?finished_at=is.null';
  static String visitsByDateRange(String startDate, String endDate) =>
      '$visits?started_at=gte.$startDate&started_at=lte.$endDate';

  // Visit photos and signatures
  static const String visitPhotos = '$rest/visit_photos';
  static const String visitSignatures = '$rest/visit_signatures';
  static String visitPhotosByVisit(String visitId) =>
      '$visitPhotos?visit_id=eq.$visitId';
  static String visitSignatureByVisit(String visitId) =>
      '$visitSignatures?visit_id=eq.$visitId';

  // Products and pricing
  static const String products = '$rest/products';
  static const String priceLists = '$rest/price_lists';
  static const String prices = '$rest/prices';
  static String productsByCompany(String companyId) =>
      '$products?company_id=eq.$companyId&active=eq.true';
  static String pricesByList(String priceListId) =>
      '$prices?price_list_id=eq.$priceListId&select=*,product:products(*)';

  // Orders
  static const String orders = '$rest/orders';
  static const String orderItems = '$rest/order_items';
  static String orderById(String id) =>
      '$orders?id=eq.$id&select=*,customer:customers(*),items:order_items(*,product:products(*))';
  static String ordersByCustomer(String customerId) =>
      '$orders?customer_id=eq.$customerId&order=created_at.desc';
  static String ordersByUser(String userId) =>
      '$orders?user_id=eq.$userId&order=created_at.desc';
  static String orderItemsByOrder(String orderId) =>
      '$orderItems?order_id=eq.$orderId&select=*,product:products(*)';

  // Deliveries
  static const String deliveries = '$rest/deliveries';
  static String deliveriesByOrder(String orderId) =>
      '$deliveries?order_id=eq.$orderId';
  static String pendingDeliveries() =>
      '$deliveries?status=neq.DELIVERED&select=*,order:orders(*,customer:customers(*))';

  // Payments
  static const String payments = '$rest/payments';
  static String paymentsByCustomer(String customerId) =>
      '$payments?customer_id=eq.$customerId&order=paid_at.desc';
  static String paymentsByUser(String userId) =>
      '$payments?user_id=eq.$userId&order=paid_at.desc';

  // Returns
  static const String returns = '$rest/returns';
  static String returnsByOrder(String orderId) =>
      '$returns?order_id=eq.$orderId';

  // Routes and planning
  static const String routes = '$rest/routes';
  static const String routeStops = '$rest/route_stops';
  static String routeById(String id) =>
      '$routes?id=eq.$id&select=*,stops:route_stops(*,customer:customers(*))';
  static String routesByUser(String userId) =>
      '$routes?owner_id=eq.$userId&order=date.desc';
  static String routesByDate(String date) => '$routes?date=eq.$date';
  static String routeStopsByRoute(String routeId) =>
      '$routeStops?route_id=eq.$routeId&order=sequence&select=*,customer:customers(*)';

  // Tracking and geolocation
  static const String trackingLocations = '$rest/tracking_locations';
  static String trackingByUser(String userId, String? since) {
    String url = '$trackingLocations?user_id=eq.$userId&order=at.desc';
    if (since != null) {
      url += '&at=gte.$since';
    }
    return url;
  }

  static String realtimeLocations() =>
      '$trackingLocations?at=gte.${DateTime.now().subtract(const Duration(minutes: 30)).toIso8601String()}&order=at.desc';

  // Geofences
  static const String geofences = '$rest/geofences';
  static String geofencesByOwner(String ownerId) =>
      '$geofences?owner_id=eq.$ownerId';

  // Forms and surveys
  static const String formTemplates = '$rest/form_templates';
  static const String formResponses = '$rest/form_responses';
  static String formTemplatesByCompany(String companyId) =>
      '$formTemplates?company_id=eq.$companyId';
  static String formResponsesByTemplate(String templateId) =>
      '$formResponses?template_id=eq.$templateId';
  static String formResponsesByVisit(String visitId) =>
      '$formResponses?visit_id=eq.$visitId';

  // Promotions
  static const String promotions = '$rest/promotions';
  static String activePromotions() =>
      '$promotions?active=eq.true&starts_at=lte.${DateTime.now().toIso8601String()}&ends_at=gte.${DateTime.now().toIso8601String()}';

  // Audit logs
  static const String auditLogs = '$rest/audit_logs';
  static String auditLogsByEntity(String entity, String entityId) =>
      '$auditLogs?entity=eq.$entity&entity_id=eq.$entityId&order=created_at.desc';

  // Email queue
  static const String emailQueue = '$rest/email_queue';
  static String pendingEmails() => '$emailQueue?sent_at=is.null';

  // Storage endpoints
  static const String evidencePhotos = '$storage/object/evidence-photos';
  static const String signatures = '$storage/object/signatures';
  static const String documents = '$storage/object/documents';

  // File upload
  static String uploadFile(String bucket, String fileName) =>
      '$storage/object/$bucket/$fileName';
  static String downloadFile(String bucket, String fileName) =>
      '$storage/object/public/$bucket/$fileName';

  // Edge Functions
  static const String sendEmail = '$functions/send-email';
  static const String generateReport = '$functions/generate-report';
  static const String syncData = '$functions/sync-data';
  static const String calculateDistance = '$functions/calculate-distance';
  static const String validateGeofence = '$functions/validate-geofence';

  // RPC Functions
  static const String recalcOrderTotals = '$rest/rpc/recalc_order_totals';
  static const String enqueueVisitEmail = '$rest/rpc/enqueue_visit_email';

  // Query builders
  static String withSelect(String baseUrl, String select) {
    final separator = baseUrl.contains('?') ? '&' : '?';
    return '$baseUrl${separator}select=$select';
  }

  static String withFilter(String baseUrl, String filter) {
    final separator = baseUrl.contains('?') ? '&' : '?';
    return '$baseUrl$separator$filter';
  }

  static String withOrder(String baseUrl, String order) {
    final separator = baseUrl.contains('?') ? '&' : '?';
    return '$baseUrl${separator}order=$order';
  }

  static String withLimit(String baseUrl, int limit) {
    final separator = baseUrl.contains('?') ? '&' : '?';
    return '$baseUrl${separator}limit=$limit';
  }

  static String withRange(String baseUrl, int from, int to) {
    final separator = baseUrl.contains('?') ? '&' : '?';
    return '$baseUrl${separator}offset=$from&limit=${to - from + 1}';
  }

  // Real-time subscriptions
  static String realtimeChannel(String table) => 'realtime:$table';
  static String realtimeFilter(String column, String operator, String value) =>
      '$column=$operator.$value';
}
