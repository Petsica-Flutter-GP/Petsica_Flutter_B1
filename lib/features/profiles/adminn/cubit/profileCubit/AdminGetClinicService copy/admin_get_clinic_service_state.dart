
import 'package:petsica/features/profiles/adminn/services/model/sitter_approval_model.dart';

abstract class ClinicApprovalState {}

class ClinicApprovalInitial extends ClinicApprovalState {}

class ClinicApprovalLoading extends ClinicApprovalState {}

class ClinicApprovalSuccess extends ClinicApprovalState {
  final List<SitterApprovalModel> ClinicList;

  ClinicApprovalSuccess(this.ClinicList);
}

class ClinicApprovalFailure extends ClinicApprovalState {
  final String error;

  ClinicApprovalFailure(this.error);
}
