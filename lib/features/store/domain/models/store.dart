/**
* Classe que representa um estabelecimento comercial.
*
* @author Giovane Neves
* @since v0.0.1
*/
class Store{

	final int id;
	final String cnpj;
	final String name;
	final String imageUrl;
	final String? bannerUrl;

	Store({required this.id, required this.cnpj, required this.name, required this.imageUrl, required this.bannerUrl});

}