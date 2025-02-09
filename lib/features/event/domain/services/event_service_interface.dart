import 'package:corre_aqui/features/event/domain/models/event.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
abstract class EventServiceInterface{

	Future<List<Event>> getEventList();

}