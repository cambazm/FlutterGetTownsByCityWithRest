import 'package:citiesrest/services/town_response.dart';
import 'package:citiesrest/services/city_service_client.dart';
import 'package:citiesrest/services/remote_data_source.dart';
import 'package:flutter/material.dart';

class TownsScreen extends StatefulWidget {
  final String cityId;
  TownsScreen({this.cityId});

  @override
  _TownsScreenState createState() => _TownsScreenState();
}

class _TownsScreenState extends State<TownsScreen> {
  RemoteDataSource _apiResponse = RemoteDataSource();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ilceler"),
      ),
      body: Center(
        child: FutureBuilder(
            future: _apiResponse.getTowns(widget.cityId),
            builder: (BuildContext context, AsyncSnapshot<Result> snapshot) {
              if (snapshot.data is SuccessState) {
                TownResponse response = (snapshot.data as SuccessState).value;
                return ListView.builder(
                    itemCount: response.data.length,
                    itemBuilder: (context, index) {
                      return new ListTile(
                        title: Text(response.data[index].name),
                        subtitle: Text(response.data[index].id),
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
}