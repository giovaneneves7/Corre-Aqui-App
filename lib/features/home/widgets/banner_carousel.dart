import 'package:corre_aqui/features/banner/controllers/banner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
* Home's screen banner carousel.
*
* @author Giovane Neves
* @since v0.0.1
*/
class BannerCarousel extends StatelessWidget{

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

	            final firstBanner = controller.bannerList.first;
	            
	            return Container(
	                height: 120,
	                decoration: BoxDecoration(
	                borderRadius: BorderRadius.circular(8),
	                image: DecorationImage(
	                    image: NetworkImage(firstBanner.imageUrl),
	                     fit: BoxFit.cover,
	                	),
	                ),
	            );
	        },
        );

	}
	
}