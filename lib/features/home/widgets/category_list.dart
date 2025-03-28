import 'package:corre_aqui/common/widgets/cards_template/category_card_template.dart';
import 'package:corre_aqui/features/category/controllers/category_controller.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:corre_aqui/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Categorias",
                style: primaryBold.copyWith(fontSize: 18)
              ),
            ],
          ),
        ),
        GetBuilder<CategoryController>(
          builder: (controller) {
            if (controller.categoryList.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              int maxItems = 8;
              int itemCount = controller.categoryList.length;

              List categoriesToShow = itemCount > maxItems
                  ? controller.categoryList.sublist(0, maxItems - 1)
                  : controller.categoryList;

              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: categoriesToShow.length + 1,
                itemBuilder: (context, index) {
                  if (index < categoriesToShow.length) {
                    var category = categoriesToShow[index];
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getOffersByCategoryScreen(categoryId: category.id));
                      },
                      child: CategoryCardTemplate(category: category),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getAllCategoriesScreen());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text("Mais", style: primaryBold.copyWith(color: Colors.red)),
                        ),
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ],
    );
  }
}
