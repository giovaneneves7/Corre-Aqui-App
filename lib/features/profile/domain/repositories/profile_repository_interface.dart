import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:corre_aqui/interfaces/repository_interface.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
abstract class ProfileRepositoryInterface implements RepositoryInterface{

	@override
	Future getList();
	Future<void> addFavoriteStore(String userId, int storeId);
	Future<List<Store>> getFavoriteStores(String userId, String zoneId);
	Future<bool> isFavoriteStore(String userId, int storeId, String zoneId);
	Future<void> removeFavoriteStore(String userId, int storeId);
}