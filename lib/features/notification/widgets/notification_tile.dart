import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  
  final IconData icon;
  final String title;
  final String subtitle;
  final String date;

  NotificationTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.orange[100],
        child: Icon(icon, color: Colors.orange),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(
        date,
        style: TextStyle(color: Colors.grey, fontSize: 12),
      ),
    );
  }
}