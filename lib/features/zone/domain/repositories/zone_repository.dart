import 'package:corre_aqui/api/supabase_api_client.dart';
import 'package:corre_aqui/features/zone/domain/models/zone.dart';
import 'package:corre_aqui/features/zone/domain/repositories/zone_repository_interface.dart';

/**
 * @author Giovane Neves
 */
class ZoneRepository implements ZoneRepositoryInterface{

	final SupabaseApiClient apiClient;

	ZoneRepository({required this.apiClient});

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
		          radiusKm: zone['radius_km'] as double,
		        );

		     }).toList();

		} catch(e) {

			throw Exception('Erro ao buscar lista de zonas: $e');

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

