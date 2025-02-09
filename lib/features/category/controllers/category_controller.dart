import 'package:corre_aqui/features/category/domain/models/category.dart';
import 'package:corre_aqui/features/category/domain/services/category_service_interface.dart';
import 'package:get/get.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
class CategoryController extends GetxController implements GetxService {

	final CategoryServiceInterface categoryServiceInterface;

	CategoryController({required this.categoryServiceInterface});

	List<Category> _categoryList = [];
	List<Category> get categoryList => _categoryList;

	@override
	void onInit() {

	  super.onInit();
	  getCategoryList();

	}

	Future<void> getCategoryList() async{

		_categoryList = await categoryServiceInterface.getCategoryList();
		update();

	}
}