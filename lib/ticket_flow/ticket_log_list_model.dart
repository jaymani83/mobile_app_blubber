

/**
 * create model for the abvoe json with fromJson and toJson methods
 */

class TicketLogListModel {
  TicketLogListModel({
    required this.id,
    required this.description,
    required this.detail,
    required this.dueDateTime,
    required this.categoryId,
    required this.taskCategory,
    required this.taskableId,
    required this.taskableType,
    required this.owner,
    required this.completed,
    required this.finalComment,
    required this.createdAt,
    required this.updatedAt,
    required this.completedByOwner,
    required this.followedBy,
    required this.lastUpdatedBy,
    required this.officename,
    required this.locationName,
    required this.ownerCompanyName,
    required this.firstLogCmpltDescription,
    required this.logs,
    required this.ownerName,
    required this.followed,

  });

  int? id;
  String? description;
  String? detail;
  String? dueDateTime;
  int? categoryId;
  int? taskCategory;
  int? taskableId;
  String? taskableType;
  int? owner;
  int? completed;
  String? finalComment;
  String? createdAt;
  String? updatedAt;
  int? completedByOwner;
  int? followedBy;
  int? lastUpdatedBy;
  String? officename;
  String? locationName;
  String? ownerCompanyName;
  String? firstLogCmpltDescription;
  List<Log>? logs;
  String? ownerName;
  Followed? followed;


   TicketLogListModel.fromJson(Map<String, dynamic> json) {
     // id: json["id"]??0,
     // description: json["description"]??'',
     // detail: json["detail"]??'',
     // dueDateTime: json["due_date_time"]??'',
     // categoryId: json["category_id"]??0,
     // taskCategory: json["task_category"]??0,
     // taskableId: json["taskable_id"]??0,
     // taskableType: json["taskable_type"]??'',
     // owner: json["owner"]??0,
     // completed: json["completed"]??0,
     // finalComment: json["final_comment"]??'',
     // createdAt: json["created_at"]??'',
     // updatedAt: json["updated_at"]??'',
     // completedByOwner: json["completed_by_owner"]??0,
     // followedBy: json["followed_by"]??0,
     // lastUpdatedBy: json["last_updated_by"]??0,
     // officename: json["officename"]??'',
     // locationName: json["location_name"]??'',
     // "first_log": {
     // "id": 7928,
     // "complaint_id": 1594,
     // "complaint_question_id": 0,
     // "complaint_description": "test 24",
     // "client_description": "test 24",
     // },
     //
     // ownerCompanyName: json["owner_company_name"]??'',
     // // owners =
     // // json['owners'] != null ? new Owners.fromJson(json['owners']) : null;
     // // category = json['category'] != null
     // // ? new Category.fromJson(json['category'])
     // // : null;
     // logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
     // );

      id = json["id"]??0;
      description = json["description"]??'';
      detail = json["detail"]??'';
      dueDateTime = json["due_date_time"]??'';
      categoryId = json["category_id"]??0;
      taskCategory = json["task_category"]??0;
      taskableId = json["taskable_id"]??0;
      taskableType = json["taskable_type"]??'';
      owner = json["owner"]??0;
      completed = json["completed"]??0;
      finalComment = json["final_comment"]??'';
      createdAt = json["created_at"]??'';
      updatedAt = json["updated_at"]??'';
      completedByOwner = json["completed_by_owner"]??0;
      followedBy = json["followed_by"]??0;
      lastUpdatedBy = json["last_updated_by"]??0;
      officename = json["officename"]??'';
      locationName = json["location_name"]??'';
      ownerCompanyName = json["owner_company_name"]??'';
      firstLogCmpltDescription = json['first_log']!=null ?
              json['first_log']['complaint_description']??'':null;
      logs = json['logs'] != null
          ? List<Log>.from(json["logs"].map((x) => Log.fromJson(x)))
          : null;
      ownerName = json['owners']['name']??'';
      followed = json['followed'] != null
              ? Followed.fromJson(json['followed']) : null;

   }

}

class Log {
  Log({
    required this.id,
    required this.complaintId,
    required this.complaintQuestionId,
    required this.complaintDescription,
    required this.clientDescription,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.logActivitableId,
    required this.logActivitableType,
    required this.locationId,
    required this.businessId,
    required this.uploadedFiles,
    required this.question,
    required this.createdByuser,
  });

  int? id;
  int? complaintId;
  int? complaintQuestionId;
  String? complaintDescription;
  String? clientDescription;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  int? logActivitableId;
  String? logActivitableType;
  int? locationId;
  int? businessId;
  List<dynamic>? uploadedFiles;
  dynamic? question;
  CreatedByuser? createdByuser;

   Log.fromJson(Map<String, dynamic> json) {
      id = json["id"] ?? 0;
      complaintId = json["complaint_id"]??0;
      complaintQuestionId = json["complaint_question_id"]??0;
      complaintDescription = json["complaint_description"]??'';
      clientDescription = json["client_description"]??'';

      createdBy = json["created_by"]??0;
      createdAt = json["created_at"]??'';
      updatedAt = json["updated_at"]??'';
      logActivitableId = json["log_activitable_id"]??0;
      logActivitableType = json["log_activitable_type"]??'';
      locationId = json["location_id"]??0;
      businessId = json["business_id"]??0;
      uploadedFiles = json["uploaded_files"]??[];
      question = json["question"]??'';
      createdByuser =json["created_byuser"] == null ? null :
          CreatedByuser.fromJson(json["created_byuser"]);

   }


}

class CreatedByuser {
  CreatedByuser({
    required this.id,
    required this.companyId,
    required this.prefix,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.mobile
  });

  int? id;
  int? companyId;
  String? prefix;
  String? name;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? mobile;

  CreatedByuser.fromJson(Map<String, dynamic> json) {

    id = json["id"]??0;
    companyId = json["company_id"]??0;
    prefix = json["prefix"]??'';
    name = json["name"]??'';
    firstName = json["first_name"]??'';
    lastName = json["last_name"]??'';
    username = json["username"]??'';
    email = json["email"]??'';
    mobile = json["mobile"]??'';

  }


  // "followed": {
  // "id": 1,
  // "company_id": 6,
  // "prefix": "Mr.",
  // "name": "Super Admin",
  // "first_name": "Super",
  // "last_name": "Admin",
  // "username": "superadmin",
  // "email": "superadmin@testblubber.com",
  // "mobile": "9790484830",
  // "handles": [
  // {
  //   "name": "Super Admin",
  // "mobile": "9790484830",
  // }
  // ]


}

class Followed {
  Followed({
    required this.id,
    required this.companyId,
    required this.prefix,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.mobile,
    required this.handles,
  });

  int? id;
  int? companyId;
  String? prefix;
  String? name;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  String? mobile;
  List<Handle>? handles;

  Followed.fromJson(Map<String, dynamic> json) {
    id = json["id"]??0;
    companyId = json["company_id"]??0;
    prefix = json["prefix"]??'';
    name = json["name"]??'';
    firstName = json["first_name"]??'';
    lastName = json["last_name"]??'';
    username = json["username"]??'';
    email = json["email"]??'';
    mobile = json["mobile"]??'';
    handles = json["handles"] != null
        ? List<Handle>.from(json["handles"].map((x) => Handle.fromJson(x)))
        : null;
  }
}


class Handle {
  Handle({
    required this.name,
    required this.mobile,
  });

  String? name;
  String? mobile;

  Handle.fromJson(Map<String, dynamic> json) {
    name = json["name"]??'';
    mobile = json["mobile"]??'';
  }
}

