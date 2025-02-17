import 'package:corre_aqui/features/profile/domain/models/profile.dart';

/**
*
* @author Giovane Neves
* @since v0.0.1
*/
abstract class ProfileServiceInterface{

	Future<List<Profile>> getProfileList();

}