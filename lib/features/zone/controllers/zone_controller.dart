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

	double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
		const double R = 6371;
		double dLat = _degreesToRadians(lat2 - lat1);
		double dLon = _degreesToRadians(lon2 - lon1);
		double a = sin(dLat / 2) * sin(dLat / 2) +
				cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) *
						sin(dLon / 2) * sin(dLon / 2);
		double c = 2 * atan2(sqrt(a), sqrt(1 - a));
		return R * c;
	}

	double _degreesToRadians(double degrees) {
		return degrees * pi / 180;
	}

	Future<void> _determineClosestZone() async {

		LocationPermission permission = await Geolocator.checkPermission();


		if (permission == LocationPermission.denied) {
			permission = await Geolocator.requestPermission();
			if (permission == LocationPermission.deniedForever) {
				// Permissão permanentemente negada
				return;
			}
		}

		Position position = await Geolocator.getCurrentPosition(
				desiredAccuracy: LocationAccuracy.high);

		double minDistance = double.infinity;
		Zone? nearestZone;

		for (Zone zone in _zones) {
			double distance = _calculateDistance(
				position.latitude,
				position.longitude,
				zone.latitude,
				zone.longitude,
			);

			if (distance < minDistance) {
				minDistance = distance;
				nearestZone = zone;
			}
		}

		_closestZone = nearestZone;
		_selectedZone = _closestZone;
		update();
	}
	
	Future<void> getZoneList() async{

		_zones = await zoneService.getZoneList();
		await _determineClosestZone();
		update();

	} 

}