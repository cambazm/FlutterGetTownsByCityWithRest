import 'package:citiesrest/ui/towns_screen.dart';
import 'package:citiesrest/services/city_response.dart';
import 'package:citiesrest/services/city_service_client.dart';
import 'package:citiesrest/services/remote_data_source.dart';
import 'package:flutter/material.dart';

class CitiesScreen extends StatefulWidget {
  @override
  _CitiesScreenState createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  RemoteDataSource _apiResponse = RemoteDataSource();
  String cityId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Turkiye Iller"),
      ),
      body: Center(
        child: FutureBuilder(
            future: _apiResponse.getCities(),
            builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
              if (snapshot.data is SuccessState) {
                CityResponse response = (snapshot.data as SuccessState).value;
                return ListView.builder(
                    itemCount: response.data.length,
                    itemBuilder: (context, index) {
                      return new ListTile(
                        title: Text(response.data[index].name),
                        subtitle: Text(response.data[index].id),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () => onTapped((response.data[index])),
                      );
                    });
              } else if (snapshot.data is ErrorState) {
                String errorMessage = (snapshot.data as ErrorState).msg;
                return Text(errorMessage);
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  void onTapped(City city) {
    cityId = city.id;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TownsScreen(cityId: cityId)),
    );
  }
}

