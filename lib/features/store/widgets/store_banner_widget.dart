import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:flutter/material.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class StoreBannerWidget extends StatelessWidget{

	Store store;

	StoreBannerWidget({required this.store});

	@override
	Widget build(BuildContext context){

		return Stack(
            children: [
                Image.network(
                   	store.bannerUrl ?? store.imageUrl, 
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                ),
            ],
        );
	}
}