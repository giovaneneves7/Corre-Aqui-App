import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:corre_aqui/features/store/domain/repositories/store_repository_interface.dart';
import 'package:corre_aqui/features/store/domain/services/store_service_interface.dart';

/**
* Store entity's service
*
* @author Giovane Neves
* @since v0.0.1
*/
class StoreService implements StoreServiceInterface{

	final StoreRepositoryInterface storeRepository;

	StoreService({required this.storeRepository});

	/**
	* @author Giovane Neves
	*/
	@override
	Future<List<Store>> getStoreList() async{

		return await this.storeRepository.getList();

	}

}