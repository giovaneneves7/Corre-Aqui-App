
/**
* Model for Offer entity.
*
* @author Giovane Neves
* @since v0.0.1
*/
class Offer{

	final int id;
	final String name;
	final String imageUrl;
	final double originalPrice;
	final double offerPrice;
	final DateTime createdAt;
	final DateTime endDate;
	final int storeId;
	final int categoryId;

	Offer({
		required this.id,
		required this.name, 
		required this.imageUrl, 
		required this.originalPrice, 
		required this.offerPrice,
		required this.createdAt,
		required this.endDate,
		required this.storeId,
		required this.categoryId,
	});

}