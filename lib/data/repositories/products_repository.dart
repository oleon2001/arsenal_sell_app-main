import '../../config/logger.dart';
import '../models/products/product.dart';
import '../remote/supabase_client.dart';

class ProductsRepository {
  final SupabaseService _supabase = SupabaseService();

  /// Obtener todos los productos de la compañía
  Future<List<Product>> getProducts({String? companyId}) async {
    try {
      logger.i('🔍 Cargando productos...');
      final products = await _supabase.getProducts(companyId: companyId);
      logger.i('✅ ${products.length} productos cargados');
      return products;
    } catch (e) {
      logger.e('❌ Error cargando productos: $e');
      rethrow;
    }
  }

  /// Obtener producto por ID
  Future<Product?> getProductById(String id) async {
    try {
      logger.i('🔍 Obteniendo producto: $id');
      final product = await _supabase.getProductById(id);
      if (product != null) {
        logger.i('✅ Producto encontrado: ${product.name}');
      } else {
        logger.w('⚠️ Producto no encontrado: $id');
      }
      return product;
    } catch (e) {
      logger.e('❌ Error obteniendo producto: $e');
      return null;
    }
  }

  /// Buscar productos por nombre o SKU
  Future<List<Product>> searchProducts(String query) async {
    try {
      logger.i('🔍 Buscando productos: "$query"');
      final products = await _supabase.searchProducts(query);
      logger.i('✅ ${products.length} productos encontrados');
      return products;
    } catch (e) {
      logger.e('❌ Error buscando productos: $e');
      rethrow;
    }
  }

  /// Obtener precios de un producto
  Future<List<Price>> getProductPrices(String productId) async {
    try {
      logger.i('🔍 Obteniendo precios para producto: $productId');
      final prices = await _supabase.getProductPrices(productId);
      logger.i('✅ ${prices.length} precios encontrados');
      return prices;
    } catch (e) {
      logger.e('❌ Error obteniendo precios: $e');
      rethrow;
    }
  }

  /// Obtener lista de precios por defecto
  Future<PriceList?> getDefaultPriceList({String? companyId}) async {
    try {
      logger.i('🔍 Obteniendo lista de precios por defecto...');
      final priceList =
          await _supabase.getDefaultPriceList(companyId: companyId);
      if (priceList != null) {
        logger.i('✅ Lista de precios encontrada: ${priceList.name}');
      } else {
        logger.w('⚠️ No hay lista de precios por defecto');
      }
      return priceList;
    } catch (e) {
      logger.e('❌ Error obteniendo lista de precios: $e');
      return null;
    }
  }

  /// Crear nuevo producto
  Future<Product> createProduct(Product product) async {
    try {
      logger.i('🔍 Creando producto: ${product.name}');
      final createdProduct = await _supabase.createProduct(product);
      logger.i('✅ Producto creado: ${createdProduct.id}');
      return createdProduct;
    } catch (e) {
      logger.e('❌ Error creando producto: $e');
      rethrow;
    }
  }

  /// Actualizar producto
  Future<Product> updateProduct(Product product) async {
    try {
      logger.i('🔍 Actualizando producto: ${product.id}');
      final updatedProduct = await _supabase.updateProduct(product);
      logger.i('✅ Producto actualizado: ${updatedProduct.id}');
      return updatedProduct;
    } catch (e) {
      logger.e('❌ Error actualizando producto: $e');
      rethrow;
    }
  }

  /// Obtener productos con precios
  Future<List<ProductWithPrice>> getProductsWithPrices(
      {String? companyId}) async {
    try {
      logger.i('🔍 Cargando productos con precios...');
      final products = await getProducts(companyId: companyId);
      final defaultPriceList = await getDefaultPriceList(companyId: companyId);

      if (defaultPriceList == null) {
        logger.w('⚠️ No hay lista de precios por defecto');
        return products
            .map((p) => ProductWithPrice(product: p, price: null))
            .toList();
      }

      final productsWithPrices = <ProductWithPrice>[];

      for (final product in products) {
        final prices = await getProductPrices(product.id);
        final price = prices
            .where((p) => p.priceListId == defaultPriceList.id)
            .firstOrNull;

        productsWithPrices
            .add(ProductWithPrice(product: product, price: price));
      }

      logger.i('✅ ${productsWithPrices.length} productos con precios cargados');
      return productsWithPrices;
    } catch (e) {
      logger.e('❌ Error cargando productos con precios: $e');
      rethrow;
    }
  }
}

/// Clase helper para productos con precios
class ProductWithPrice {
  final Product product;
  final Price? price;

  ProductWithPrice({required this.product, this.price});

  /// Obtener precio formateado
  String get formattedPrice {
    if (price != null) {
      return '\$${price!.price.toStringAsFixed(2)}';
    }
    return 'Sin precio';
  }

  /// Verificar si tiene precio
  bool get hasPrice => price != null;

  /// Obtener precio como double
  double? get priceValue => price?.price;
}
