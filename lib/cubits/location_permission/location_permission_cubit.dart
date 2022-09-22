import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'location_permission_state.dart';

class LocationPermissionCubit extends Cubit<LocationPermissionState> {
  LocationPermissionCubit() : super(LocationPermissionInitial());

  void getPermisson() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      emit(const LocationPermissionFailed(true));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(const LocationPermissionFailed(false));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      emit(const LocationPermissionFailed(false));
      return;
    }
    if (state is LocationPermissionFailed) {
      emit(const LocationPermissionGranted(true));
    }
    emit(const LocationPermissionGranted(false));
  }
}
