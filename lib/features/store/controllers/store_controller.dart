import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:corre_aqui/features/store/domain/models/store_hour.dart';
import 'package:corre_aqui/features/store/domain/services/store_service_interface.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Widget 'Últimas Ofertas'.
/// @author Giovane Neves
/// @since v0.0.1
class StoreController extends GetxController implements GetxService{

	final StoreServiceInterface storeService;

	StoreController({required this.storeService});

	List<Store> _stores = [];
	List<Store> get stores => _stores;

	@override
	void onInit() {

	  super.onInit();
	  getStoreList();

	}
	
	Future<void> getStoreList() async{

		_stores = await storeService.getStoreList();
		update();

	} 

	/**
	* Browser for a store by the param id. 
	*
	* @author Giovane Neves
	* @since v0.0.1
	*/
	Store getStoreById(int id){

		return _stores.firstWhere((store) => store.id == id);

	}

	bool isStoreOpenNow(List<StoreHour> storeHours) {
		final now = DateTime.now();
		final weekday = now.weekday % 7;
		final currentTime = TimeOfDay.fromDateTime(now);

		for (var hour in storeHours) {
			if (hour.weekday == weekday) {
				final open = hour.openTime;
				final close = hour.closeTime;
				if (_isWithinTimeRange(currentTime, open, close)) {
					return true;
				}
			}
		}
		return false;
	}

	bool _isWithinTimeRange(TimeOfDay now, TimeOfDay start, TimeOfDay end) {
		final nowMinutes = now.hour * 60 + now.minute;
		final startMinutes = start.hour * 60 + start.minute;
		final endMinutes = end.hour * 60 + end.minute;
		return nowMinutes >= startMinutes && nowMinutes < endMinutes;
	}



}