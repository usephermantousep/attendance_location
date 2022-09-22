part of 'pages.dart';

class CreateAttendancePage extends StatelessWidget {
  const CreateAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<GetLocationCubit>().getLocations();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => context.read<GetLocationCubit>().getLocations(),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Text(
                'Choose and tap one location for attendance',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: AppStyle.bigTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
              Expanded(child: BlocBuilder<GetLocationCubit, GetLocationState>(
                builder: (context, state) {
                  if (state is GetLocationSuccess) {
                    return ListView.builder(
                      itemBuilder: (context, index) => FutureBuilder(
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data!;
                          }
                          return const SizedBox();
                        },
                        future: _createCardIsInRadius(
                            state.locations[index], context),
                      ),
                      itemCount: state.locations.length,
                    );
                  }
                  if (state is GetLocationFailed) {
                    return Text(state.message);
                  }
                  return const ListLoading();
                },
              ))
            ],
          ),
        )),
      ),
    );
  }

  Future<Widget> _createCardIsInRadius(
      LocationModel locations, BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double lat = position.latitude;
    double long = position.longitude;

    double distance =
        Geolocator.distanceBetween(locations.lat, locations.long, lat, long);
    bool inRadius = distance < locations.radius;
    return GestureDetector(
      onTap: () {
        if (inRadius) {}
        showSnackbar(
            context: context,
            message:
                'Attendance ${inRadius ? 'accepted in' : 'rejected out of'} radius',
            isTrue: inRadius);
      },
      child: Card(
        color: inRadius ? Colors.green.shade50 : Colors.red.shade50,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                locations.locationName.toUpperCase(),
                style: AppStyle.mediumTextStyle.copyWith(
                    color:
                        inRadius ? Colors.green.shade800 : Colors.red.shade800),
              ),
              Icon(
                inRadius ? Icons.check : Icons.close_rounded,
                color: inRadius ? Colors.green.shade800 : Colors.red.shade800,
              )
            ],
          ),
        ),
      ),
    );
  }
}
