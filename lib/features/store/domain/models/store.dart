/// Classe que representa um estabelecimento comercial.
///
/// @author Giovane Neves
/// @since v0.0.1
class Store{

	final int id;
	final int categoryId;
	final String cnpj;
	final String name;
	final String imageUrl;
	final String? bannerUrl;
	final double latitude;
	final double longitude;
	final String? description;

	Store({required this.id, required this.categoryId, required this.cnpj, required this.name, required this.imageUrl, required this.bannerUrl, required this.latitude, required this.longitude, required this.description});

	factory Store.fromJson(Map<String, dynamic> json){

		return Store(
				id: json['id'],
				categoryId: json['category_id'],
				cnpj: json['cnpj'],
				name: json['name'],
				imageUrl: json['image_url'],
				bannerUrl: json['banner_url'],
				latitude: json['latitude'],
				longitude: json['longitude'],
				description: json['description']
		);

	}

	Map<String, dynamic> toJson(){

		return {
			'id' : id,
			'category_id' : categoryId,
			'cnpj' : cnpj,
			'name' : name,
			'image_url' : imageUrl,
			'banner_url' : bannerUrl,
			'latitude' : latitude,
			'longitude' : longitude,
			'description' : description,
		};

	}
}