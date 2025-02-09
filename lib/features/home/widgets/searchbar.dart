import 'package:flutter/material.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/

class Searchbar extends StatelessWidget {
	
	final String hintText;
	final VoidCallback onTap;

	const Searchbar({
		Key? key,
		required this.hintText,
		required this.onTap,
	}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return GestureDetector(
			onTap: onTap,
			child: Container(
				padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
				decoration: BoxDecoration(
					color: Colors.grey[200],
					borderRadius: BorderRadius.circular(8.0),
				),
				child: Row(
					children: [
						const Icon(Icons.search, color: Colors.grey),
						const SizedBox(width: 8),
						Text(
							hintText,
							style: const TextStyle(color: Colors.grey),
						),
					],
				),
			),
		);
	}
}