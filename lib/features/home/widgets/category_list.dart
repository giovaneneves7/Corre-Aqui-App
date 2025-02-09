import 'package:corre_aqui/common/widgets/cards_template/category_card_template.dart';
import 'package:corre_aqui/features/category/controllers/category_controller.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        if (controller.categoryList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.categoryList.map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getOffersByCategoryScreen(categoryId: category.id));
                    },
                    child: CategoryCardTemplate(category: category),
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}
