import 'package:corre_aqui/features/category/domain/models/category.dart';
import 'package:corre_aqui/features/category/domain/repositories/category_repository_interface.dart';
import 'package:corre_aqui/features/category/domain/services/category_service_interface.dart';

class CategoryService implements CategoryServiceInterface{

	final CategoryRepositoryInterface categoryRepositoryInterface;

	CategoryService({required this.categoryRepositoryInterface});

	@override
	Future<List<Category>> getCategoryList() async{

		return await categoryRepositoryInterface.getList();

	}
}