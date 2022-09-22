import 'package:attendance_location/cubits/cubits.dart';
import 'package:attendance_location/cubits/location_permission/location_permission_cubit.dart';
import 'package:attendance_location/ui/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CreateLocationCubit(),
          ),
          BlocProvider(
            create: (context) => GetLocationCubit(),
          ),
          BlocProvider(
            create: (context) => LocationPermissionCubit(),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ));
  }
}
