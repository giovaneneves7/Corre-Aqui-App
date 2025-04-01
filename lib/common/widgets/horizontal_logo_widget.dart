import 'package:corre_aqui/util/images.dart';
import 'package:corre_aqui/util/styles.dart';
import 'package:flutter/material.dart';

class HorizontalLogoWidget extends StatelessWidget {
  const HorizontalLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Images.logo,
          width: 50,
          height: 50,
        ),
        const SizedBox(width: 10),
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
      ],
    );
  }
}
