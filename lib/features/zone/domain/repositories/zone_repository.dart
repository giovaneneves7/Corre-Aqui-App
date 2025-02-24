import 'package:corre_aqui/api/supabase_api_client.dart';
import 'package:corre_aqui/features/zone/domain/models/zone.dart';
import 'package:corre_aqui/features/zone/domain/repositories/zone_repository_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * @author Giovane Neves
 */
class ZoneRepository implements ZoneRepositoryInterface{

	final SupabaseApiClient apiClient;
	final SharedPreferences sharedPreferences;

	ZoneRepository({required this.apiClient, required this.sharedPreferences});

	@override
	Future<List<Zone>> getList() async {

		try{

			final data = await apiClient.getData('zones');

			return data.map((zone) {
		        
		    	return Zone(
		    	  id: zone['id'] as String,
		          name: zone['name'] as String,
		          latitude: zone['latitude'] as double,
		          longitude: zone['longitude'] as double,
		          radiusKm: zone['radius_km'] as int,
		        );

		     }).toList();

		} catch(e) {

			throw Exception('Erro ao buscar lista de zonas: $e');

		}

	}

	@override
	void saveZone(Zone zone) {

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
  	Future get(String? id) async{

			if (id == null) return null;

			try {
				final data = await apiClient.getData('zones', filters: {'id': id});

				if (data.isEmpty) return null;

				final zone = data.first;

				return Zone(
					id: zone['id'] as String,
					name: zone['name'] as String,
					latitude: zone['latitude'] as double,
					longitude: zone['longitude'] as double,
					radiusKm: zone['radius_km'] as int,
				);
			} catch (e) {
				throw Exception('Erro ao buscar zona por ID: $e');
			}

  	}

  	@override
  	Future update(Map<String, dynamic> body, int? id) {
    	throw UnimplementedError();
  	}


	  
}

