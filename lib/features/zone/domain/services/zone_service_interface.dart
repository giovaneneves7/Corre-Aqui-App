import 'package:corre_aqui/features/zone/domain/models/zone.dart';

abstract class ZoneServiceInterface{

	Future<List<Zone>> getZoneList();

}