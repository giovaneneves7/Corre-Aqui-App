import 'package:corre_aqui/features/banner/domain/models/banner.dart';
import 'package:corre_aqui/features/banner/domain/repositories/banner_repository_interface.dart';
import 'package:corre_aqui/features/banner/domain/services/banner_service_interface.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class BannerService implements BannerServiceInterface{

	final BannerRepositoryInterface bannerRepositoryInterface;

	BannerService({required this.bannerRepositoryInterface});

	@override
  	Future<List<Banner>> getBannerList() async {
    	return await bannerRepositoryInterface.getList();
  	}


}