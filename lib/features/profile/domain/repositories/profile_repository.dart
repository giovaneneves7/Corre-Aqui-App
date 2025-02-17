import 'package:corre_aqui/api/supabase_api_client.dart';
import 'package:corre_aqui/features/profile/domain/models/profile.dart';
import 'package:corre_aqui/features/profile/domain/repositories/profile_repository_interface.dart';

class ProfileRepository implements ProfileRepositoryInterface{

	final SupabaseApiClient apiClient;

	ProfileRepository({required this.apiClient});

	@override
	Future<List<Profile>> getList() async {

		try{
		
			final data = await apiClient.getData('profiles');

			return data.map((store) {
		        
		    	return Store(
		    	  id: store['id'] as String,
		          name: store['name'] as String,
		          imageUrl: store['image_profile_url'] as String,
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

