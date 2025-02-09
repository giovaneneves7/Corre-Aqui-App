import 'package:corre_aqui/common/widgets/cards_template/event_card_template.dart';
import 'package:corre_aqui/features/event/controllers/event_controller.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
 * @author Giovane Neves
 * @since v0.0.1
 */
class NextEventsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EventController>(
      builder: (controller) {
        if (controller.eventList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Próximos Eventos", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 10),
              Column(
                children: controller.eventList.map((event) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: GestureDetector(
                      onTap: () {

                        Get.toNamed(RouteHelper.getEventDetailsScreen(eventId: event.id));

                      },
                      child: EventCardTemplate(event: event),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        }
      },
    );
  }
}
