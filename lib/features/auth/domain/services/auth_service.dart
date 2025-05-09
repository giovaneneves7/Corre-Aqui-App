import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class AuthService{

	final supabase = Supabase.instance.client;

  Future<AuthResponse> signInWithEmailAndPassword(String email, String password) async{

    return await supabase.auth.signInWithPassword(
      email: email,
      password: password
    );

  }	

  Future<AuthResponse> signUpWithEmailAndPassword(String email, String password) async{

    return await supabase.auth.signUp(
      email: email,
      password: password
    );

  }

  Future<void> signOut() async{

    await supabase.auth.signOut();

  }

  String? getCurrentUserEmail(){

    final session  = supabase.auth.currentSession;
    final user = session?.user;

    return user?.email;
  }

}