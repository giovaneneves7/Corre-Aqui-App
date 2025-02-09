import 'package:flutter/material.dart';
import 'package:corre_aqui/features/notification/widgets/section_title.dart';
import 'package:corre_aqui/features/notification/widgets/notification_tile.dart';
import 'package:corre_aqui/common/widgets/custom_bottom_navigation_bar.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int _currentIndex = 0; // Index for the current screen in the bottom navigation

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    // Add navigation logic here, if needed.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notificações"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SectionTitle(title: "Hoje"),
          NotificationTile(
            icon: Icons.local_offer,
            title: "Desconto Especial de 30% em produtos de limpeza!",
            subtitle: "Promoção especial válida apenas hoje.",
            date: "Hoje",
          ),
          SectionTitle(title: "Ontem"),
          NotificationTile(
            icon: Icons.shopping_bag,
            title: "Novo calçado na loja: Confira as Novidades!",
            subtitle: "Descubra nossas novas coleções de calçados.",
            date: "Ontem",
          ),
          NotificationTile(
            icon: Icons.local_offer,
            title: "Desconto Relâmpago: 15% em Toda a Loja!",
            subtitle: "Promoção especial válida apenas ontem.",
            date: "Ontem",
          ),
          SectionTitle(title: "Junho 7, 2024"),
          NotificationTile(
            icon: Icons.credit_card,
            title: "Cartão de Crédito Conectado!",
            subtitle: "Cartão de crédito foi vinculado.",
            date: "Junho 7, 2024",
          ),
          NotificationTile(
            icon: Icons.account_circle,
            title: "Conta criada com sucesso!",
            subtitle: "Sua conta foi criada.",
            date: "Junho 7, 2024",
          ),
        ],
      ),
      
    );
  }
}
