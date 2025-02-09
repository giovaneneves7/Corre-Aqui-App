import 'package:corre_aqui/features/category/domain/models/category.dart';

/**
* @author Giovane Neves
* @since v0.0.1
*/
abstract class CategoryServiceInterface{

	Future<List<Category>> getCategoryList();

}