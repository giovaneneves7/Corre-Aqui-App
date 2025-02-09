import 'package:flutter/material.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class Header extends StatelessWidget{

	@override
	Widget build(BuildContext context){

		return Row(
        	mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
	            Column(
	                crossAxisAlignment: CrossAxisAlignment.start,
	                children: const [
	                    Text(
	                        "Corre Aqui!",
	                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
	                    ),
	                ],
	            ),
	            Row(
	                children: [
	                    const Icon(Icons.location_on, color: Colors.red),
	                    const SizedBox(width: 4),
	                    const Text(
	                        "Irecê, BA",
	                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
	                    ),
	                ],
	            ),
        	],
    	);
	
	}
}