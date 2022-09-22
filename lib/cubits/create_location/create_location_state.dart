part of 'create_location_cubit.dart';

abstract class CreateLocationState extends Equatable {
  const CreateLocationState();

  @override
  List<Object> get props => [];
}

class CreateLocationInitial extends CreateLocationState {}

class CreateLocationLoading extends CreateLocationState {}

class CreateLocationSuccess extends CreateLocationState {}

class CreateLocationFailed extends CreateLocationState {
  final String message;

  const CreateLocationFailed(this.message);

  @override
  List<Object> get props => [message];
}
