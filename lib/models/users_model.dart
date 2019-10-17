
import 'dart:math';

class UserModel {
	int id;
	String firstname;
	String lastname;
	String fullNames;
	String imagePath;
	
	String get fullName {
		return firstname+" "+lastname;
	}
	
	UserModel({this.id,this.firstname,this.lastname,this.imagePath,});
}

// random number
var rnd = new Random();

List<UserModel> lChatUsers = [
	UserModel(id: rnd.nextInt(100), firstname: 'Harry', lastname: "Hawkins", imagePath: "assets/images/photo_male_1.jpg"),
	UserModel(id: rnd.nextInt(100), firstname: 'Timothy', lastname: "Woodkin", imagePath: "assets/images/photo_male_2.jpg"),
	UserModel(id: rnd.nextInt(100), firstname: 'Francine', lastname: "Riley", imagePath: "assets/images/photo_female_1.jpg"),
	UserModel(id: rnd.nextInt(100), firstname: 'Ronald', lastname: "Weber", imagePath: "assets/images/photo_male_3.jpg"),
	UserModel(id: rnd.nextInt(100), firstname: 'Sarah', lastname: "Beans", imagePath: "assets/images/photo_female_3.jpg"),
	UserModel(id: rnd.nextInt(100), firstname: 'Rachel', lastname: "Roullete", imagePath: "assets/images/photo_female_2.jpg"),
];