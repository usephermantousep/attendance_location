import 'package:attendance_location/model/models.dart';
import 'package:attendance_location/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_location_state.dart';

class CreateLocationCubit extends Cubit<CreateLocationState> {
  CreateLocationCubit() : super(CreateLocationInitial());

  void addLocation(LocationModel location) async {
    emit(CreateLocationLoading());

    final response = await LocationServices.addLocation(location);

    if (response.value ?? false) {
      emit(CreateLocationSuccess());
    } else {
      emit(CreateLocationFailed(response.message ?? 'Error'));
    }
  }
}
