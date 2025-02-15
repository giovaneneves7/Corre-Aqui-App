import 'package:corre_aqui/common/widgets/cards_template/store_card_template.dart';
import 'package:corre_aqui/features/store/controllers/store_controller.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
 * @author Giovane Neves
 * @since v0.0.1
 */
class AllStoresScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Estabelecimentos")),
      body: GetBuilder<StoreController>(
        builder: (controller) {
          if (controller.stores.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: controller.stores.length,
            itemBuilder: (context, index) {
              final store = controller.stores[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getStoreDetailsScreen(storeId: store.id));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: StoreCardTemplate(store: store),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
