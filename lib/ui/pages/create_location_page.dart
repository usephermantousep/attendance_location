part of 'pages.dart';

class CreateLocationPage extends StatefulWidget {
  const CreateLocationPage({super.key});

  @override
  State<CreateLocationPage> createState() => _CreateLocationPageState();
}

class _CreateLocationPageState extends State<CreateLocationPage> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};
  late TextEditingController _locationNameController, _radiusController;
  final _formKey = GlobalKey<FormState>();
  CameraPosition? _cameraPosition;

  void setupLocationGmaps() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      final location = await Geolocator.getCurrentPosition();

      setState(
        () => _cameraPosition = CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: 12,
        ),
      );
    }
  }

  @override
  void initState() {
    setupLocationGmaps();
    _locationNameController = TextEditingController();
    _radiusController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Location Attendance',
                  style: AppStyle.bigTextStyle,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Location Name',
                  style: AppStyle.smallTextStyle,
                  textAlign: TextAlign.start,
                ),
                TextFieldInput(
                  controller: _locationNameController,
                  hintText: 'Input Location Name',
                  keyboardType: TextInputType.text,
                  iconPrefix: Icons.map,
                  validator: (value) => value == null || value.isEmpty
                      ? 'This field is required'
                      : value.length < 3
                          ? "Minimal 3 characters"
                          : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Radius (meter)',
                  style: AppStyle.smallTextStyle,
                  textAlign: TextAlign.start,
                ),
                TextFieldInput(
                  controller: _radiusController,
                  hintText: 'Input Radius',
                  keyboardType: TextInputType.number,
                  iconPrefix: Icons.circle,
                  validator: (value) => value == null || value.isEmpty
                      ? 'This field is required'
                      : RegExp(r'^[0-9]+$').hasMatch(value)
                          ? null
                          : 'Only number input',
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Pin location',
                  style: AppStyle.smallTextStyle,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: StatefulBuilder(
                      builder: (context, setState) => _buildMaps(setState),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocListener<CreateLocationCubit, CreateLocationState>(
                  listener: (context, state) {
                    if (state is CreateLocationLoading) {
                      showDialog(
                        context: context,
                        builder: (context) => const LoadingDialog(),
                      );
                    }

                    if (state is CreateLocationSuccess) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          (route) => false);
                      showSnackbar(
                          context: context,
                          message: 'Success create location attendance',
                          isTrue: true);
                    }

                    if (state is CreateLocationFailed) {
                      Navigator.pop(context);
                      showSnackbar(
                          context: context,
                          message: state.message,
                          isTrue: false);
                    }
                  },
                  child: GestureDetector(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (_markers.isEmpty) {
                          showSnackbar(
                              context: context,
                              message: 'Tap location please',
                              isTrue: false);
                          return;
                        }
                        context.read<CreateLocationCubit>().addLocation(
                              LocationModel(
                                  locationName:
                                      _locationNameController.text.trim(),
                                  radius: double.parse(
                                      _radiusController.text.trim()),
                                  lat: _markers.first.position.latitude,
                                  long: _markers.first.position.longitude),
                            );
                      }
                    },
                    child: const CustomButton(text: 'Save'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  GoogleMap _buildMaps(StateSetter setState) {
    return GoogleMap(
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      onTap: (argument) {
        setState(() => _markers
          ..clear()
          ..add(
            Marker(
              position: LatLng(argument.latitude, argument.longitude),
              markerId: const MarkerId(
                'lokasi',
              ),
              infoWindow: const InfoWindow(title: "lokasi"),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed),
            ),
          ));
      },
      mapType: MapType.normal,
      initialCameraPosition: _cameraPosition ??
          const CameraPosition(
            target: LatLng(-6.1708013, 106.8111871),
            zoom: 12,
          ),
      markers: _markers,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
