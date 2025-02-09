import 'package:corre_aqui/api/supabase_api_client.dart';
import 'package:corre_aqui/features/offer/domain/repositories/offer_repository_interface.dart';
import 'package:corre_aqui/features/offer/domain/models/offer.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class OfferRepository implements OfferRepositoryInterface{

	final SupabaseApiClient apiClient;

	OfferRepository({required this.apiClient});

	@override
  	Future<List<Offer>> getList() async {

	    try {
	      
	    	final data = await apiClient.getData('offers');

	      	return data.map((offer){

	      			return Offer(
	      				id: offer['id'] as int,
	      				name: offer['name'] as String,
	      				imageUrl: offer['image_url'] as String,
	      				originalPrice: offer['original_price'] as double,
	      				offerPrice: offer['offer_price'] as double,
	      				createdAt: DateTime.parse(offer['created_at'] as String),
	      				endDate: DateTime.parse(offer['end_date'] as String),
	      				storeId: offer['store_id'] as int,	
	      				categoryId: offer['category_id'] as int,
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