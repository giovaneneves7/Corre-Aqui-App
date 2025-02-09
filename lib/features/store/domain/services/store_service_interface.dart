import 'package:corre_aqui/features/store/domain/models/store.dart';

abstract class StoreServiceInterface{

	Future<List<Store>> getStoreList();

}