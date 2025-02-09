import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:flutter/material.dart';

/**
 * @author Giovane
 * @since v0.0.1
 */
class OfferStoreMiniatureWidget extends StatelessWidget{

	final Store store;

	OfferStoreMiniatureWidget({required this.store});

	@override
	Widget build(BuildContext context){

		return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                children: [
                    CircleAvatar(
                        backgroundImage: NetworkImage(store.imageUrl ?? ''),
                        radius: 12,
                    ),
                    SizedBox(width: 8),
                    Text(
                       	store.name ?? '',
                        style: Theme.of(context).textTheme.bodySmall,
                    ),
                ],
            ),
        );
	}
}