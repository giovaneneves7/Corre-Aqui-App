abstract class RatingsServiceInterface{

  Future addRating(storeId, value);
  Future getAverageRatingByStoreId(storeId);

}