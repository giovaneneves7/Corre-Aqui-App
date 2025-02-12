import 'package:corre_aqui/features/zone/domain/models/zone.dart';
import 'package:corre_aqui/features/zone/domain/repositories/zone_repository_interface.dart';
import 'package:corre_aqui/features/zone/domain/services/zone_service_interface.dart';

/**
* Zone entity's service
*
* @author Giovane Neves
* @since v0.0.1
*/
class ZoneService implements ZoneServiceInterface{

	final ZoneRepositoryInterface zoneRepository;

	StoreService({required this.zoneRepository});

	/**
	* @author Giovane Neves
	*/
	@override
	Future<List<Zone>> getZoneList() async{

		return await this.zoneRepository.getList();

	}

}