import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:flutter/material.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class StoreCardTemplate extends StatelessWidget{

	final Store store;

	const StoreCardTemplate({required this.store});

	@override
	Widget build(BuildContext context){
		return Column(
	      children: [
	        Container(
	          	width: 100,
	          	height: 100,
	          	decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                    	image: NetworkImage(store.imageUrl),
                        fit: BoxFit.cover,
                    ),
            	),
	        ),
	        const SizedBox(height: 8),
	        Text(
	          store.name,
	          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
	        ),
	      ],
	    );
	}

}