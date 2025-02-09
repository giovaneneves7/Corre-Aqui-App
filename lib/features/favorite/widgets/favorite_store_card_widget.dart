import 'package:flutter/material.dart';
import 'package:corre_aqui/features/store/domain/models/store.dart';

/**
* Widget de card que organiza as informações
* dos estabelecimentos marcados como favorito.
*
* @author Giovane Neves
*
*/
class FavoriteCard extends StatelessWidget {

  final Store store;

  FavoriteCard({required this.store});

  @override
  Widget build(BuildContext context) {
    
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              store.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    store.name,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange, size: 16.0),
                      SizedBox(width: 4.0),
                      Text('Favorito', style: TextStyle(color: Colors.orange)),
                    ],
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para ir para a loja
              },
              child: Text("Ir para"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}