import 'package:corre_aqui/features/ratings/domain/services/ratings_service_interface.dart';
import 'package:get/get.dart';

class RatingsController extends GetxController implements GetxService{

  final RatingsServiceInterface ratingsService;

  double _averageRating = 0.0;
  double get averageRating => _averageRating;

  RatingsController({required this.ratingsService});

  Future<void> fetchAverageRating(int storeId) async {

    _averageRating = await ratingsService.getAverageRatingByStoreId(storeId);
    update();

  }

  Future<void> submitRating(int storeId, double value) async {
    try {
      await ratingsService.addRating(storeId, value.toInt());
      await fetchAverageRating(storeId);
    } catch (e) {
      Get.snackbar('Erro', e.toString());
    }
  }


}