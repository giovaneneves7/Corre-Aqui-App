import 'package:corre_aqui/features/banner/domain/models/banner.dart';

abstract class BannerServiceInterface {
	
	Future<List<Banner>> getBannerList();

}