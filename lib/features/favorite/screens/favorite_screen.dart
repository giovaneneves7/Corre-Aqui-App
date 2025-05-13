import 'package:corre_aqui/features/profile/controllers/profile_controller.dart';
import 'package:corre_aqui/features/store/controllers/store_controller.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:corre_aqui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Tela responsável por exibir os estabelecimentos marcados como
/// favoritos pelo usuário.
///
/// @author Giovane Neves
class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late ProfileController profileController;

  @override
  void initState() {
    super.initState();
    profileController = Get.find<ProfileController>();
    profileController.getFavoriteStores();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        final favoriteStores = profileController.favoriteStores;
        final storeController = Get.find<StoreController>();

        if (favoriteStores.isEmpty) {
          return Center(child: Text('Nenhuma loja favorita.'));
        }

        return ListView.builder(
          itemCount: favoriteStores.length,
          itemBuilder: (context, index) {
            final store = favoriteStores[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        // Imagem
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            store.imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Icon(Icons.store, size: 60),
                          ),
                        ),
                        SizedBox(width: 10),

                        // Conteúdo
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(store.name,
                                  style: primaryBold.copyWith(fontSize: 16)
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.star, color: Colors.amber, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    "4.0 (${/*store.ratingCount ??*/ 0} Avaliação(eis)) | ${/*store.distance ??*/ '1.2 km'}",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Text(
                                "${/*store.offerCount ??*/ 0} Ofertas",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange),
                              ),
                              SizedBox(height: 4),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: storeController.isStoreOpenNow(store.hours) ? Colors.green : Colors.red,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  storeController.isStoreOpenNow(store.hours) ? "Aberto Agora" : "Fechado",
                                  style: TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Botão de remover no canto superior direito
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: () {
                        profileController.removeFavoriteStore(store.id).then((_) {
                          profileController.getFavoriteStores(refresh: true);
                        });
                      },
                    ),
                  ),
                ],
              ),
            );

          },
        );
      },
    );
  }
}
