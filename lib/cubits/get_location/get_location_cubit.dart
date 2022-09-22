import 'package:attendance_location/model/models.dart';
import 'package:attendance_location/services/services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_location_state.dart';

class GetLocationCubit extends Cubit<GetLocationState> {
  GetLocationCubit() : super(GetLocationInitial());

  void getLocations() async {
    emit(GetLocationLoading());
    final response = await LocationServices.getLocations();
    if (response.value != null) {
      emit(GetLocationSuccess(response.value!));
    } else {
      emit(GetLocationFailed(response.message ?? 'Error'));
    }
  }
}
