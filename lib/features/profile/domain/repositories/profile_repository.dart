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

			return data.map((profile) {
		        
		    	return Profile(
		    	  id: profile['id'] as String,
							memberCode: profile['member_code'] as String,
		          name: profile['name'] as String,
		          imageUrl: profile['profile_image_url'] as String,
		        );

		     }).toList();

		} catch(e) {

			throw Exception('Erro ao buscar lista de perfis: $e');

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

