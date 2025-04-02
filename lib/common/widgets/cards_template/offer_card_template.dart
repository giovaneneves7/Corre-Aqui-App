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

        return SizedBox(
          height: 180,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(1, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    offer.imageUrl,
                    height: 80,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, color: Colors.grey, size: 60),
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    offer.name,
                    style: secondaryBold.copyWith(fontSize: MediaQuery.of(context).size.width * 0.035),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'R\$ ${offer.originalPrice.toStringAsFixed(2)}',
                      style: secondaryRegular.copyWith(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'R\$ ${offer.offerPrice.toStringAsFixed(2)}',
                      style: primaryBold.copyWith(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        );
      },
    );
  }
}
