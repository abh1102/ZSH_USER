class LoginModel {
  String? email;
  String? role;
  int? uid;
  String? companyName;
  String? accessToken;

  LoginModel({this.email, this.role, this.companyName, this.accessToken});

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    role = json['role'];
    uid = json['uid'];
    companyName = json['companyName'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['role'] = role;
    data['uid'] = uid;
    data['companyName'] = companyName;
    data['accessToken'] = accessToken;
    return data;
  }
}
