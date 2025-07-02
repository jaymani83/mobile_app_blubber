

class RootVisitorListModel {
  bool? status;
  String? message;
  List<VisitorListModel>? data;

  RootVisitorListModel({
    this.status,
    this.message,
    this.data
  });

  RootVisitorListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <VisitorListModel>[];
      json['data'].forEach((v) {
        data!.add(new VisitorListModel.fromJson(v));
      });
    }
  }
}

class VisitorListModel{
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? address;
  String? companyname;
  String? employeename;

  String? employeenumber;
  String? checkindate;
  String? checkintime;
  int? status;
  int? location_id;
  String? created_at;
  String? updated_at;
  int? created_by;
  String? updated_by;
  int? company_id;
  String? qr_code;
  String? qr_token;
  String? qr_status;
  String? checkin_at;
  String? location_centre_name;
  String? status_string;
  IdProof? id_proof;

  String? client_company_name;

  VisitorListModel({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.address,
    this.companyname,
    this.employeename,
    this.employeenumber,
    this.checkindate,
    this.checkintime,
    this.status,
    this.location_id,
    this.created_at,
    this.updated_at,
    this.created_by,
    this.updated_by,
    this.company_id,
    this.qr_code,
    this.qr_token,
    this.qr_status,
    this.checkin_at,
    this.location_centre_name,
    this.status_string,
    this.id_proof,
    this.client_company_name
  });

  VisitorListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    companyname = json['companyname'];
    employeename = json['employeename'];
    employeenumber = json['employeenumber'];
    checkindate = json['checkindate'];
    checkintime = json['checkintime'];
    status = json['status'];
    location_id = json['location_id'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    created_by = json['created_by'];
    updated_by = json['updated_by'];
    company_id = json['company_id'];
    qr_code = json['qr_code'];
    qr_token = json['qr_token'];
    qr_status = json['qr_status'];
    checkin_at = json['checkin_at'];
    location_centre_name = json['location_centre_name'];
    status_string = json['status_string'];
    id_proof = json['id_proof'] != null ? new IdProof.fromJson(json['id_proof']) : null;
    client_company_name = json['client_company_name'];
  }

}

class IdProof{
  int? id;
  String? resourceable_id;
  String? resourceable_type;
  String? resource_name;
  String? resource_path;
  String? resource_type;
  String? storage_driver;
  String? created_at;
  String? updated_at;
  String? public_url;
  String? public_thumb_url;

  IdProof({
    this.id,
    this.resourceable_id,
    this.resourceable_type,
    this.resource_name,
    this.resource_path,
    this.resource_type,
    this.storage_driver,
    this.created_at,
    this.updated_at,
    this.public_url,
    this.public_thumb_url
  });

  IdProof.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceable_id = json['resourceable_id'];
    resourceable_type = json['resourceable_type'];
    resource_name = json['resource_name'];
    resource_path = json['resource_path'];
    resource_type = json['resource_type'];
    storage_driver = json['storage_driver'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    public_url = json['public_url'];
    public_thumb_url = json['public_thumb_url'];
  }
}