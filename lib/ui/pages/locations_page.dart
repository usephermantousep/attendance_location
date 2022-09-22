part of 'pages.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({super.key});

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
                'Attendance Location',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: AppStyle.bigTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(child: BlocBuilder<GetLocationCubit, GetLocationState>(
                builder: (context, state) {
                  if (state is GetLocationSuccess) {
                    return ListView.builder(
                      itemBuilder: (context, index) => Card(
                        color: Colors.yellow.shade50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                state.locations[index].locationName
                                    .toUpperCase(),
                                style: AppStyle.mediumTextStyle
                                    .copyWith(color: Colors.yellow.shade800),
                              ),
                              InkWell(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MapPage(
                                      location: state.locations[index],
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Map View',
                                  style: AppStyle.extraSmallTextStyle
                                      .copyWith(color: Colors.yellow.shade800),
                                ),
                              )
                            ],
                          ),
                        ),
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
}
