import 'package:corre_aqui/api/supabase_api_client.dart';
import 'package:corre_aqui/features/event/domain/models/event.dart';
import 'package:corre_aqui/features/event/domain/repositories/event_repository_interface.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class EventRepository implements EventRepositoryInterface{

	final SupabaseApiClient apiClient;

	EventRepository({required this.apiClient});

	@override
  	Future<List<Event>> getList() async {

	    try {
	      
	    	final data = await apiClient.getData('events');

	      	return data.map((event){

	      			return Event(
	      				id: event['id'] as String,
	      				imageUrl: event['image_url'] as String,
	      				name: event['name'] as String,
	      				location: event['location'] as String,
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