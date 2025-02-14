import 'package:corre_aqui/features/banner/controllers/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

/**
 * Home's screen banner carousel.
 *
 * @author Giovane Neves
 * @since v0.0.1
 */
class BannerCarousel extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return GetBuilder<BannerController>(
			builder: (controller) {
				if (controller.bannerList.isEmpty) {
					return Container(
						height: 120,
						decoration: BoxDecoration(
							borderRadius: BorderRadius.circular(8),
							color: Colors.grey.shade300,
						),
						alignment: Alignment.center,
						child: const Text(
							"Carregando banners...",
							style: TextStyle(color: Colors.black),
						),
					);
				}

				final banners = controller.bannerList.take(3).toList();

				return SizedBox(
					height: 120,
					child: CarouselSlider.builder(
						itemCount: banners.length,
						options: CarouselOptions(
							height: 120,
							viewportFraction: 0.8, // Espaço para mostrar parte do próximo banner
							autoPlay: true,
							autoPlayInterval: const Duration(seconds: 4),
							enableInfiniteScroll: true,
						),
						itemBuilder: (context, index, realIndex) {
							return Container(
								margin: EdgeInsets.only(
									right: 10,
									left: 10,
								),
								decoration: BoxDecoration(
									borderRadius: BorderRadius.circular(8),
									image: DecorationImage(
										image: NetworkImage(banners[index].imageUrl),
										fit: BoxFit.cover,
									),
								),
							);
						},
					),
				);
			},
		);
	}
}
