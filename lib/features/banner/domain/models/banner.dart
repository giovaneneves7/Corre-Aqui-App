import 'package:hive/hive.dart';

part 'banner.g.dart';

/// @author Giovane Neves
/// @since v0.0.1
@HiveType(typeId: 0)
class Banner{

	@HiveField(0)
	final String id;

	@HiveField(1)
	final String imageUrl;

	@HiveField(2)
	final String? description;

	@HiveField(3)
	final String? name;

	@HiveField(4)
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