import 'package:zanadu/features/health_coach/data/model/health_coach_model.dart';

class CurrentSelectedCoachModel {
  String? sId;
  String? userId;
  String? coachType;
  bool? isActive;
  UserInfo? userInfo;
  String? coachId;
  String? offeringId;
  CoachInfo? coachInfo;
  CoachProfile? coachProfile;
  String? offeringsName;
  int? countSessions;

  CurrentSelectedCoachModel(
      {this.sId,
      this.userId,
      this.coachType,
      this.isActive,
      this.userInfo,
      this.coachId,
      this.offeringId,
      this.coachInfo,
      this.coachProfile,
      this.offeringsName,
      this.countSessions});

  CurrentSelectedCoachModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    offeringId = json['offeringId'];
    coachType = json['coachType'];
    isActive = json['isActive'];
    userInfo = json['userInfo'] != null
        ? new UserInfo.fromJson(json['userInfo'])
        : null;
    coachId = json['coachId'];
    coachInfo = json['coachInfo'] != null
        ? new CoachInfo.fromJson(json['coachInfo'])
        : null;
    coachProfile = json['coachProfile'] != null
        ? new CoachProfile.fromJson(json['coachProfile'])
        : null;
    offeringsName = json['offeringsName'];
    countSessions = json['countSessions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['offeringId'] = this.offeringId;
    data['coachType'] = this.coachType;
    data['isActive'] = this.isActive;
    if (this.userInfo != null) {
      data['userInfo'] = this.userInfo!.toJson();
    }
    data['coachId'] = this.coachId;
    if (this.coachInfo != null) {
      data['coachInfo'] = this.coachInfo!.toJson();
    }
    if (this.coachProfile != null) {
      data['coachProfile'] = this.coachProfile!.toJson();
    }
    data['offeringsName'] = this.offeringsName;
    data['countSessions'] = this.countSessions;
    return data;
  }
}

class UserInfo {
  MProfile? profile;

  UserInfo({this.profile});

  UserInfo.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? new MProfile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}

class MProfile {
  String? fullName;

  MProfile({this.fullName});

  MProfile.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    return data;
  }
}

class CoachProfile {
  Profile? profile;

  CoachProfile({this.profile});

  CoachProfile.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
}
