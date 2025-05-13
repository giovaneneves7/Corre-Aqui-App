import 'package:corre_aqui/features/profile/domain/models/profile.dart';
import 'package:corre_aqui/features/profile/domain/services/profile_service_interface.dart';
import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:corre_aqui/util/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// Controller da entidade Profile
///
/// @author Giovane Neves
/// @since v0.0.1
class ProfileController extends GetxController implements GetxService{

	final ProfileServiceInterface profileService;
	final _storage = GetStorage();

	ProfileController({required this.profileService});

	bool _isLoading = false;
	List<Store> _favoriteStores = [];
	List<Store> get favoriteStores => _favoriteStores;
	List<Profile> _profiles = [];
	List<Profile> get profiles => _profiles;

	@override
	void onInit() {

	  super.onInit();
	  getProfileList();
		getFavoriteStores();

	}

	Future<void> addFavoriteStore(final storeId) async{

		await this.profileService.addFavoriteStore(storeId);
		update();
	}

	Future<void> getFavoriteStores({bool refresh = false}) async{

		if(_isLoading) return;
		_isLoading = true;
		update();


		if(!refresh){

			getCachedData();

		}

		try {

			final favoriteStores = await this.profileService.getFavoriteStores();

			if(_hasChanges(favoriteStores)){
				_favoriteStores = favoriteStores;
				_storage.write(Constants.cachedFavoriteStores, _favoriteStores.map((e) => e.toJson()).toList());
				_storage.write(Constants.cachedFavoriteStoresTimestamp, DateTime.now().millisecondsSinceEpoch);
				update();
			}


		} catch (e) {

			getCachedData();

		} finally{
			_isLoading = false;
			update();
		}

	}

	void getCachedData(){

		final cachedData = _storage.read<List>(Constants.cachedFavoriteStores);
		if(cachedData != null){
			_favoriteStores = cachedData.map((e) => Store.fromJson(e)).toList();
			update();
		}

	}
	bool _hasChanges(List<Store> newFavoriteStores) {
		return newFavoriteStores.length != _favoriteStores.length ||
				newFavoriteStores.any((banner) => !_favoriteStores.contains(banner));
	}


	Profile getProfileByUserId(userId){

			return _profiles.firstWhere((profile) => profile.id == userId);


	}
	Future<void> getProfileList() async{

		_profiles = await profileService.getProfileList();
		update();

	}

	Future<bool> isFavoriteStore(final storeId) async{

		return await profileService.isFavoriteStore(storeId);

	}

	Future<void> removeFavoriteStore(final storeId) async{

		await profileService.removeFavoriteStore(storeId);
		update();

	}

	Future<void> updateProfile(String name, String phone, String imageUrl) async{

		await profileService.updateProfile(name, phone, imageUrl);
		update();

	}


}