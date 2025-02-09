/**
* Classe que representa uma categoria.
*
* @author Giovane Neves
*/
class Category{

	int id;
	String name;
	String imageUrl;

	Category({required this.id, required this.name, required this.imageUrl});

	factory Category.fromJson(Map<String, dynamic> json) {
	    return Category(
	      id: json['id'],	
	      name: json['name'],
	      imageUrl: json['image_url'],
	    );
	}

	Map<String, dynamic> toJson() {
	    return {
	      'id': id,	
	      'name': name,
	      'image_url': imageUrl,
	    };
	}

}