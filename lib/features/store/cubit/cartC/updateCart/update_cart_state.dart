abstract class UpdateCartState {}

class UpdateCartInitial extends UpdateCartState {}

class UpdateCartSuccess extends UpdateCartState {}

class UpdateCartFailure extends UpdateCartState {
  final String errorMessage;
  UpdateCartFailure(this.errorMessage);
}
