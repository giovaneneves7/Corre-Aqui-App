import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:corre_aqui/features/auth/screens/auth_gate.dart';
import 'package:corre_aqui/theme/custom_theme.dart';
import 'package:corre_aqui/helper/route_helper.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'helper/get_di.dart' as di;

void main() async {
      
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://mpyyooswcudkgouiomuo.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1weXlvb3N3Y3Vka2dvdWlvbXVvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzMwNTk5OTgsImV4cCI6MjA0ODYzNTk5OH0.zjQSRDm22Q8A-hCGyLLd9MObB9pIMCmf9bKg9aaE6AA',
  );
  await GetStorage.init();

  await di.init();

  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      getPages: RouteHelper.routes,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.light,
      locale: const Locale('pt', 'BR'), 
      fallbackLocale: const Locale('en', 'US'),
      home: AuthGate(), 
    );
  }

}
