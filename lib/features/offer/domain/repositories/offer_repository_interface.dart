import 'package:corre_aqui/interfaces/repository_interface.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
abstract class OfferRepositoryInterface implements RepositoryInterface{

	@override
	Future getList();

}