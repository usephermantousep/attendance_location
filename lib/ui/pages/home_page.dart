part of 'pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<LocationPermissionCubit>().getPermisson();
    return Scaffold(
      body: BlocListener<LocationPermissionCubit, LocationPermissionState>(
        listener: (context, state) {
          if (state is LocationPermissionFailed) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => DialogHandlePermission(function: () {
                      if (state.isPop) {
                        Navigator.pop(context);
                      }
                      context.read<LocationPermissionCubit>().getPermisson();
                    }));
          }
          if (state is LocationPermissionGranted) {
            if (state.isPop) {
              Navigator.pop(context);
            }
          }
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateLocationPage(),
                            )),
                        child: MenuHome(
                          icon: Icons.map_rounded,
                          title: 'Create Attendance Location',
                          colorContainer: Colors.green.shade50,
                          colorTextIcon: Colors.green.shade800,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateAttendancePage(),
                          ),
                        ),
                        child: MenuHome(
                          icon: Icons.room_rounded,
                          title: 'Create Live Attendance',
                          colorContainer: Colors.red.shade50,
                          colorTextIcon: Colors.red.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LocationsPage(),
                      ),
                    ),
                    child: MenuHome(
                      icon: Icons.check_circle_rounded,
                      title: 'Attendance Locations',
                      colorContainer: Colors.yellow.shade50,
                      colorTextIcon: Colors.yellow.shade800,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
