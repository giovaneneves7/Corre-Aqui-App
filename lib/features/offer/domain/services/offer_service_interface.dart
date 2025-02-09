import 'package:corre_aqui/features/offer/domain/models/offer.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
abstract class OfferServiceInterface{

	Future<List<Offer>> getOfferList();

}