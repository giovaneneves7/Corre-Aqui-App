/**
* Modelo que representa os dados de endereçõ do usuário.
*
* @author Giovane Neves
*/
class Address{

	int? id;
	String? latitude;
	String? longitude;

	Address({this.id, this.latitude, this.longitude});

	Address.fromJson(Map<String, dynamic> json) {
    	
    	id = json['id'];
    	latitude = json['latitude'].toString();
    	longitude = json['longitude'].toString();
	
	}

	Map<String, dynamic> toJson() {
	    
	    final Map<String, dynamic> data = <String, dynamic>{};

	    data['id'] = id;
	    data['latitude'] = latitude;
	    data['longitude'] = longitude;	

	    return data;
	    
	}
}