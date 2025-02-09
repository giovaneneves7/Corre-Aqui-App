import 'package:corre_aqui/features/offer/domain/models/offer.dart';
import 'package:corre_aqui/features/offer/domain/repositories/offer_repository_interface.dart';
import 'package:corre_aqui/features/offer/domain/services/offer_service_interface.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class OfferService implements OfferServiceInterface{

	final OfferRepositoryInterface offerRepositoryInterface;

	OfferService({required this.offerRepositoryInterface});

	@override
	Future<List<Offer>> getOfferList() async{

		return await offerRepositoryInterface.getList();

	}

}