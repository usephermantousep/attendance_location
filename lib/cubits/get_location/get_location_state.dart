part of 'get_location_cubit.dart';

abstract class GetLocationState extends Equatable {
  const GetLocationState();

  @override
  List<Object> get props => [];
}

class GetLocationInitial extends GetLocationState {}

class GetLocationLoading extends GetLocationState {}

class GetLocationSuccess extends GetLocationState {
  final List<LocationModel> locations;

  const GetLocationSuccess(this.locations);

  @override
  List<Object> get props => [locations];
}

class GetLocationFailed extends GetLocationState {
  final String message;

  const GetLocationFailed(this.message);

  @override
  List<Object> get props => [message];
}
