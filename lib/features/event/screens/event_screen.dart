import 'package:corre_aqui/features/event/controllers/event_controller.dart';
import 'package:corre_aqui/features/event/widgets/next_events_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class EventScreen extends StatefulWidget {
  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
   
  @override
  Widget build(BuildContext context) {

    return GetBuilder<EventController>(
        builder: (eventController){
          if (eventController.eventList.isEmpty) {
            return Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade300,
              ),
              alignment: Alignment.center,
              child: const Text(
                "Carregando eventos...",
                style: TextStyle(color: Colors.black),
              ),
            );
          }

          final featuredEvent = eventController.eventList.first;


          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180,
                    child: GestureDetector(
                     // onTap: () => _handleRedirect(banner.redirectUrl),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(featuredEvent.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    alignment: Alignment.center,
                  ),
                  const SizedBox(height: 20),
                  NextEventsWidget(),
                ],
              ),
            ),
          );
        }
    );

  }

}