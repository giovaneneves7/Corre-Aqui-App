import 'package:corre_aqui/api/supabase_api_client.dart';
import 'package:corre_aqui/features/ratings/domain/repositories/ratings_repository_interface.dart';
import 'package:corre_aqui/features/ratings/domain/services/ratings_service_interface.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class RatingsService implements RatingsServiceInterface{

  final RatingsRepositoryInterface ratingsRepository;

  RatingsService({required this.ratingsRepository});

  @override
  Future addRating(storeId, value) async{

  }
  @override
  Future<double> getAverageRatingByStoreId(storeId) async{

    return await this.ratingsRepository.getAverageRatingByStoreId(storeId);

  }


}