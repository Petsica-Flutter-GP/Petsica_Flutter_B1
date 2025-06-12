
import 'package:petsica/features/profiles/sitter/models/sitter_services_model.dart';

abstract class SitterServicesState {}

class SitterServicesInitial extends SitterServicesState {}

class SitterServicesLoading extends SitterServicesState {}

class SitterServicesLoaded extends SitterServicesState {
  final List<SitterServiceModel> services;

  SitterServicesLoaded(this.services);
}

class SitterServicesError extends SitterServicesState {
  final String message;

  SitterServicesError(this.message);
}
