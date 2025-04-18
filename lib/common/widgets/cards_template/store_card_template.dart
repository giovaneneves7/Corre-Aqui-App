import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:corre_aqui/util/styles.dart';
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
                        fit: BoxFit.contain,
                    ),
								boxShadow: [
									BoxShadow(
										color: Colors.grey.withOpacity(0.4),
										spreadRadius: 2,
										blurRadius: 4,
										offset: const Offset(2, 4),
									),
								],
            	),
	        ),
	        const SizedBox(height: 8),
	        Text(
	          store.name,
	          style: secondaryRegular,
	        ),
	      ],
	    );
	}

}