import 'package:corre_aqui/features/category/domain/models/category.dart';
import 'package:corre_aqui/features/category/domain/services/category_service_interface.dart';
import 'package:corre_aqui/util/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// @author Giovane Neves
/// @since v0.0.1
class CategoryController extends GetxController implements GetxService {

	final CategoryServiceInterface categoryServiceInterface;
	final _storage = GetStorage();

	bool _isLoading = false;
	List<Category> _categoryList = [];
	List<Category> get categoryList => _categoryList;

	CategoryController({required this.categoryServiceInterface});


	@override
	void onInit() {

	  super.onInit();
	  getCategoryList();

	}

	Future<void> getCategoryList({bool refresh = false}) async{

		if(_isLoading) return;
		_isLoading = true;


		if(!refresh) _readCachedData();


		try{

			final newCategories = await categoryServiceInterface.getCategoryList();

			if(_hasChanges(newCategories)){
				_categoryList = newCategories;
				_storage.write(Constants.cachedCategories, _categoryList.map((c) => c.toJson()).toList());
				_storage.write(Constants.cachedCategoryTimestamp, DateTime.now().millisecondsSinceEpoch);
				update();
			}

		} catch(e){

			_readCachedData();

		} finally{

			_isLoading = false;

		}

	}

	bool _hasChanges(List<Category> newCategories) {
		return newCategories.length != _categoryList.length ||
				newCategories.any((banner) => !_categoryList.contains(banner));
	}

	void _readCachedData(){

		final cachedData = _storage.read<List>(Constants.cachedCategories);
		if(cachedData != null){
			_categoryList = cachedData.map((c) => Category.fromJson(c)).toList();
			update();
		}

	}
}