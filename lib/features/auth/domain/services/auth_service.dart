import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class AuthService{

	final supabase = Supabase.instance.client;

	Future<AuthResponse> googleSignIn() async {

    const webClientId = '1050336190766-ttnb5eac6eg3dscunisrm54gr41e33c8.apps.googleusercontent.com';
    //const iosClientId = '1050336190766-k6024l6mluhvj1gein4fv04oe25jf4sd.apps.googleusercontent.com';

    final GoogleSignIn googleSignIn = GoogleSignIn(
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

}