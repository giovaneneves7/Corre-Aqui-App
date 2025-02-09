import 'package:corre_aqui/common/widgets/cards_template/offer_card_template.dart';
import 'package:corre_aqui/common/widgets/return_app_bar.dart';
import 'package:corre_aqui/features/offer/controllers/offer_controller.dart';
import 'package:corre_aqui/features/store/controllers/store_controller.dart';
import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:corre_aqui/features/store/widgets/route_button_widget.dart';
import 'package:corre_aqui/features/store/widgets/store_banner_widget.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class StoreDetailsScreen extends StatefulWidget {
  final int storeId;

  StoreDetailsScreen({required this.storeId});

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  
  late Store store;

  @override
  Widget build(BuildContext context) {

    return GetBuilder<StoreController>(
      builder: (controller){
        
        store = controller.getStoreById(widget.storeId);

        if (store == null) {
              return SizedBox.shrink();
        }

        return Scaffold(
          appBar: ReturnAppBar(title: 'Detalhes da Loja'),
          extendBodyBehindAppBar: true,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StoreBannerWidget(store: store),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Promotions and Offers
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text(
                    'Promoções e Ofertas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                GetBuilder<OfferController>(
                  builder: (offerController) {
                    
                    final offers = offerController.getOffersByStoreId(store.id);

                    if (offers.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: const Text(
                          'Nada aqui por enquanto \'-\'',
                          style: TextStyle(color: Colors.grey),
                        ),
                      );
                    }

                    return SizedBox(
                      height: 180, 
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: offers.length,
                        itemBuilder: (context, index) {
                          final offer = offers[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: SizedBox(
                              width: 180,  
                              child: GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getOfferDetailsScreen(offerId: offer.id));
                                },
                                child: OfferCardTemplate(offer: offer, isFromHome: false),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                // "Ver Rotas" Button
                //RouteButtonWidget(),
              ],
            ),
          ),
        );
      }
    );
  }
}
