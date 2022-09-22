part of 'services.dart';

class LocationServices {
  static Future<ApiReturnValue<bool>> addLocation(
      LocationModel location) async {
    final apiReturn =
        await ApiService().post('${ApiUrl.baseUrl}/action/insertOne',
            body: jsonEncode({
              "collection": "location",
              "database": "attendanceApp",
              "dataSource": "Cluster0",
              "document": location.toJson()
            }),
            headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "api-key":
              "K9b4bIUV2hSEZeCh8W0HxRpqwpLhgrI71SbpYDV7V7FzOS7rLhyG15eKMyAG3K7o"
        });

    if (apiReturn.value == null) {
      return ApiReturnValue<bool>(
          value: false, message: (apiReturn as ApiReturnValue).message);
    }
    return ApiReturnValue(value: true);
  }

  static Future<ApiReturnValue<List<LocationModel>>> getLocations() async {
    final apiReturn = await ApiService().post('${ApiUrl.baseUrl}/action/find',
        body: jsonEncode({
          "collection": "location",
          "database": "attendanceApp",
          "dataSource": "Cluster0",
        }),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "api-key":
              "K9b4bIUV2hSEZeCh8W0HxRpqwpLhgrI71SbpYDV7V7FzOS7rLhyG15eKMyAG3K7o"
        });

    if (apiReturn.value == null) {
      return ApiReturnValue<List<LocationModel>>(
          value: null, message: (apiReturn as ApiReturnValue).message);
    }
    List<LocationModel> locations =
        ((apiReturn as ApiReturnValue).value['documents'] as Iterable)
            .map((e) => LocationModel.fromJson(e))
            .toList();
    return ApiReturnValue(value: locations);
  }
}
