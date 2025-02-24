import 'package:corre_aqui/features/zone/domain/models/zone.dart';

abstract class ZoneServiceInterface{

	Future<Zone?> getClosestZone(final zones);
	Future<List<Zone>> getZoneList();

}