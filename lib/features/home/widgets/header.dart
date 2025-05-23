
import 'package:corre_aqui/features/home/widgets/zone_dropdown_widget.dart';
import 'package:corre_aqui/util/styles.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              style: primaryBold.copyWith(fontSize: 22),
              children: const [
                TextSpan(text: 'CORRE A', style: TextStyle(color: Colors.black)),
                TextSpan(
                  text: 'Q',
                  style: TextStyle(color: Colors.red),
                ),
                TextSpan(text: 'UI!', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
          ZoneDropdownWidget(),
        ],
      ),
    );
  }
}

