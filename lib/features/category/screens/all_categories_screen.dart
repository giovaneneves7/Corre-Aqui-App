import 'package:corre_aqui/common/widgets/cards_template/category_card_template.dart';
import 'package:corre_aqui/features/category/controllers/category_controller.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
 * @author Giovane Neves
 * @since v0.0.1
 */
class AllCategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todas as Categorias"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GetBuilder<CategoryController>(
          builder: (controller) {
            if (controller.categoryList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: controller.categoryList.length,
              itemBuilder: (context, index) {
                var category = controller.categoryList[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getOffersByCategoryScreen(categoryId: category.id));
                  },
                  child: CategoryCardTemplate(category: category),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
