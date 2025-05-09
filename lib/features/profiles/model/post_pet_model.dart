class PetModel {
  final String age;
  final String photo;
  final String gender;
  final String name;
  final String type;

  PetModel({
    required this.age, // Represents 'species' in API response
    required this.photo,
    required this.gender,
    required this.name,
    required this.type, // Represents 'breed' in API response
  });

  Map<String, dynamic> toJson() {
    return {
      'species': age,
      'photo': photo,
      'gender': gender,
      'name': name,
      'breed': type,
    };
  }

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      age: json['species'] ?? '',
      photo: json['photo'] ?? '',
      gender: json['gender'] ?? '',
      name: json['name'] ?? '',
      type: json['breed'] ?? '',
    );
  }
}


