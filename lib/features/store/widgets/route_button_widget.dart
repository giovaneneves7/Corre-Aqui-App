import 'package:flutter/material.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class RouteButtonWidget extends StatelessWidget{

	@override
	Widget build(BuildContext context){

		return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                   	backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                    	borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {},
                child: const Center(
                    child: Text(
                    	'Ver Rotas',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                ),
            ),
        );

	}

}