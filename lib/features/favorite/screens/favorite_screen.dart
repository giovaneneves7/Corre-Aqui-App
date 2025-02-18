import 'package:corre_aqui/features/profile/controllers/profile_controller.dart';
import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
 * Tela responsável por exibir os estabelecimentos marcados como
 * favoritos pelo usuário.
 *
 * @author Giovane Neves
 */
class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {

        return FutureBuilder<List<Store>>(
          future: profileController.getFavoriteStores(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar favoritos.'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Nenhuma loja favorita.'));
            } else {
              final favoriteStores = snapshot.data!;
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
                      title: Text(store.name),
                      subtitle: Text(store.description ?? 'Nenhuma descrição foi adicionada'),
                      onTap: () {
                        Get.toNamed(RouteHelper.getStoreDetailsScreen(storeId: store.id));
                      },
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
