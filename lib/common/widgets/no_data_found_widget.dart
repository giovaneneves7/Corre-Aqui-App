import 'package:flutter/material.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class NoDataFoundWidget extends StatelessWidget{

	@override
	Widget build(BuildContext context){

		return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
           	child: const Text(
                'Nenhum dado foi encontrado \'-\'',
                style: TextStyle(color: Colors.grey),
            ),
        );
	}
}