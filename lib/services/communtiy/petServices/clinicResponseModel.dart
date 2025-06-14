class Clinic {
  final String userName;
  final String photo;
  final String address;
  final String clinicID;
  final String workingHours;
  final String contactInfo;

  Clinic({
    required this.userName,
    required this.photo,
    required this.address,
    required this.clinicID,
    required this.workingHours,
    required this.contactInfo,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) {
    return Clinic(
      userName: json['userName'] ?? 'Unknown',
      photo: json['photo'] ?? '',
      address: json['address'] ?? '',
      clinicID: json['clinicID'] ?? '',
      workingHours: json['workingHours'] ?? 'Not specified',
      contactInfo: json['contactInfo'] ?? 'Not specified',
    );
  }
}