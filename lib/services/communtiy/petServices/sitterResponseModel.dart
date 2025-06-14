class PetSitter {
  final int serviceID;
  final String sitterID;
  final double price;
  final String description;
  final String title;
  final String location;

  PetSitter({
    required this.serviceID,
    required this.sitterID,
    required this.price,
    required this.description,
    required this.title,
    required this.location,
  });

  factory PetSitter.fromJson(Map<String, dynamic> json) {
    return PetSitter(
      serviceID: json['serviceID'],
      sitterID: json['sitterID'],
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      title: json['title'],
      location: json['location'],
    );
  }
}