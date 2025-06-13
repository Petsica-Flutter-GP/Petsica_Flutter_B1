// import 'package:petsica/features/profiles/sitter/models/sitter_services_model.dart';

// abstract class AdminSitterServicesState {}

// class AdminSitterServicesInitial extends AdminSitterServicesState {}

// class AdminSitterServicesLoading extends AdminSitterServicesState {}

// class AdminSitterServicesLoaded extends AdminSitterServicesState {
//   final List<SitterServiceModel> services;

//   AdminSitterServicesLoaded(this.services);
// }

// class AdminSitterServicesError extends AdminSitterServicesState {
//   final String message;

//   AdminSitterServicesError(this.message);
// }
import 'package:petsica/features/profiles/adminn/services/model/sitter_approval_model.dart';

abstract class SitterApprovalState {}

class SitterApprovalInitial extends SitterApprovalState {}

class SitterApprovalLoading extends SitterApprovalState {}

class SitterApprovalSuccess extends SitterApprovalState {
  final List<SitterApprovalModel> sitterList;

  SitterApprovalSuccess(this.sitterList);
}

class SitterApprovalFailure extends SitterApprovalState {
  final String error;

  SitterApprovalFailure(this.error);
}
