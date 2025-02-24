import 'dart:math';

import 'package:corre_aqui/features/zone/domain/models/zone.dart';
import 'package:corre_aqui/features/zone/domain/repositories/zone_repository_interface.dart';
import 'package:corre_aqui/features/zone/domain/services/zone_service_interface.dart';
import 'package:corre_aqui/util/constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
* Zone entity's service
*
* @author Giovane Neves
* @since v0.0.1
*/
class ZoneService implements ZoneServiceInterface{

	final ZoneRepositoryInterface zoneRepository;
	final SharedPreferences sharedPreferences;

	ZoneService({required this.zoneRepository, required this.sharedPreferences});

	@override
	Future<List<Zone>> getZoneList() async{

		return await this.zoneRepository.getList();

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

	Future<Zone?> getClosestZone(final zones) async {

		if(sharedPreferences.getString(Constants.zoneId) != null){

			return await this.zoneRepository.get(sharedPreferences.getString(Constants.zoneId));

		}
		LocationPermission permission = await Geolocator.checkPermission();


		if (permission == LocationPermission.denied) {
			permission = await Geolocator.requestPermission();
			if (permission == LocationPermission.deniedForever) {
				// Permissão permanentemente negada
				return null;
			}
		}

		Position position = await Geolocator.getCurrentPosition(
				desiredAccuracy: LocationAccuracy.high);

		double minDistance = double.infinity;
		Zone? nearestZone;

		for (Zone zone in zones) {
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

	this.sharedPreferences.setString(Constants.zoneId, nearestZone!.id);

	return nearestZone;

	}





}