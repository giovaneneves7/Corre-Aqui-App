import 'package:flutter/material.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class SearchResultCardWidget extends StatelessWidget{

	final String imageUrl;
	final String title;
	final String category;

	SearchResultCardWidget({required this.imageUrl, required this.title, required this.category});

	@override
	Widget build(BuildContext context){

		return ListTile(
      		leading: Image.network(
	        	imageUrl,
	        	width: 50,
	        	height: 50,
	        	fit: BoxFit.cover,
	        	errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 50),
      		),
      		title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      		subtitle: Text(category, style: const TextStyle(color: Colors.grey)),
      		trailing: const Icon(Icons.arrow_outward, size: 16),
      		onTap: () {
        		debugPrint('Item selecionado: $title');
      		},
    	);
	}
}