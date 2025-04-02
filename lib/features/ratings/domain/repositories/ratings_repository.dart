import 'package:corre_aqui/api/supabase_api_client.dart';
import 'package:corre_aqui/features/ratings/domain/models/rating.dart';
import 'package:corre_aqui/features/ratings/domain/repositories/ratings_repository_interface.dart';
import 'package:corre_aqui/util/constants.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class RatingsRepository implements RatingsRepositoryInterface{

  final SupabaseApiClient apiClient;

  RatingsRepository({required this.apiClient});
  
  @override
  Future<void> addRating(Rating rating) async {
    try {

      final data = {
        'user_id' : rating.profileId,
        'store_id' : rating.storeId,
        'rating' : rating.value
      };

      await apiClient.postData(Constants.ratings, data);
    } catch (e) {
      throw _handleError(e);
    }

  }

  @override
  Future add(value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(int? id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String? id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future getList() {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int? id) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<double> getAverageRatingByStoreId(storeId) async{

    final ratings = await apiClient.getData(
        Constants.ratings,
        filters: {'store_id' : storeId}
    );

    if(ratings.isEmpty) return 0.0;

    final total = ratings
        .map((r) => r['rating'] as int)
        .reduce((sum, rating) => sum + rating);

    return total / ratings.length;

  }



  dynamic _handleError(dynamic e) {
    if (e is PostgrestException && e.code == '23505') {
      return Exception('Você já avaliou esta loja');
    }
    return e;
  }

}