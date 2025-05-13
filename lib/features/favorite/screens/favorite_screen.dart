import 'package:corre_aqui/features/profile/controllers/profile_controller.dart';
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
    profileController.getFavoriteStores(); // busca inicial
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        final favoriteStores = profileController.favoriteStores;

        if (favoriteStores.isEmpty) {
          return Center(child: Text('Nenhuma loja favorita.'));
        }

        return ListView.builder(
          itemCount: favoriteStores.length,
          itemBuilder: (context, index) {
            final store = favoriteStores[index];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: store.imageUrl.isNotEmpty
                    ? Image.network(store.imageUrl, width: 50, height: 50)
                    : Icon(Icons.store),
                title: Text(store.name, style: primaryBold),
                subtitle: Text(
                  store.description ?? 'Nenhuma descrição foi adicionada',
                  style: secondaryRegular,
                ),
                onTap: () {
                  Get.toNamed(RouteHelper.getStoreDetailsScreen(storeId: store.id));
                },
              ),
            );
          },
        );
      },
    );
  }
}
