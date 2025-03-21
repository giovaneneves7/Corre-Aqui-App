import 'package:corre_aqui/util/styles.dart';
import 'package:flutter/material.dart';

class SeeMoreButtonWidget extends StatelessWidget {

  const SeeMoreButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text("Ver Mais", style: lobsterTwoBold.copyWith(fontSize: 16, color: Colors.red),);
  }
}
