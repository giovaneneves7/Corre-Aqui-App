import 'package:corre_aqui/common/widgets/return_app_bar.dart';
import 'package:corre_aqui/features/event/controllers/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class EventDetailsScreen extends StatefulWidget {

  final String eventId;

  EventDetailsScreen({
    required this.eventId,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  
  @override
  Widget build(BuildContext context) {

    return GetBuilder<EventController>(
      builder: (eventController){
                
        final event = eventController.getEventById(widget.eventId);

        return Scaffold(
          appBar: ReturnAppBar(title: "Informações do Evento"),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      event.imageUrl,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  event.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Entrada Grátis",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Spacer(),
              ],
            ),
          ),
        );
      }
    );
  }
}
