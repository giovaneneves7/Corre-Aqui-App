import 'package:corre_aqui/common/widgets/cards_template/store_card_template.dart';
import 'package:corre_aqui/features/home/widgets/components/see_more_button_widget.dart';
import 'package:corre_aqui/features/store/controllers/store_controller.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:corre_aqui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
 * @author Giovane Neves
 * @since v0.0.1
 */
class NewStoresSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      builder: (controller) {
        if (controller.stores.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Estabelecimentos",
                    style: lobsterTwoBold.copyWith(fontSize: 18),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed(RouteHelper.getAllStoresScreen());
                    },
                    child: const SeeMoreButtonWidget(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: controller.stores.map((store) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getStoreDetailsScreen(storeId: store.id));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: StoreCardTemplate(store: store),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
