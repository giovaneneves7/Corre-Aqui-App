import 'package:corre_aqui/features/profile/domain/models/profile.dart';
import 'package:corre_aqui/features/store/domain/models/store.dart';

/**
*
* @author Giovane Neves
* @since v0.0.1
*/
abstract class ProfileServiceInterface{

	Future<void> addFavoriteStore(final storeId);
	Future<List<Store>> getFavoriteStores();
	Future<List<Profile>> getProfileList();
	Future<bool> isFavoriteStore(final storeId);
	Future<void> removeFavoriteStore(final storeId);

}