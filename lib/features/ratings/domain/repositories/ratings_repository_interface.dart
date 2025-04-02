import 'package:corre_aqui/features/ratings/domain/models/rating.dart';
import 'package:corre_aqui/interfaces/repository_interface.dart';

/// @author Giovane Neves
/// @since v0.0.1
abstract class RatingsRepositoryInterface implements RepositoryInterface{

  Future<void> addRating(Rating rating);
  @override
  Future getList();
  Future getAverageRatingByStoreId(storeId);

}