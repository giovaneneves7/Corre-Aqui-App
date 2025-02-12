import 'package:corre_aqui/features/zone/domain/models/zone.dart';
import 'package:corre_aqui/features/zone/domain/services/zone_service_interface.dart';
import 'package:get/get.dart';

/**
 * Zone's entity controller
 *
 * @author Giovane Neves
 * @since v0.0.1
 */
class ZoneController extends GetxController implements GetxService{

	final ZoneServiceInterface zoneService;

	ZoneController({required this.zoneService});

	List<Zone> _zones = [];
	List<Zone> get zones => _zones;

	@override
	void onInit() {

	  super.onInit();
	  getZoneList();

	}
	
	Future<void> getZoneList() async{

		_zones = await zoneService.getZoneList();
		update();

	} 

}