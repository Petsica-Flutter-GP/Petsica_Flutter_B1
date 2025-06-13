
import 'package:equatable/equatable.dart';
import 'package:petsica/features/profiles/adminn/services/model/clinic_details_request.dart';

abstract class ClinicDetailsState extends Equatable {
  const ClinicDetailsState();

  @override
  List<Object?> get props => [];
}

class ClinicDetailsInitial extends ClinicDetailsState {}

class ClinicDetailsLoading extends ClinicDetailsState {}

class ClinicDetailsLoaded extends ClinicDetailsState {
  final ClinicDetailsRequest clinicDetails;

  const ClinicDetailsLoaded(this.clinicDetails);

  @override
  List<Object?> get props => [clinicDetails];
}

class ClinicDetailsError extends ClinicDetailsState {
  final String message;

  const ClinicDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}
