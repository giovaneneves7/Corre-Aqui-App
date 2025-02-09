import 'package:corre_aqui/features/banner/domain/models/banner.dart';
import 'package:corre_aqui/features/banner/domain/services/banner_service_interface.dart';
import 'package:get/get.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class BannerController extends GetxController implements GetxService {


	final BannerServiceInterface bannerServiceInterface;

	BannerController({required this.bannerServiceInterface});


	List<Banner> _bannerList = [];
	List<Banner> get bannerList => _bannerList;

	@override
	void onInit() {

	  super.onInit();
	  getBannerList();

	}

	Future<void> getBannerList() async{

		try {
      		_bannerList = await bannerServiceInterface.getBannerList();
      		update();
    	} catch (e) {
      		print('Erro ao buscar banners: $e');
    	}

	}

}