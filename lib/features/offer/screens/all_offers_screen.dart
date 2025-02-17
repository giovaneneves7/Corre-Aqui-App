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

          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Define o número de colunas (2 ofertas por linha)
              crossAxisSpacing: 8.0, // Espaçamento horizontal entre os cards
              mainAxisSpacing: 8.0, // Espaçamento vertical entre os cards
              childAspectRatio: 0.7, // Define o tamanho do card em relação ao seu conteúdo
            ),
            itemCount: controller.offerList.length,
            itemBuilder: (context, index) {
              final offer = controller.offerList[index];

              return GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getOfferDetailsScreen(offerId: offer.id));
                },
                child: OfferCardTemplate(offer: offer, isFromHome: true),
              );
            },
          );
        },
      ),
    );
  }
}
