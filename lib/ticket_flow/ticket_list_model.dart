
class RootTicketListModel {
  List<TicketListModel>? ticketList;

  RootTicketListModel({this.ticketList});

  RootTicketListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      ticketList = <TicketListModel>[];
      json['data'].forEach((v) {
        ticketList!.add(new TicketListModel.fromJson(v));
      });
    }
  }
}

class TicketListModel{

  int? id;
  String? color;
  String? overdueStatus;
  String? overdueColor;
  String? overdueStatusColor;
  String? taskDescriptionColor;

  FirstLog? firstLog;
  Owners? owners;
  Category? category;
  String? followed_name;
  dynamic followed;
  dynamic maincategory;

  TicketListModel({this.id, this.color,
    this.overdueStatus, this.overdueColor, this.overdueStatusColor, this.taskDescriptionColor,
    this.firstLog, this.owners, this.category,
    this.followed, this.maincategory,this.followed_name});

  TicketListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    color = json['color'];
    overdueStatus = json['overdue_status'];
    overdueColor = json['overdue_color'];
    overdueStatusColor = json['overdue_status_color'];
    taskDescriptionColor = json['task_description_color'];
    firstLog = json['first_log'] != null ? new FirstLog.fromJson(json['first_log']) : null;
    owners =
    json['owners'] != null ? new Owners.fromJson(json['owners']) : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    followed = json['followed'];
    followed_name = json['followed']!=null?json['followed']['name']:'';
    maincategory = json['maincategory'];
  }



 }

class FirstLog {
  int? id;
  int? complaintId;
  String? complaintDescription;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  FirstLog(
      {this.id,
        this.complaintId,
        this.complaintDescription,
        this.createdBy,
        this.createdAt,
        this.updatedAt});

  FirstLog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    complaintId = json['complaint_id'];
    complaintDescription = json['complaint_description'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['complaint_id'] = this.complaintId;
    data['complaint_description'] = this.complaintDescription;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Owners {
  int? id;
  int? companyId;
  String? prefix;
  String? name;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? mobile;
  dynamic profilePhoto;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  String? companyName;

  Owners({this.id,
    this.companyId,
    this.prefix,
    this.name,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.mobile,
    this.profilePhoto,
    this.deletedAt,

    this.createdAt,
    this.updatedAt,
    this.companyName});

  Owners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    prefix = json['prefix'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    profilePhoto = json['profile_photo'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    companyName = json['company_name'];
  }
}

class Category {
  int? id;
  String? name;
  String? color;
  int? active;
  dynamic createdAt;
  String? updatedAt;

  Category({this.id,
    this.name,
    this.color,
    this.active,
    this.createdAt,
    this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}