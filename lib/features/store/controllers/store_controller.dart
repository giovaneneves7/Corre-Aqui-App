import 'package:corre_aqui/features/store/domain/models/store.dart';
import 'package:corre_aqui/features/store/domain/models/store_hour.dart';
import 'package:corre_aqui/features/store/domain/services/store_service_interface.dart';
import 'package:corre_aqui/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// Widget 'Últimas Ofertas'.
/// @author Giovane Neves
/// @since v0.0.1
class StoreController extends GetxController implements GetxService{

	final StoreServiceInterface storeService;
	final GetStorage _storage = GetStorage();

	StoreController({required this.storeService});

	bool _isLoading = false;
	List<Store> _stores = [];
	List<Store> get stores => _stores;

	@override
	void onInit() {

	  super.onInit();
	  getStoreList();

	}
	
	Future<void> getStoreList({bool refresh = false}) async{

		if(_isLoading) return;
		_isLoading = true;

		if(!refresh) _readCachedData();

		try{

			final newStores = await storeService.getStoreList();

			if(_hasChanges(newStores)){

				_stores = newStores;
				_storage.write(Constants.cachedStores, _stores.map((s) => s.toJson()).toList());
				_storage.write(Constants.cachedStoresTimestamp, DateTime.now().millisecondsSinceEpoch);
				update();


			}

		} catch(e){

			_readCachedData();

		} finally{

			_isLoading = false;

		}


	}


	bool _hasChanges(List<Store> newStores) {
		return newStores.length != _stores.length ||
				newStores.any((store) => !_stores.contains(store));
	}

	void _readCachedData(){

		final cachedData = _storage.read<List>(Constants.cachedStores);
		if(cachedData != null){
			_stores = cachedData.map((c) => Store.fromJson(c)).toList();
			update();
		}

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