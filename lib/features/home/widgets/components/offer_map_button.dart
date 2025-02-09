import 'package:corre_aqui/helper/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OfferMapButton extends StatelessWidget{


	@override
	Widget build(BuildContext context){

		return FloatingActionButton(
        	onPressed: () {
          		Get.toNamed(RouteHelper.getOfferMapScreen());
        	},
        	backgroundColor: Colors.red,
        	child: const Icon(
          		Icons.location_pin, 
          		size: 32,
          		color: Colors.white
          	),
      	);

	}
}