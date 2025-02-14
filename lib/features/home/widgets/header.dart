
import 'package:corre_aqui/features/home/widgets/zone_dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Corre Aqui!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        ZoneDropdownWidget(),
      ],
    );
  }
}

