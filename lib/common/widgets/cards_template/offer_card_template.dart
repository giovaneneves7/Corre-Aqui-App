import 'package:corre_aqui/common/widgets/components/offer_store_miniature_widget.dart';
import 'package:corre_aqui/features/offer/domain/models/offer.dart';
import 'package:corre_aqui/features/store/controllers/store_controller.dart';
import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:corre_aqui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferCardTemplate extends StatelessWidget {
  final bool isFromHome;
  final Offer offer;
  late Store store;

  OfferCardTemplate({super.key, required this.offer, required this.isFromHome});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      builder: (controller) {
        store = controller.getStoreById(offer.storeId);

        if (store == null) {
          return SizedBox.shrink();
        }

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(2, 6),
              ),
            ],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                  child: Container(
                    child: Image.network(
                      offer.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              isFromHome ? OfferStoreMiniatureWidget(store: store) : SizedBox(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  offer.name,
                  style: stixTwoTextRegular.copyWith(fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    Text(
                      'R\$ ${offer.originalPrice.toStringAsFixed(2)}',
                      style: stixTwoTextRegular.copyWith(color: Colors.grey, decoration: TextDecoration.lineThrough, fontSize: 10)
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'R\$ ${offer.offerPrice.toStringAsFixed(2)}',
                      style: lobsterTwoBold.copyWith(color: Colors.red, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
