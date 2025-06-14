class ClinicDetailsRequest {
  final String userId;
  final String userName;
  final String email;
  final String photo;
  final String address;
  final String approvalPhoto;
  final String type;
  final String workingHours;
  final String contactInfo;
  final String nationalID;

  ClinicDetailsRequest({
    required this.userId,
    required this.userName,
    required this.email,
    required this.photo,
    required this.address,
    required this.approvalPhoto,
    required this.type,
    required this.workingHours,
    required this.contactInfo,
    required this.nationalID,
  });

  factory ClinicDetailsRequest.fromJson(Map<String, dynamic> json) {
    return ClinicDetailsRequest(
      userId: json['userId'],
      userName: json['userName'],
      email: json['email'],
      photo: json['photo'],
      address: json['address'],
      approvalPhoto: json['approvalPhoto'],
      type: json['type'],
      workingHours: json['workingHours'],
      contactInfo: json['contactInfo'],
      nationalID: json['nationalID'],
    );
  }
}
