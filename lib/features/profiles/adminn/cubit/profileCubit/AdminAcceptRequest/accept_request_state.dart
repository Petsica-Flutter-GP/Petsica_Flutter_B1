
abstract class ApprovalState {}

class ApprovalInitial extends ApprovalState {}

class ApprovalLoading extends ApprovalState {}

class ApprovalSuccess extends ApprovalState {}

class ApprovalError extends ApprovalState {
  final String message;
  ApprovalError(this.message);
}
