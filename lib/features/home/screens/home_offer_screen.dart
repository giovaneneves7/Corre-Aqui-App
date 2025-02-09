import 'package:corre_aqui/features/home/widgets/banner_carousel.dart';
import 'package:corre_aqui/features/home/widgets/category_list.dart';
import 'package:corre_aqui/features/home/widgets/fresh_offers_widget.dart';
import 'package:corre_aqui/features/home/widgets/header.dart';
import 'package:corre_aqui/features/home/widgets/hot_offers_widget.dart';
import 'package:corre_aqui/features/home/widgets/new_stores_section.dart';
import 'package:corre_aqui/features/home/widgets/searchbar.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class HomeOfferScreen extends StatelessWidget {
  const HomeOfferScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Header(),
                const SizedBox(height: 16),

                // Search bar
                Searchbar(
                  hintText: "O que você está buscando?",
                  onTap: () {
                    Get.toNamed(RouteHelper.getSearchScreen());
                  },
                ),
                const SizedBox(height: 16),

                // Promotional Banner
                BannerCarousel(),
                const SizedBox(height: 16),

                // Categories
                CategoryList(),
                const SizedBox(height: 16),

                // Fresh Offers
                FreshOffersWidget(),
                const SizedBox(height: 16),

                // New Stores
                NewStoresSection(),
                const SizedBox(height: 16),

                HotOffersWidget(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
