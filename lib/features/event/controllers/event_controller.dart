import 'package:corre_aqui/features/event/domain/models/event.dart';
import 'package:corre_aqui/features/event/domain/services/event_service_interface.dart';
import 'package:get/get.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class EventController extends GetxController implements GetxService {

	final EventServiceInterface eventServiceInterface;

	EventController({required this.eventServiceInterface});

	List<Event> _eventList = [];
	List<Event> get eventList => _eventList;


	@override
	void onInit() {

	  super.onInit();
	  getEventList();

	}

	Event getEventById(eventId){

		return _eventList.firstWhere((event) => event.id == eventId);

	}

	Future<void> getEventList() async{

		try {
      		_eventList = await eventServiceInterface.getEventList();
      		update();
    	} catch (e) {
      		print('Erro ao buscar eventos: $e');
    	}

	}

}

