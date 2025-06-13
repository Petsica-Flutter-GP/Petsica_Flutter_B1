import 'package:petsica/features/profiles/adminn/services/model/sitter_approval_model.dart';

abstract class SellerApprovalState {}

class SellerApprovalInitial extends SellerApprovalState {}

class SellerApprovalLoading extends SellerApprovalState {}

class SellerApprovalSuccess extends SellerApprovalState {
  final List<SitterApprovalModel> SellerList;

  SellerApprovalSuccess(this.SellerList);
}

class SellerApprovalFailure extends SellerApprovalState {
  final String error;

  SellerApprovalFailure(this.error);
}
