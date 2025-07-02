import 'dart:convert';

class BusinessLocationListModel {
  List<BusinessLocation>? ticketList;

  BusinessLocationListModel({this.ticketList});

  BusinessLocationListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      ticketList = <BusinessLocation>[];
      json['data'].forEach((v) {
        ticketList!.add(BusinessLocation.fromJson(v));
      });
    }
  }
}


class BusinessLocation {
  List<ImageResource>? images;
  String? cityName;
  String? locationName;
  String? address;

  BusinessLocation(
      {required this.images, required this.cityName, required this.locationName, required this.address});


  BusinessLocation.fromJson(Map<String, dynamic> json){
  if (json['image'] != null) {
    images = <ImageResource>[];
    json['image'].forEach((v) {
      images?.add(new ImageResource.fromJson(v));
    });
  }
  cityName = json['city_name'];
  locationName = json['location_name'];
  address = json['address'];

}

}

class ImageResource {
  final String publicUrl;

  ImageResource({required this.publicUrl});

  factory ImageResource.fromJson(Map<String, dynamic> json) {
    return ImageResource(
      publicUrl: json['public_url'],
    );
  }
}

List<BusinessLocation> parseLocations(String responseBody) {
  final parsed = jsonDecode(responseBody);
  return parsed['data'].map<BusinessLocation>((json) => BusinessLocation.fromJson(json)).toList();
}
