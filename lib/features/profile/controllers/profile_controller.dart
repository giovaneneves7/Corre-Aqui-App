import 'package:corre_aqui/features/profile/domain/models/profile.dart';
import 'package:corre_aqui/features/profile/domain/services/profile_service_interface.dart';
import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:get/get.dart';

/**
 * Controller da entidade Profile
 *
 * @author Giovane Neves
 * @since v0.0.1
 */
class ProfileController extends GetxController implements GetxService{

	final ProfileServiceInterface profileService;

	ProfileController({required this.profileService});

	List<Profile> _profiles = [];
	List<Profile> get profiles => _profiles;

	@override
	void onInit() {

	  super.onInit();
	  getProfileList();

	}

	Future<void> addFavoriteStore(final storeId) async{

		await this.profileService.addFavoriteStore(storeId);
		update();
	}

	Future<List<Store>> getFavoriteStores() async{

		return await this.profileService.getFavoriteStores();

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

}