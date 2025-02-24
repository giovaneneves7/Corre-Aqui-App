import 'dart:math';

import 'package:corre_aqui/features/zone/domain/models/zone.dart';
import 'package:corre_aqui/features/zone/domain/services/zone_service_interface.dart';
import 'package:geolocator/geolocator.dart';
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
	Zone? _closestZone;
	Zone? get closestZone => _closestZone;
	Zone? _selectedZone;
	Zone? get selectedZone => _selectedZone;

	void setSelectedZone(zone){
		_selectedZone = zone;
	}

	@override
	void onInit() {

	  super.onInit();
		getZoneList();

	}

	Future<void> getClosestZone(zones) async{

		_closestZone = await zoneService.getClosestZone(zones);
		update();

	}
	Future<void> getZoneList() async{

		_zones = await zoneService.getZoneList();
		await getClosestZone(_zones);
		update();

	} 

}