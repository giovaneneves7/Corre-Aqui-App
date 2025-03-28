import 'package:corre_aqui/common/widgets/return_app_bar.dart';
import 'package:corre_aqui/features/offer/controllers/offer_controller.dart';
import 'package:corre_aqui/features/offer/domain/models/offer.dart';
import 'package:corre_aqui/features/store/controllers/store_controller.dart';
import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferDetailsScreen extends StatefulWidget {
  final int offerId;

  OfferDetailsScreen({
    required this.offerId,
  });

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  late Offer offer;
  late Store store;
  bool _isDescriptionExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfferController>(
      builder: (offerController) {
        offer = offerController.getOfferById(widget.offerId);

        return GetBuilder<StoreController>(
          builder: (storeController) {
            store = storeController.getStoreById(offer.storeId);

            return Scaffold(
              appBar: ReturnAppBar(title: "Informações da Oferta"),
              body: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            offer.imageUrl,
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        offer.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'R\$ ${offer.originalPrice.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "R\$ ${offer.offerPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Descrição com fundo acinzentado e texto expandível
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Descrição:",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              offer.description != null && offer.description!.isNotEmpty
                                  ? _isDescriptionExpanded
                                  ? offer.description! // Exibe a descrição completa
                                  : "${offer.description!.substring(0, 20)}..."
                                  : "Sem descrição disponível.",
                              style: const TextStyle(fontSize: 16),
                              overflow: _isDescriptionExpanded ? null : TextOverflow.ellipsis, // Não aplica elipse se expandido
                              maxLines: _isDescriptionExpanded ? null : 3, // Limita as linhas quando não expandido
                            ),
                            if (offer.description != null && offer.description!.isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isDescriptionExpanded = !_isDescriptionExpanded;
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      _isDescriptionExpanded ? "Leia menos" : "Leia mais",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      _isDescriptionExpanded
                                          ? Icons.expand_less
                                          : Icons.expand_more,
                                      size: 16,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text("Vendido por:"),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage: NetworkImage(store.imageUrl),
                                radius: 30,
                              ),
                              const SizedBox(width: 12),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper.getStoreDetailsScreen(storeId: store.id));
                                },
                                child: Text(
                                  store.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
