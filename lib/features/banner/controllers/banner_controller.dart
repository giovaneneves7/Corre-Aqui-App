import 'package:corre_aqui/features/banner/domain/models/banner.dart';
import 'package:corre_aqui/features/banner/domain/services/banner_service_interface.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// @author Giovane Neves
/// @since v0.0.1
class BannerController extends GetxController implements GetxService {
	final BannerServiceInterface bannerServiceInterface;
	final _storage = GetStorage();

	bool _isLoading = false;
	List<Banner> _bannerList = [];
	List<Banner> get bannerList => _bannerList;

	BannerController({
		required this.bannerServiceInterface,
	});

	@override
	void onInit() {
		super.onInit();
		getBannerList();
	}

	Future<void> getBannerList({bool refresh = false}) async {
		if (_isLoading) return;
		_isLoading = true;

		if(!refresh){
			final cachedData = _storage.read<List>('cachedBanners');
			if (cachedData != null) {
				_bannerList = cachedData.map((e) => Banner.fromJson(e)).toList();
				update();
			}
		}

		try {

			final newBanners = await bannerServiceInterface.getBannerList();

			if(_hasChanges(newBanners)){
				_bannerList = newBanners;
				_storage.write('cachedBanners', _bannerList.map((e) => e.toJson()).toList());
				_storage.write('bannerTimestamp', DateTime.now().millisecondsSinceEpoch);
				update();
			}


		} catch (e){

			final cachedData = _storage.read<List>('cachedBanners');
			if (cachedData != null) {
				_bannerList = cachedData.map((e) => Banner.fromJson(e)).toList();
				update();
			}

		}finally {
			_isLoading = false;
		}
	}

	bool _hasChanges(List<Banner> newBanners) {
		return newBanners.length != _bannerList.length ||
				newBanners.any((banner) => !_bannerList.contains(banner));
	}


}