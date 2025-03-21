import 'package:corre_aqui/common/widgets/cards_template/store_card_template.dart';
import 'package:corre_aqui/common/widgets/return_app_bar.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 800 ? 4 : screenWidth > 600 ? 3 : 2;

    return Scaffold(
      appBar: ReturnAppBar(title: "Estabelecimentos"),
      body: GetBuilder<StoreController>(
        builder: (controller) {
          if (controller.stores.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.9, 
              ),
              itemCount: controller.stores.length,
              itemBuilder: (context, index) {
                final store = controller.stores[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getStoreDetailsScreen(storeId: store.id));
                  },
                  child: StoreCardTemplate(store: store),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
