import 'package:corre_aqui/features/category/domain/models/category.dart';
import 'package:flutter/material.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class CategoryCardTemplate extends StatelessWidget{

	final Category category;

	CategoryCardTemplate({required this.category});

	@override
	Widget build(BuildContext context){

		return Column(
            children: [
                Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                    	shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(category.imageUrl),
                            fit: BoxFit.cover,
                        ),
                    ),
                ),
                const SizedBox(height: 8),
                Text(
                   	category.name,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                ),
            ],
        );
	}

}