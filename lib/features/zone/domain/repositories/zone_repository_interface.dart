import 'package:corre_aqui/features/zone/domain/models/zone.dart';
import 'package:corre_aqui/interfaces/repository_interface.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
abstract class ZoneRepositoryInterface implements RepositoryInterface{

	@override
	Future getList();
	@override
	Future get(String? id);
	void saveZone(Zone zone);
}