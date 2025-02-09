import 'package:corre_aqui/features/event/controllers/event_controller.dart';
import 'package:corre_aqui/features/event/widgets/next_events_widget.dart';
import 'package:flutter/material.dart';

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
     return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage('assets/images/event_highlight.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
              ),
              const SizedBox(height: 20),
              NextEventsWidget(),
            ],
          ),
        ),
      ),
    );
  }

}