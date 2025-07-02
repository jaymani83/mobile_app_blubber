
class RootRoomListModel{
  List<RoomListModel>? roomList;

  RootRoomListModel({this.roomList});

  RootRoomListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      roomList = <RoomListModel>[];
      json['data'].forEach((v) {
        roomList!.add(new RoomListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.roomList != null) {
      data['roomList'] = this.roomList!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'RootRoomListModel{roomList: $roomList}';
  }

  void addAll(RootRoomListModel orRoomListModel) {
    roomList?.addAll(orRoomListModel.roomList!);
  }

}


class RoomListModel{
  int? id;
  String? room_id;
  String? name;
  String? description;
  int? location_id;
  int? layout_id;
  String? hour_price;
  String? half_price;
  String? full_price;
  String? created_at;
  String? updated_at;
  int? status;
  int? max_capacity;
  Location? location;
  List<Amenities>? amenities;
  List<RoomFiles>? roomFiles;

  RoomListModel({
    this.id,
    this.room_id,
    this.name,
    this.description,
    this.location_id,
    this.layout_id,
    this.hour_price,
    this.half_price,
    this.full_price,
    this.created_at,
    this.updated_at,
    this.status,
    this.max_capacity,
    this.location,
    this.amenities,
    this.roomFiles
  });

  RoomListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    room_id = json['room_id'];
    name = json['name'];
    description = json['description'];
    location_id = json['location_id'];
    layout_id = json['layout_id'];
    hour_price = json['hour_price'];
    half_price = json['half_price'];
    full_price = json['full_price'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    status = json['status'];
    max_capacity = json['max_capacity']??0;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    if (json['amenities'] != null) {
      amenities = <Amenities>[];
      json['amenities'].forEach((v) {
        amenities!.add(new Amenities.fromJson(v));
      });
    }
    if (json['room_files'] != null) {
      roomFiles = <RoomFiles>[];
      json['room_files'].forEach((v) {
        roomFiles!.add(new RoomFiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['room_id'] = this.room_id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['location_id'] = this.location_id;
    data['layout_id'] = this.layout_id;
    data['hour_price'] = this.hour_price;
    data['half_price'] = this.half_price;
    data['full_price'] = this.full_price;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    data['status'] = this.status;
    data['max_capacity'] = this.max_capacity;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.amenities != null) {
      data['amenities'] = this.amenities!.map((v) => v.toJson()).toList();
    }
    if (this.roomFiles != null) {
      data['room_files'] = this.roomFiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'RoomListModel{id: $id, room_id: $room_id, name: $name, description: $description, location_id: $location_id, layout_id: $layout_id, hour_price: $hour_price, half_price: $half_price, full_price: $full_price, created_at: $created_at, updated_at: $updated_at, status: $status, max_capacity: $max_capacity, location: $location}';
  }




}

/**
 * create location model
 */
class Location {
  int? id;
  int? business_id;
  String? centre_name;
  String? landlord_name;
  String? locality;
  String? landlord_address;
  String? total_carpet_area;
  String? total_super_area;
  int? created_by;
  String? created_at;
  String? updated_at;
  String? cgst;
  String? sgst;
  String? bank;
  String? branch;
  String? accountno;
  String? ifsc;
  String? swift;
  String? pan;
  String? gstin;
  String? city_name;
  String? location_address;

  Location(
      {this.id,
        this.business_id,
        this.centre_name,
        this.landlord_name,
        this.locality,
        this.landlord_address,
        this.total_carpet_area,
        this.total_super_area,
        this.created_by,
        this.created_at,
        this.updated_at,
        this.cgst,
        this.sgst,
        this.bank,
        this.branch,
        this.accountno,
        this.ifsc,
        this.swift,
        this.pan,
        this.gstin,
        this.city_name,this.location_address});

  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    business_id = json['business_id'];
    centre_name = json['centre_name'];
    landlord_name = json['landlord_name'];
    locality = json['locality'];
    landlord_address = json['landlord_address'];
    total_carpet_area = json['total_carpet_area'];
    total_super_area = json['total_super_area'];
    created_by = json['created_by'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    cgst = json['cgst'];
    sgst = json['sgst'];
    bank = json['bank'];
    branch = json['branch'];
    accountno = json['accountno'];
    ifsc = json['ifsc'];
    swift = json['swift'];
    pan = json['pan'];
    gstin = json['gstin'];
    city_name = json['city_name'];
    location_address = json['location_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_id'] = this.business_id;
    data['centre_name'] = this.centre_name;
    data['landlord_name'] = this.landlord_name;
    data['locality'] = this.locality;
    data['landlord_address'] = this.landlord_address;
    data['total_carpet_area'] = this.total_carpet_area;
    data['total_super_area'] = this.total_super_area;
    data['created_by'] = this.created_by;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    data['cgst'] = this.cgst;
    data['sgst'] = this.sgst;
    data['bank'] = this.bank;
    data['branch'] = this.branch;
    data['accountno'] = this.accountno;
    data['ifsc'] = this.ifsc;
    data['swift'] = this.swift;
    data['pan'] = this.pan;
    data['gstin'] = this.gstin;
    data['city_name'] = this.city_name;
    data['location_address'] = this.location_address;
    return data;
  }

  @override
  String toString() {
    return 'Location{id: $id, business_id: $business_id, centre_name: $centre_name, landlord_name: $landlord_name, locality: $locality, landlord_address: $landlord_address, total_carpet_area: $total_carpet_area, total_super_area: $total_super_area, created_by: $created_by, created_at: $created_at, updated_at: $updated_at, cgst: $cgst, sgst: $sgst, bank: $bank, branch: $branch, accountno: $accountno, ifsc: $ifsc, swift: $swift, pan: $pan, gstin: $gstin, '
        'city_name: $city_name, location_address: $location_address}';
  }

}

class Amenities {
  String? title;
  String? icon_url;

  Amenities({this.title, this.icon_url});

  Amenities.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    icon_url = json['icon_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['icon_url'] = this.icon_url;
    return data;
  }

  @override
  String toString() {
    return 'Amenities{title: $title, icon_url: $icon_url}';
  }

}

class RoomFiles {
  String? public_url;
  String? public_thumb_url;

  RoomFiles({this.public_url, this.public_thumb_url});

  RoomFiles.fromJson(Map<String, dynamic> json) {
    public_url = json['public_url'];
    public_thumb_url = json['public_thumb_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['public_url'] = this.public_url;
    data['public_thumb_url'] = this.public_thumb_url;
    return data;
  }

  @override
  String toString() {
    return 'RoomFiles{public_url: $public_url, public_thumb_url: $public_thumb_url}';
  }

}