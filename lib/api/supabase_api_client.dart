import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseApiClient {
  final SupabaseClient client;
  final String authToken;
  final SharedPreferences sharedPreferences;

  SupabaseApiClient({
    required this.client,
    required this.authToken,
    required this.sharedPreferences,
  });

  // Método genérico para buscar dados
  Future<List<Map<String, dynamic>>> getData(String table, {Map<String, dynamic>? filters}) async {
    try {
      var query = client.from(table).select();
      filters?.forEach((key, value) {
        query = query.eq(key, value);
      });

      final response = await query; // Agora retorna os dados diretamente
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      throw Exception('Erro ao buscar dados: $e');
    }
  }

  // Método genérico para inserir dados
  Future<void> postData(String table, Map<String, dynamic> body) async {
    try {
      final response = await client.from(table).insert(body).select();
      if (response.isEmpty) {
        throw Exception('Erro ao inserir dados. Resposta vazia.');
      }
    } catch (e) {
      throw Exception('Erro ao inserir dados: $e');
    }
  }

  // Método genérico para atualizar dados
  Future<void> putData(String table, Map<String, dynamic> body, Map<String, dynamic> filters) async {
    try {
      var query = client.from(table).update(body);
      filters.forEach((key, value) {
        query = query.eq(key, value);
      });

      final response = await query;
      if (response.isEmpty) {
        throw Exception('Erro ao atualizar dados. Resposta vazia.');
      }
    } catch (e) {
      throw Exception('Erro ao atualizar dados: $e');
    }
  }

  // Método genérico para excluir dados
  Future<void> deleteData(String table, Map<String, dynamic> filters) async {
    try {
      var query = client.from(table).delete();
      filters.forEach((key, value) {
        query = query.eq(key, value);
      });

      final response = await query;
      if (response.isEmpty) {
        throw Exception('Erro ao excluir dados. Resposta vazia.');
      }
    } catch (e) {
      throw Exception('Erro ao excluir dados: $e');
    }
  }
}
