import 'package:corre_aqui/features/profile/domain/models/profile.dart';
import 'package:corre_aqui/features/profile/domain/repositories/profile_repository_interface.dart';
import 'package:corre_aqui/features/profile/domain/services/profile_service_interface.dart';

/**
* Porfile entity's service
*
* @author Giovane Neves
* @since v0.0.1
*/
class ProfileService implements ProfileServiceInterface{

	final ProfileRepositoryInterface profileRepository;

	ProfileService({required this.profileRepository});

	/**
	* @author Giovane Neves
	*/
	@override
	Future<List<Profile>> getProfileList() async{

		return await this.profileRepository.getList();

	}

}