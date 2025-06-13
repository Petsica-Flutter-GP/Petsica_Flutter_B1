class SitterApprovalModel {
  final String id;
  final String email;
  final String userName;
  final String photo;
  final String address;

  SitterApprovalModel({
    required this.id,
    required this.email,
    required this.userName,
    required this.photo,
    required this.address,
  });

  factory SitterApprovalModel.fromJson(Map<String, dynamic> json) {
    return SitterApprovalModel(
      id: json['id'],
      email: json['email'],
      userName: json['userName'],
      photo: json['photo'],
      address: json['address'],
    );
  }
}
