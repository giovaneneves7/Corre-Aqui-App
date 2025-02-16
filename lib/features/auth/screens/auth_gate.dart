import 'dart:async';
import 'package:corre_aqui/util/images.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:corre_aqui/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class AuthGate extends StatelessWidget{

  const AuthGate({super.key});

  @override
  Widget build(BuildContext context){

    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot){

        final session = snapshot.hasData ? snapshot.data!.session : null;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (session != null) {
            Get.offNamed(RouteHelper.getHomeScreen());
          } else {
            Get.offNamed(RouteHelper.getSignInScreen());
          }
        });

        // loading...
        return Scaffold(body: Center(child: CircularProgressIndicator())); 


      }
    );

  }

}
