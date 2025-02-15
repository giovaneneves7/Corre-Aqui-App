import 'package:corre_aqui/common/widgets/cards_template/offer_card_template.dart';
import 'package:corre_aqui/features/offer/controllers/offer_controller.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class AllOffersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ofertas")),
      body: GetBuilder<OfferController>(
        builder: (controller) {
          if (controller.offerList.isEmpty) {
            return Center(child: Text("Nenhuma oferta disponível"));
          }

          return SizedBox( 
            height: MediaQuery.of(context).size.height, 
            child: ListView.builder(
              itemCount: controller.offerList.length,
              itemBuilder: (context, index) {
                final offer = controller.offerList[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getOfferDetailsScreen(offerId: offer.id));
                    },
                    child: OfferCardTemplate(offer: offer, isFromHome: false),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
