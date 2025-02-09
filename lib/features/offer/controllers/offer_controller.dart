import 'package:corre_aqui/features/offer/domain/models/offer.dart';
import 'package:corre_aqui/features/offer/domain/services/offer_service_interface.dart';
import 'package:get/get.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class OfferController extends GetxController implements GetxService {

	final OfferServiceInterface offerServiceInterface;

	OfferController({required this.offerServiceInterface});

	List<Offer> _hightDiscountOfferList = [];
	List<Offer> get hightDiscountOfferList => _hightDiscountOfferList;
	List<Offer> _offerList = [];
	List<Offer> get offerList => _offerList;


	@override
	void onInit() {

	  super.onInit();
	  getOfferList();

	}


	List<Offer> getOffersByStoreId(storeId){

		return _offerList.where((offer) => offer.storeId == storeId).toList();
		
	}

	Offer getOfferById(offerId){

		return _offerList.firstWhere((offer) => offer.id == offerId);

	}

	List<Offer> getOffersByCategoryId(categoryId){

		return _offerList.where((offer) => offer.categoryId == categoryId).toList();

	}

	void getOffersByHighestDiscount() {

		if (_offerList.isEmpty) return;

		_hightDiscountOfferList = [..._offerList]
		      ..sort((a, b) {
		        double discountA = (a.originalPrice - a.offerPrice) / a.originalPrice;
		        double discountB = (b.originalPrice - b.offerPrice) / b.originalPrice;
		        return discountB.compareTo(discountA); 
		});
	    
	    update();
	}

	Future<void> getOfferList() async{

		try {
      		_offerList = await offerServiceInterface.getOfferList();
      		getOffersByHighestDiscount();
      		update();
    	} catch (e) {
      		print('Erro ao buscar eventos: $e');
    	}

	}

}


