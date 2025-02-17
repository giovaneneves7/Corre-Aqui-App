import 'package:corre_aqui/features/profile/domain/models/profile.dart';
import 'package:corre_aqui/features/profile/domain/repositories/profile_repository_interface.dart';
import 'package:corre_aqui/features/profile/domain/services/profile_service_interface.dart';
import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:corre_aqui/features/zone/controllers/zone_controller.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/**
* Porfile entity's service
*
* @author Giovane Neves
* @since v0.0.1
*/
class ProfileService implements ProfileServiceInterface{

	final ProfileRepositoryInterface profileRepository;

	ProfileService({required this.profileRepository});

	@override
	Future<void> addFavoriteStore(storeId) async{

		final userId = Supabase.instance.client.auth.currentUser!.id;

		await this.profileRepository.addFavoriteStore(userId, storeId);

	}


	@override
	Future<List<Store>> getFavoriteStores() async{

		final userId = Supabase.instance.client.auth.currentUser!.id;
		final zoneId = Get.find<ZoneController>().selectedZone!.id;

		return await this.profileRepository.getFavoriteStores(userId, zoneId);

	}
	/**
	* @author Giovane Neves
	*/
	@override
	Future<List<Profile>> getProfileList() async{

		return await this.profileRepository.getList();

	}

	@override
	Future<bool> isFavoriteStore(final storeId) async{

		final userId = Supabase.instance.client.auth.currentUser!.id;
		final zoneId = Get.find<ZoneController>().selectedZone!.id;


		return await this.profileRepository.isFavoriteStore(userId, storeId, zoneId);

	}

  @override
  Future<void> removeFavoriteStore(storeId) async{

		final userId = Supabase.instance.client.auth.currentUser!.id;

		await this.profileRepository.removeFavoriteStore(userId, storeId);

  }

}