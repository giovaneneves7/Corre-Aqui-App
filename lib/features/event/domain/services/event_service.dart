import 'package:corre_aqui/features/event/domain/models/event.dart';
import 'package:corre_aqui/features/event/domain/repositories/event_repository_interface.dart';
import 'package:corre_aqui/features/event/domain/services/event_service_interface.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class EventService implements EventServiceInterface{

	final EventRepositoryInterface eventRepositoryInterface;

	EventService({required this.eventRepositoryInterface});

	@override
	Future<List<Event>> getEventList() async{

		return await eventRepositoryInterface.getList();

	}

}