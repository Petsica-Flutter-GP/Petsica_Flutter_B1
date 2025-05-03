class GetPetModel {
  final int petID;
  final String species;
  final String photo;
  final String gender;
  final String name;
  final String breed;

  GetPetModel({
    required this.petID,
    required this.species,
    required this.photo,
    required this.gender,
    required this.name,
    required this.breed,
  });

  factory GetPetModel.fromJson(Map<String, dynamic> json) {
    return GetPetModel(
      petID: json['petID'] ?? 0,
      species: json['species'] ?? '',
      photo: json['photo'] ?? '',
      gender: json['gender'] ?? '',
      name: json['name'] ?? '',
      breed: json['breed'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'petID': petID,
      'species': species,
      'photo': photo,
      'gender': gender,
      'name': name,
      'breed': breed,
    };
  }
}
