import 'package:corre_aqui/common/widgets/cards_template/offer_card_template.dart';
import 'package:corre_aqui/features/offer/controllers/offer_controller.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
 * Widget 'Últimas Ofertas'.
 * @author Giovane Neves
 * @since v0.0.1
 */
class FreshOffersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfferController>(
      builder: (controller) {
        if (controller.offerList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Últimas Ofertas",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Ver Mais",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
              GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.offerList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 2 / 3,
                ),
                itemBuilder: (context, index) {
                  final offer = controller.offerList[index];
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getOfferDetailsScreen(offerId: offer.id));
                    },
                    child: OfferCardTemplate(offer: offer, isFromHome: true),
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}
