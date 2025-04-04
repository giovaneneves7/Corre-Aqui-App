import 'package:corre_aqui/features/ratings/domain/models/rating.dart';
import 'package:corre_aqui/features/ratings/domain/repositories/ratings_repository_interface.dart';
import 'package:corre_aqui/features/ratings/domain/services/ratings_service_interface.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class RatingsService implements RatingsServiceInterface{

  final RatingsRepositoryInterface ratingsRepository;

  RatingsService({required this.ratingsRepository});

  @override
  Future addRating(storeId, value) async{

    final userId = Supabase.instance.client.auth.currentUser!.id;

    return await this.ratingsRepository.addRating(Rating(profileId: userId, storeId: storeId, value: value));

  }
  @override
  Future<double> getAverageRatingByStoreId(storeId) async{


    return await this.ratingsRepository.getAverageRatingByStoreId(storeId);

  }


}