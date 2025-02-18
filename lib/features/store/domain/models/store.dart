/**
* Classe que representa um estabelecimento comercial.
*
* @author Giovane Neves
* @since v0.0.1
*/
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

}