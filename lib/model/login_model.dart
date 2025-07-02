class LoginModel{

  int? id;
  String? token;
  int? company_id;
  String? prefix;
  String? name;
  String? first_name;
  String? last_name;
  String? username;
  String? email;
  String? mobile;
  int? gender_id;
  String? profile_photo;
  int? business_id;
  int? user_type;
  String? department;
  String? companyname;
  int? user_id;
  int? verified;
  int? email_verified;
  String? employeeName;
  String? employeeNumber;
  String? officeno;
  int? is_admin;
  int? network_id;
  String? network_name;
  int? organization_id;
  String? organization_name;
  String? policy_number;
  String? policy_name;
  String? role;
  String? company_name;
  int? statucode;
  String? message;
  int? location_id;
  String? location_name;
  String? apiEndPoint;
  String? endPointLogo;


  LoginModel({
    this.id,
    this.token,
    this.company_id,
    this.prefix,
    this.name,
    this.first_name,
    this.last_name,
    this.username,
    this.email,
    this.mobile,
  this.gender_id,
  this.profile_photo,
  this.business_id,
  this.user_type,
  this.department,
  this.companyname,
  this.user_id,
  this.verified,
  this.email_verified,
  this.employeeName,
  this.employeeNumber,
  this.officeno,
  this.is_admin,
  this.network_id,
  this.network_name,
  this.organization_id,
  this.organization_name,
  this.policy_number,
  this.policy_name,
  this.role,
  this.company_name,
    this.statucode,
    this.message,
    this.location_id,
    this.location_name,
    this.apiEndPoint,
    this.endPointLogo
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      id: json['id'] ?? 0,
      token: json['accessToken']?.toString() ?? '',
      company_id: json['company_id'] ?? 0,
      prefix: json['prefix']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      first_name: json['first_name']?.toString() ?? '',
      last_name: json['last_name']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      mobile: json['mobile']?.toString() ?? '',
      gender_id: json['gender_id'] ?? 0,
      profile_photo: json['profile_photo']?.toString() ?? '',
      business_id: json['business_id'] ?? 0,
      user_type: json['user_type'] ?? 0,
      department: json['department']?.toString() ?? '',
      companyname: json['companyname']?.toString() ?? '',
      user_id: json['user_id'] ?? 0,
      verified: json['verified'] ?? 0,
      email_verified: json['email_verified'] ?? 0,
      employeeName: json['employeeName']?.toString() ?? '',
      employeeNumber: json['employeeNumber']?.toString() ?? '',
      officeno: json['officeno']?.toString() ?? '',
      is_admin: json['is_admin'] ?? 0,
      network_id: json['network_id'] ?? 0,
      network_name: json['network_name']?.toString() ?? '',
      organization_id: json['organization_id'] ?? 0,
      organization_name: json['organization_name']?.toString() ?? '',
      policy_number: json['policy_number']?.toString() ?? '',
      policy_name: json['policy_name']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      statucode: json['statucode'] ?? 201,
      message: json['message']?.toString() ?? '',
      location_id: json['business_locations'][0]['location_id']??'',
      location_name: json['business_locations'][0]['location_centre_name']??'',
      apiEndPoint: json['end_point']?.toString() ?? '',
      endPointLogo: json['end_point_logo']?.toString() ?? '',
    );
  }

}