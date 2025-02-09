import 'package:corre_aqui/helper/route_helper.dart';
import 'package:corre_aqui/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    _setupAuthListener();
    super.initState();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      print('Evento de autenticação: ${data.event}');
      if (data.event == AuthChangeEvent.signedIn) {
        Get.snackbar('erro', 'Usuário autenticado, redirecionando...');
        Get.toNamed(RouteHelper.getHomeOfferScreen());
      } else {
        Get.snackbar('erro', 'Evento inesperado: ${data.event}');
      }
    });
  }


  Future<AuthResponse> _googleSignIn() async {

    const webClientId = '1050336190766-vajsqla3q2dt63k2326bglr8bstod8hg.apps.googleusercontent.com';
    const iosClientId = '1050336190766-k6024l6mluhvj1gein4fv04oe25jf4sd.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: iosClientId,
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      Get.snackbar('Erro', 'Erro de access Token!');
      throw 'accessToken not found!';
    }
    if (idToken == null) {
      Get.snackbar('Erro', 'Erro de idToken!');
      throw 'No ID Token found.';
    }

    return supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagem de fundo
          Positioned.fill(
            child: Image.asset(
              Images.background,
              fit: BoxFit.cover,
            ),
          ),

          // Máscara para escurecer a imagem
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),

          // Conteúdo principal
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Logo no canto superior direito
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      Images.logo,
                      width: 80,
                      height: 80,
                    ),
                  ),
                  const Spacer(),

                  // Textos centralizados
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        'Seja Rápido',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Economize Mais',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Botão "Login com Google"
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          try {
                            await _googleSignIn();
                          } catch (e) {
                            print('Erro ao fazer login: $e');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: Image.asset(
                          Images.googleIcon,
                          height: 24,
                          width: 24,
                        ),
                        label: const Text(
                          'Login com Google',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}