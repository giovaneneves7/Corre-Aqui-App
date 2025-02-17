import 'package:corre_aqui/features/banner/controllers/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

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
							final banner = banners[index];

							return GestureDetector(
								onTap: () => _handleRedirect(banner.redirectUrl),
								child: Container(
									margin: const EdgeInsets.symmetric(horizontal: 10),
									decoration: BoxDecoration(
										borderRadius: BorderRadius.circular(8),
										image: DecorationImage(
											image: NetworkImage(banner.imageUrl),
											fit: BoxFit.cover,
										),
									),
								),
							);
						},
					),
				);
			},
		);
	}

	/// Lida com o redirecionamento, verificando se é um link externo ou uma rota interna
	void _handleRedirect(String? url) {
		if (url == null || url.isEmpty) return;

		if (Uri.tryParse(url)?.hasScheme ?? false) {
			// É um link externo (https://, http://)
			_launchExternalUrl(url);
		} else {
			// É um link interno do app (exemplo: /store-details?id=123)
			Get.toNamed(url);
		}
	}

	/// Abre links externos no navegador
	Future<void> _launchExternalUrl(String url) async {
		if (await canLaunchUrl(Uri.parse(url))) {
			await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
		} else {
			print("Não foi possível abrir: $url");
		}
	}
}
