import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/api_network.dart';
import 'business_location.dart';


class LocationsPage extends StatefulWidget {
  @override
  _LocationsPageState createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  List<BusinessLocation>? futureLocations;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLocations();

  }


  void fetchLocations() async {

    final response = await Services().getBusinessLocation(context);
    if (response != null) {
      setState(() {
        futureLocations = response;

        print(futureLocations!.length.toString());
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: futureLocations!.length,
              itemBuilder: (context, index) {
                return LocationCard(location: futureLocations![index]);
              },
            ),
    );
  }
}

class LocationCard extends StatelessWidget {
  final BusinessLocation location;

  LocationCard({required this.location});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          location.images?.isNotEmpty == true
              ? Image.network(location.images?.first.publicUrl??'')
              : SizedBox(),
          //Image.network(location.images?.first.publicUrl??''),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              location.locationName??'',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              location.address??'',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              location.cityName??'',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
