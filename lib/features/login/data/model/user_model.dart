class UserModel {
  UserInfo? userInfo;
  dynamic finalScore;
  List<SelectedCoaches>? selectedCoaches;
  int? countSelectedCoacth;

  UserModel(
      {this.userInfo,
      this.finalScore,
      this.selectedCoaches,
      this.countSelectedCoacth});

  UserModel.fromJson(Map<String, dynamic> json) {
    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
    finalScore = json['finalScore'];
    if (json['selectedCoaches'] != null) {
      selectedCoaches = <SelectedCoaches>[];
      json['selectedCoaches'].forEach((v) {
        selectedCoaches!.add(new SelectedCoaches.fromJson(v));
      });
    }
    countSelectedCoacth = json['countSelectedCoacth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo!.toJson();
    }
    data['finalScore'] = this.finalScore;
    if (this.selectedCoaches != null) {
      data['selectedCoaches'] =
          this.selectedCoaches!.map((v) => v.toJson()).toList();
    }
    data['countSelectedCoacth'] = this.countSelectedCoacth;
    return data;
  }
}

class UserInfo {
  String? userId;
  Name? name;
  Profile? profile;
  String? empID;
  String? department;
  String? designation;
  String? companyName;
  String? createdAt;

  UserInfo(
      {this.userId,
      this.name,
      this.profile,
      this.empID,
      this.department,
      this.designation,
      this.companyName,
      this.createdAt});

  UserInfo.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    empID = json['empID'];
    department = json['department'];
    designation = json['designation'];
    companyName = json['companyName'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    data['empID'] = this.empID;
    data['department'] = this.department;
    data['designation'] = this.designation;
    data['companyName'] = this.companyName;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Name {
  String? firstName;
  String? lastName;

  Name({this.firstName, this.lastName});

  Name.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    return data;
  }
}

class Profile {
  String? image;
  String? fullName;
  String? phone;
  String? dOB;
  String? gender;
  List<String>? topHealthChallenges;
  String? state;

  Profile(
      {this.fullName,
      this.phone,
      this.dOB,
      this.gender,
      this.image,
      this.topHealthChallenges,
      this.state});

  Profile.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    phone = json['phone'];
    dOB = json['DOB'];
    gender = json['gender'];
    topHealthChallenges = json['topHealthChallenges'].cast<String>();
    state = json['state'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['phone'] = this.phone;
    data['DOB'] = this.dOB;
    data['gender'] = this.gender;
    data['topHealthChallenges'] = this.topHealthChallenges;
    data['state'] = this.state;
     data['image'] = this.image;
    return data;
  }
}

class SelectedCoaches {
  CoachId? coachId;
  String? sId;
  String? userId;
  String? coachType;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SelectedCoaches(
      {this.coachId,
      this.sId,
      this.userId,
      this.coachType,
      this.isActive,
      this.createdAt,
      this.updatedAt,
      this.iV});

  SelectedCoaches.fromJson(Map<String, dynamic> json) {
    coachId =
        json['coachId'] != null ? new CoachId.fromJson(json['coachId']) : null;
    sId = json['_id'];
    userId = json['userId'];
    coachType = json['coachType'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.coachId != null) {
      data['coachId'] = this.coachId!.toJson();
    }
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['coachType'] = this.coachType;
    data['isActive'] = this.isActive;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class CoachId {
  String? id;
  List<String>? recommendedOffering;

  CoachId({this.id, this.recommendedOffering});

  CoachId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recommendedOffering = json['recommendedOffering'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['recommendedOffering'] = this.recommendedOffering;
    return data;
  }
}
