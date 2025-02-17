import 'package:corre_aqui/api/supabase_api_client.dart';
import 'package:corre_aqui/features/profile/domain/models/profile.dart';
import 'package:corre_aqui/features/profile/domain/repositories/profile_repository_interface.dart';
import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:corre_aqui/features/zone/controllers/zone_controller.dart';
import 'package:get/get.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class ProfileRepository implements ProfileRepositoryInterface{

	final SupabaseApiClient apiClient;

	ProfileRepository({required this.apiClient});

	@override
	Future<void> addFavoriteStore(String userId, int storeId) async{

		final zoneId = Get.find<ZoneController>().selectedZone!.id;

		final body = {
			'user_id': userId,
			'store_id': storeId,
			'zone_id': zoneId,
		};

		await apiClient.postData('favorites', body);

	}

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
	Future<List<Store>> getFavoriteStores(String userId, String zoneId) async {
		try {
			// Chamando a função RPC no Supabase com o método rpc()
			final response = await Supabase.instance.client
					.rpc('get_favorite_stores', params: {
				'userId': userId,
				'zoneId': zoneId,
			});

			// Verificando se ocorreu algum erro
			if (response.error != null) {
				throw response.error!;
			}

			// Mapeando os dados de lojas para objetos Store
			List<Store> favoriteStores = (response.data as List).map<Store>((storeData) {
				return Store(
					id: storeData['store_id'] ?? 0,
					cnpj: storeData['cnpj'] ?? '',
					name: storeData['name'] ?? '',
					imageUrl: storeData['image_url'] ?? '',
					bannerUrl: storeData['banner_url'] ?? '',
					latitude: storeData['latitude'] ?? 0.0,
					longitude: storeData['longitude'] ?? 0.0,
				);
			}).toList();

			return favoriteStores;
		} catch (e) {
			print('Erro ao buscar lojas favoritas: $e');
			return [];
		}
	}

	@override
	Future<bool> isFavoriteStore(String userId, int storeId, String zoneId) async{

		try{

			final data = await apiClient.getData('favorites', filters: {
				'user_id': userId,
				'store_id': storeId,
				'zone_id' : zoneId,
			});

			return data.isNotEmpty;

		} catch(e){
			throw Exception('Erro ao verificar se a loja é favorita: $e');
		}

	}

	@override
	Future<void> removeFavoriteStore(String userId, int storeId) async{

		try{

			final filters = {
				'user_id': userId,
				'store_id': storeId,
			};

			await apiClient.deleteData('favorites', filters);

		} catch(e){
			throw Exception('Erro ao remover favorito: $e');
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

