class PetMating {
  final int petID;
  final String userName;
  final String species;
  final String photo;
  final String gender;
  final String name;
  final String breed;

  PetMating({
    required this.petID,
    required this.userName,
    required this.species,
    required this.photo,
    required this.gender,
    required this.name,
    required this.breed,
  });

  factory PetMating.fromJson(Map<String, dynamic> json) {
    return PetMating(
      petID: json['petID'],
      userName: json['userName'],
      species: json['species'],
      photo: json['photo'],
      gender: json['gender'],
      name: json['name'],
      breed: json['breed'],
    );
  }
}