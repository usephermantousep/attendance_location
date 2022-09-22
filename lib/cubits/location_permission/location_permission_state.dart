part of 'location_permission_cubit.dart';

abstract class LocationPermissionState extends Equatable {
  const LocationPermissionState();

  @override
  List<Object> get props => [];
}

class LocationPermissionInitial extends LocationPermissionState {}

class LocationPermissionGranted extends LocationPermissionState {
  final bool isPop;
  const LocationPermissionGranted(this.isPop);

  @override
  List<Object> get props => [isPop];
}

class LocationPermissionFailed extends LocationPermissionState {
  final bool isPop;
  const LocationPermissionFailed(this.isPop);

  @override
  List<Object> get props => [isPop];
}
