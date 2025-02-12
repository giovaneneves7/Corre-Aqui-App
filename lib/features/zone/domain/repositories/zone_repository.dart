import 'package:corre_aqui/api/supabase_api_client.dart';
import 'package:corre_aqui/features/zone/domain/models/zone.dart';
import 'package:corre_aqui/features/zone/domain/repositories/zone_repository_interface.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ZoneRepository implements ZoneRepositoryInterface{

	final SupabaseApiClient apiClient;

	ZoneRepository({required this.apiClient});

	@override
	Future<List<Zone>> getList() async {

		try{
		
			final data = await apiClient.getData('zones');

			return data.map((store) {
		        
		    	return Store(
		    	  id: store['id'] as int,
		          cnpj: store['cnpj'] as String,
		          name: store['name'] as String,
		          imageUrl: store['image_url'] as String,
		          bannerUrl: store['banner_url'] as String?,
		        );

		     }).toList();

		} catch(e) {

			throw Exception('Erro ao buscar lista de lojas: $e');

		}

	}

	@override
  	Future add(value) {
    	throw UnimplementedError();
  	}

  	@override
  	Future delete(int? id) {
    	throw UnimplementedError();
  	}

  	@override
  	Future get(String? id) {
    	throw UnimplementedError();
  	}

  	@override
  	Future update(Map<String, dynamic> body, int? id) {
    	throw UnimplementedError();
  	}
	  
}

