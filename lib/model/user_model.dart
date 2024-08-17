class AppModel {
  String? name;
  String? age;
  String? image;
  String? phoneNumber;

  AppModel({this.name, this.age, this.image, this.phoneNumber});

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      name: json['name'],
      age: json['age'],
      image: json['image'],
      phoneNumber: json['phoneNumber'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'image': image,
      'phoneNumber': phoneNumber,
    };
  }
}
