import 'package:supabase_flutter/supabase_flutter.dart';

class ProductService {
  final SupabaseClient _client = Supabase.instance.client;

  // Récupérer tous les maillots
  Future<List<Map<String, dynamic>>> getProducts() async {
    final response = await _client.from('products').select('*');
    return List<Map<String, dynamic>>.from(response);
  }

  // Récupérer un maillot par ID
  Future<Map<String, dynamic>> getProductById(String id) async {
    final response = await _client.from('products').select().eq('id', id).single();
    return response;
  }
}