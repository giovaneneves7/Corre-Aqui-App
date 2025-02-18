import 'package:corre_aqui/features/zone/controllers/zone_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
 * @author Giovane Neves
 * @since v0.0.1
 */
class ZoneSelectorModal extends StatefulWidget {
  const ZoneSelectorModal({super.key});

  @override
  State<ZoneSelectorModal> createState() => _ZoneSelectorModalState();
}

class _ZoneSelectorModalState extends State<ZoneSelectorModal> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<ZoneController>(
          builder: (zoneController) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Zonas Disponíveis",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: zoneController.zones.length,
                  itemBuilder: (context, index) {
                    final zone = zoneController.zones[index];
                    final isSelected = zone.id == zoneController.closestZone?.id;
                    return ListTile(
                      title: Text(zone.name),
                      trailing: isSelected
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                      onTap: () {
                        zoneController.setSelectedZone(zone);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implementar lógica de troca de zona
                  },
                  icon: const Icon(
                    Icons.swap_horiz,
                    color: Colors.white,
                  ),
                  label: const Text("Trocar Zona"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

}

