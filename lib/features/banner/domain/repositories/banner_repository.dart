import 'package:corre_aqui/api/supabase_api_client.dart';
import 'package:corre_aqui/features/banner/domain/models/banner.dart';
import 'package:corre_aqui/features/banner/domain/repositories/banner_repository_interface.dart';
import 'package:get/get.dart';

class BannerRepository implements BannerRepositoryInterface {

	final SupabaseApiClient apiClient;

	BannerRepository({required this.apiClient});
	
	@override
  	Future<List<Banner>> getList() async {

	    try {
	      
	    	final data = await apiClient.getData('banners');

	      	return data.map((banner){

	      			return Banner(
	      				id: banner['id'] as String,
	      				imageUrl: banner['image_url'] as String,
	      				name: banner['name'] as String?,
	      				description: banner['description'] as String?
	      			);

	      	}).toList();
	    
	    } catch (e) {
	      throw Exception('Erro ao buscar lista de banners: $e');
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