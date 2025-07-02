
class RootRoomListBookDataModel{
  List<RoomListBookDataModel>? data;

  RootRoomListBookDataModel({
    this.data,
  });

  RootRoomListBookDataModel.fromJson(Map<String, dynamic> json) {

    if (json['data'] != null) {
      data = <RoomListBookDataModel>[];
      json['data'].forEach((v) {
        data!.add(new RoomListBookDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }


}


class RoomListBookDataModel{

  int? id;
  String? companyname;
  int? company_id;
  String? contact_person;
  String? phone;
  String? email;
  String? price;
  int? user_id;
  int? room_id;
  int? layout_id;
  int? location_id;
  int? noofperson;
  String? created_at;
  String? updated_at;
  int? lead_id;
  String? lead_type;
  String? booking_room;
  String? location_centre_name;
  String? booked_by_name;
  String? booking_start_time;
  String? booking_end_time;
  String? status_color;
  String? status_string;
  Detail? detail;

  RoomListBookDataModel({
    this.id,
    this.companyname,
    this.company_id,
    this.contact_person,
    this.phone,
    this.email,
    this.price,
    this.user_id,
    this.room_id,
    this.layout_id,
    this.location_id,
    this.noofperson,
    this.created_at,
    this.updated_at,
    this.lead_id,
    this.lead_type,
    this.booking_room,
    this.location_centre_name,
    this.booked_by_name,
    this.booking_start_time,
    this.booking_end_time,
    this.status_color,
    this.status_string,
    this.detail,
  });

  RoomListBookDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyname = json['companyname'];
    company_id = json['company_id'];
    contact_person = json['contact_person'];
    phone = json['phone'];
    email = json['email'];
    price = json['price'];
    user_id = json['user_id'];
    room_id = json['room_id'];
    layout_id = json['layout_id'];
    location_id = json['location_id'];
    noofperson = json['noofperson'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    lead_id = json['lead_id'];
    lead_type = json['lead_type'];
    booking_room = json['booking_room'];
    location_centre_name = json['location_centre_name'];
    booked_by_name = json['booked_by_name'];
    booking_start_time = json['booking_start_time'];
    booking_end_time = json['booking_end_time'];
    status_color = json['status_color'];
    status_string = json['status_string'];
    detail = json['detail'] != null
        ? new Detail.fromJson(json['detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['companyname'] = this.companyname;
    data['company_id'] = this.company_id;
    data['contact_person'] = this.contact_person;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['price'] = this.price;
    data['user_id'] = this.user_id;
    data['room_id'] = this.room_id;
    data['layout_id'] = this.layout_id;
    data['location_id'] = this.location_id;
    data['noofperson'] = this.noofperson;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    data['lead_id'] = this.lead_id;
    data['lead_type'] = this.lead_type;
    data['booking_room'] = this.booking_room;
    data['location_centre_name'] = this.location_centre_name;
    data['booked_by_name'] = this.booked_by_name;
    data['booking_start_time'] = this.booking_start_time;
    data['booking_end_time'] = this.booking_end_time;
    data['status_color'] = this.status_color;
    data['status_string'] = this.status_string;
    if (this.detail != null) {
      data['detail'] = this.detail!.toJson();
    }
    return data;
  }




}

class Detail {
  int? id;
  int? booking_id;
  String? starttime;
  String? endtime;
  String? comments;
  String? internal_comments;
  String? price;
  String? status;
  String? payment_date;
  String? created_at;
  String? updated_at;
  String? status_color;

  Detail({
    this.id,
    this.booking_id,
    this.starttime,
    this.endtime,
    this.comments,
    this.internal_comments,
    this.price,
    this.status,
    this.payment_date,
    this.created_at,
    this.updated_at,
    this.status_color,
  });

  Detail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    booking_id = json['booking_id'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    comments = json['comments'];
    internal_comments = json['internal_comments'];
    price = json['price'];
    status = json['status'];
    payment_date = json['payment_date'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    status_color = json['status_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['booking_id'] = this.booking_id;
    data['starttime'] = this.starttime;
    data['endtime'] = this.endtime;
    data['comments'] = this.comments;
    data['internal_comments'] = this.internal_comments;
    data['price'] = this.price;
    data['status'] = this.status;
    data['payment_date'] = this.payment_date;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    data['status_color'] = this.status_color;
    return data;
  }
}