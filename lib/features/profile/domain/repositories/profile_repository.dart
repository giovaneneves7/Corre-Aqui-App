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
			// 1. Buscar os store_id na tabela de associações
			final response = await Supabase.instance.client
					.from('associacoes')
					.select('store_id')
					.eq('user_id', userId)
					.eq('zone_id', zoneId);

			if (response.isEmpty) {
				return [];
			}

			List<int> storeIds = response.map<int>((e) => e['store_id'] as int).toList();

			if (storeIds.isEmpty) {
				return [];
			}

			// 2. Buscar os detalhes das lojas com os store_id encontrados
			final storesResponse = await Supabase.instance.client
					.from('stores') // Substitua pelo nome da tabela de lojas
					.select('*')
					.inFilter('id', storeIds); // Usando `inFilter` em vez de `in_`

			if (storesResponse.isEmpty) {
				return [];
			}

			List<Store> stores = storesResponse.map<Store>((storeData) {
				return Store(
					id: storeData['id'] as int,
					cnpj: storeData['cnpj'] as String,
					name: storeData['name'] as String,
					imageUrl: storeData['image_url'] as String,
					bannerUrl: storeData['banner_url'] as String,
					latitude: storeData['latitude'] as double,
					longitude: storeData['longitude'] as double,
				);
			}).toList();

			return stores;
		} catch (e) {
			rethrow;
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

