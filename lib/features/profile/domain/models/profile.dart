/**
*
* @author Giovane Neves
* @since v0.0.1
*/
class Profile{

	final String id;
	final String memberCode;
	final String name;
	final String imageUrl;
	final String? phone;

	Profile({required this.id, required this.name, required this.memberCode, required this.imageUrl, required this.phone});
	
}