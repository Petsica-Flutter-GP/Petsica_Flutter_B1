class PetModel {
  final String species;
  final String photo;
  final String gender;
  final String name;
  final String breed;

  PetModel({
    required this.species,
    required this.photo,
    required this.gender,
    required this.name,
    required this.breed,
  });

  Map<String, dynamic> toJson() {
    return {
      'species': species,
      'photo': photo,
      'gender': gender,
      'name': name,
      'breed': breed,
    };
  }

  factory PetModel.fromJson(Map<String, dynamic> json) {
    return PetModel(
      species: json['species'] ?? '',
      photo: json['photo'] ?? '',
      gender: json['gender'] ?? '',
      name: json['name'] ?? '',
      breed: json['breed'] ?? '',
    );
  }
}
