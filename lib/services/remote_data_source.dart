import 'dart:async';
import 'package:turkish/turkish.dart';
import 'package:http/http.dart';

import 'town_response.dart';
import 'city_service_client.dart';
import 'city_response.dart';

class RemoteDataSource {
  //Creating Singleton
  RemoteDataSource._privateConstructor();
  static final RemoteDataSource _apiResponse =
      RemoteDataSource._privateConstructor();
  factory RemoteDataSource() => _apiResponse;

  CityServiceClient client = CityServiceClient(Client());

  Future<Result> getCities() async {
    try {
      final response =
      await client.request(requestType: RequestType.GET, path: "cities");
      if (response.statusCode == 200) {
        CityResponse r = CityResponse.fromRawJson(response.body);
        r.data..sort((a, b) {
          return turkish.comparatorIgnoreCase(a.name, b.name);
        });
        return Result<CityResponse>.success(r);
      } else {
        return Result.error("Sehirler bulunamadi");
      }
    } catch (error) {
      return Result.error("Hata olustu!");
    }
  }

  Future<Result> getTowns(String cityId) async {
    try {
      final response =
      await client.request(requestType: RequestType.GET, path: "cities/"+cityId+"/towns");
      if (response.statusCode == 200) {
        TownResponse r = TownResponse.fromRawJson(response.body);
        r.data..sort((a, b) {
          return turkish.comparatorIgnoreCase(a.name, b.name);
        });
        return Result<TownResponse>.success(r);
      } else {
        return Result.error("Ilceler bulunamadi");
      }
    } catch (error) {
      return Result.error("Hata olustu!");
    }
  }
}
