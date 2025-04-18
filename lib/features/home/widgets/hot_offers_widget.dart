import 'package:corre_aqui/common/widgets/cards_template/offer_card_template.dart';
import 'package:corre_aqui/features/home/widgets/components/see_more_button_widget.dart';
import 'package:corre_aqui/features/offer/controllers/offer_controller.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:corre_aqui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class HotOffersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfferController>(
      builder: (offerController) {
        if (offerController.hightDiscountOfferList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Maiores Descontos",
                      style: primaryBold.copyWith(fontSize: 18),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(RouteHelper.getAllOffersScreen());
                      },
                      child: const SeeMoreButtonWidget(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: offerController.hightDiscountOfferList.length,
                  itemBuilder: (context, index) {
                    final offer = offerController.hightDiscountOfferList[index];
                    final discountPercentage =
                        ((offer.originalPrice - offer.offerPrice) / offer.originalPrice * 100).round();

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 180,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getOfferDetailsScreen(offerId: offer.id));
                          },
                          child: Stack(
                            children: [
                              OfferCardTemplate(offer: offer, isFromHome: true),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                    decoration: BoxDecoration(

                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      "$discountPercentage% off",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
