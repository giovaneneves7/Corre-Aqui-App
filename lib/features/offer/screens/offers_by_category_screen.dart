import 'package:corre_aqui/common/widgets/cards_template/offer_card_template.dart';
import 'package:corre_aqui/common/widgets/no_data_found_widget.dart';
import 'package:corre_aqui/features/offer/controllers/offer_controller.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class OffersByCategoryScreen extends StatefulWidget {

  final int categoryId;

  OffersByCategoryScreen({required this.categoryId});

  @override
  _OffersByCategoryScreen createState() => _OffersByCategoryScreen();
}

class _OffersByCategoryScreen extends State<OffersByCategoryScreen> {


  @override
  Widget build(BuildContext context){


    return GetBuilder<OfferController>(
      builder: (offerController){

        final offers = offerController.getOffersByCategoryId(widget.categoryId);

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SafeArea(
              child: offers.isEmpty ? NoDataFoundWidget() : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: offers.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                          childAspectRatio: 2 / 3,
                        ),
                        itemBuilder: (context, index) {
                          final offer = offers[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.getOfferDetailsScreen(offerId: offer.id));
                            },
                            child: OfferCardTemplate(offer: offer, isFromHome: true),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}