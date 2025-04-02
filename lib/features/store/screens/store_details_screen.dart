import 'package:corre_aqui/common/widgets/cards_template/offer_card_template.dart';
import 'package:corre_aqui/common/widgets/return_app_bar.dart';
import 'package:corre_aqui/features/offer/controllers/offer_controller.dart';
import 'package:corre_aqui/features/profile/controllers/profile_controller.dart';
import 'package:corre_aqui/features/store/controllers/store_controller.dart';
import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:corre_aqui/features/store/widgets/route_button_widget.dart';
import 'package:corre_aqui/features/store/widgets/store_banner_widget.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:corre_aqui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class StoreDetailsScreen extends StatefulWidget {
  final int storeId;

  StoreDetailsScreen({super.key, required this.storeId});

  @override
  State<StoreDetailsScreen> createState() => _StoreDetailsScreenState();
}

class _StoreDetailsScreenState extends State<StoreDetailsScreen> {
  
  late Store store;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final profileController = Get.find<ProfileController>();
    final isFav = await profileController.isFavoriteStore(widget.storeId);
    setState(() {
      isFavorite = isFav;
    });
  }

  @override
  Widget build(BuildContext context) {

    return GetBuilder<StoreController>(
      builder: (controller){
        return GetBuilder<ProfileController>(
          builder: (profileController){

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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                store.name,
                                style: primaryBold.copyWith(fontSize: 22)
                              ),
                              const SizedBox(height: 4),
                              RatingStars(
                                starBuilder: (index, color) => Icon(
                                  Icons.star,
                                  color: color,
                                ),
                                value: 0,
                                onValueChanged: (value){

                                },
                                starCount: 5,
                                starSize: 20,
                                valueLabelColor: const Color(0xff9b9b9b),
                                valueLabelTextStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0),
                                valueLabelRadius: 10,
                                maxValue: 5,
                                starSpacing: 2,
                                maxValueVisibility: false,
                                valueLabelVisibility: false,
                                animationDuration: Duration(milliseconds: 1000),
                                valueLabelPadding:
                                const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                                valueLabelMargin: const EdgeInsets.only(right: 8),
                                starOffColor: const Color(0xffe7e8ea),
                                starColor: Colors.yellow,
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border,
                              color: isFavorite ? Colors.red : Colors.grey,
                            ),
                            onPressed: () async {
                              // Alterar o estado de favorito
                              if (isFavorite) {
                                await profileController.removeFavoriteStore(store.id);
                              } else {
                                await profileController.addFavoriteStore(store.id);
                              }

                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Promotions and Offers
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Promoções e Ofertas',
                        style: secondaryBold.copyWith(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GetBuilder<OfferController>(
                      builder: (offerController) {

                        final offers = offerController.getOffersByStoreId(store.id);

                        if (offers.isEmpty) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
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
                                padding: const EdgeInsets.all(8.0),
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
                  ],
                ),
              ),
            );
          }
        );
      }
    );
  }
}
