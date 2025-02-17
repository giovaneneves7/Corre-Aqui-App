/**
* @author Giovane Neves
* @since v0.0.1
*/
class Banner{

	final String id;
	final String imageUrl;
	final String? description;
	final String? name;
	final String? redirectUrl;

	Banner({
		required this.id, 
		required this.name, 
		required this.description, 
		required this.imageUrl,
		required this.redirectUrl,
	});

	factory Banner.fromJson(Map<String, dynamic> json) {
	    
		return Banner(
	      id: json['id'] as String,
	      imageUrl: json['image_url'] as String,
	      name: json['name'] as String?,
	      description: json['description'] as String?,
				redirectUrl: json['redirect_url'] as String?,
	    );
	}

	Map<String, dynamic> toJson() {
    	
    	return {
      		'id': id,
      		'image_url': imageUrl,
      		'name': name,
      		'description': description,
					'redirect_url': redirectUrl ?? '',
    	};
  	}

}