import 'package:corre_aqui/common/widgets/modals/zone_selector_modal.dart';
import 'package:corre_aqui/features/zone/controllers/zone_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
 * @author Giovane Neves
 * @since v0.0.1
 */
class ZoneDropdownWidget extends StatelessWidget {
  const ZoneDropdownWidget({super.key});


  void _showZoneModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const ZoneSelectorModal(),
    );
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<ZoneController>(
      builder: (zoneController) {
        if(zoneController.zones.isEmpty) {
          return const CircularProgressIndicator();
        } else{
          return GestureDetector(
            onTap: () => _showZoneModal(context),
            child: Row(
              children: [
                Icon(Icons.location_on, color: Colors.red),
                SizedBox(width: 4),
                Text(
                  zoneController.closestZone?.name ?? 'Zona',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 4),
                Icon(Icons.arrow_drop_down, color: Colors.black),
              ],
            ),
          );
        }
      },
    );

  }

}
