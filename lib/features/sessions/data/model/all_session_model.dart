import 'package:zanadu/features/health_coach/data/model/health_coach_model.dart';

class AllSessionModel {
  int? length;
  List<Sessions>? sessions;

  AllSessionModel({this.length, this.sessions});

  AllSessionModel.fromJson(Map<String, dynamic> json) {
    length = json['length'];
    if (json['sessions'] != null) {
      sessions = <Sessions>[];
      json['sessions'].forEach((v) {
        sessions!.add(new Sessions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['length'] = this.length;
    if (this.sessions != null) {
      data['sessions'] = this.sessions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sessions {
  String? sId;
  int? uid;
  String? sessionType;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  String? chatroomId;
  int? noOfSlots;
  String? coachId;
  String? offeringId;
  List<String>? userId;
  String? channelName;
  bool? isApproved;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? reasonMessage;
  CoachInfo? coachInfo;
  CoachProfile? coachProfile;

  Sessions(
      {this.sId,
      this.sessionType,
      this.title,
      this.chatroomId,
      this.description,
      this.startDate,
      this.endDate,
      this.noOfSlots,
      this.coachId,
      this.offeringId,
      this.userId,
      this.uid,
      this.channelName,
      this.isApproved,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.reasonMessage,
      this.coachInfo,
      this.coachProfile});

  Sessions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    uid = json['uid'];
    sessionType = json['sessionType'];
    title = json['title'];
    description = json['description'];
    chatroomId = json['chatroomId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    noOfSlots = json['noOfSlots'];
    coachId = json['coachId'];
    offeringId = json['offeringId'];
    userId = json['userId'].cast<String>();
    channelName = json['channelName'];
    isApproved = json['isApproved'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    reasonMessage = json['reasonMessage'];
    coachInfo = json['coachInfo'] != null
        ? new CoachInfo.fromJson(json['coachInfo'])
        : null;
    coachProfile = json['coachProfile'] != null
        ? new CoachProfile.fromJson(json['coachProfile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['sessionType'] = this.sessionType;
    data['title'] = this.title;
    data['uid'] = this.uid;
    data['description'] = this.description;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['noOfSlots'] = this.noOfSlots;
    data['coachId'] = this.coachId;
    data['offeringId'] = this.offeringId;
    data['chatroomId'] = this.chatroomId;
    data['userId'] = this.userId;
    data['channelName'] = this.channelName;
    data['isApproved'] = this.isApproved;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['reasonMessage'] = this.reasonMessage;
    if (this.coachInfo != null) {
      data['coachInfo'] = this.coachInfo!.toJson();
    }
    if (this.coachProfile != null) {
      data['coachProfile'] = this.coachProfile!.toJson();
    }
    return data;
  }
}

class CoachInfo {
  String? sId;
  String? userId;
  String? offeringId;
  String? description;
  String? image;
  String? likes;
  String? rating;
  List<MyVideos>? myVideos;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isPrimary;

  CoachInfo(
      {this.sId,
      this.userId,
      this.offeringId,
      this.description,
      this.image,
      this.likes,
      this.rating,
      this.myVideos,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isPrimary});

  CoachInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    offeringId = json['offeringId'];
    description = json['description'];
    image = json['image'];
    likes = json['likes'];
    rating = json['rating'];
    if (json['myVideos'] != null) {
      myVideos = <MyVideos>[];
      json['myVideos'].forEach((v) {
        myVideos!.add(new MyVideos.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isPrimary = json['isPrimary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['offeringId'] = this.offeringId;
    data['description'] = this.description;
    data['image'] = this.image;
    data['likes'] = this.likes;
    data['rating'] = this.rating;
    if (this.myVideos != null) {
      data['myVideos'] = this.myVideos!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isPrimary'] = this.isPrimary;
    return data;
  }
}

class CoachProfile {
  String? sId;
  String? userId;
  Profile? profile;
  bool? isApproved;
  IsVerifed? isVerifed;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CoachProfile(
      {this.sId,
      this.userId,
      this.profile,
      this.isApproved,
      this.isVerifed,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CoachProfile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
    isApproved = json['isApproved'];
    isVerifed = json['isVerifed'] != null
        ? new IsVerifed.fromJson(json['isVerifed'])
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    data['isApproved'] = this.isApproved;
    if (this.isVerifed != null) {
      data['isVerifed'] = this.isVerifed!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Profile {
  String? fullName;
  String? phone;
  String? dOB;
  String? gender;
  AreaOfSpecialization? areaOfSpecialization;
  String? country;
  String? state;
  String? image;
  Documents? documents;
  String? experience;
  String? designation;
  String? bio;

  Profile(
      {this.fullName,
      this.phone,
      this.dOB,
      this.gender,
      this.areaOfSpecialization,
      this.country,
      this.state,
      this.image,
      this.documents,
      this.experience,
      this.designation,
      this.bio});

  Profile.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    phone = json['phone'];
    dOB = json['DOB'];
    gender = json['gender'];
    areaOfSpecialization = json['areaOfSpecialization'] != null
        ? new AreaOfSpecialization.fromJson(json['areaOfSpecialization'])
        : null;
    country = json['country'];
    state = json['state'];
    image = json['image'];
    documents = json['documents'] != null
        ? new Documents.fromJson(json['documents'])
        : null;
    experience = json['experience'];
    designation = json['designation'];
    bio = json['bio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['phone'] = this.phone;
    data['DOB'] = this.dOB;
    data['gender'] = this.gender;
    if (this.areaOfSpecialization != null) {
      data['areaOfSpecialization'] = this.areaOfSpecialization!.toJson();
    }
    data['country'] = this.country;
    data['state'] = this.state;
    data['image'] = this.image;
    if (this.documents != null) {
      data['documents'] = this.documents!.toJson();
    }
    data['experience'] = this.experience;
    data['designation'] = this.designation;
    data['bio'] = this.bio;
    return data;
  }
}

class AreaOfSpecialization {
  HealthCoachId? healthCoachId;
  List<HealthCoachId>? specalityCoatchId;

  AreaOfSpecialization({this.healthCoachId, this.specalityCoatchId});

  AreaOfSpecialization.fromJson(Map<String, dynamic> json) {
    healthCoachId = json['healthCoachId'] != null
        ? new HealthCoachId.fromJson(json['healthCoachId'])
        : null;
    if (json['specalityCoatchId'] != null) {
      specalityCoatchId = <HealthCoachId>[];
      json['specalityCoatchId'].forEach((v) {
        specalityCoatchId!.add(new HealthCoachId.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.healthCoachId != null) {
      data['healthCoachId'] = this.healthCoachId!.toJson();
    }
    if (this.specalityCoatchId != null) {
      data['specalityCoatchId'] =
          this.specalityCoatchId!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HealthCoachId {
  String? id;
  String? name;

  HealthCoachId({this.id, this.name});

  HealthCoachId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Documents {
  String? profileDoc;
  String? govrnmentIssuedId;
  String? certificate;

  Documents({this.profileDoc, this.govrnmentIssuedId, this.certificate});

  Documents.fromJson(Map<String, dynamic> json) {
    profileDoc = json['profileDoc'];
    govrnmentIssuedId = json['govrnmentIssuedId'];
    certificate = json['certificate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileDoc'] = this.profileDoc;
    data['govrnmentIssuedId'] = this.govrnmentIssuedId;
    data['certificate'] = this.certificate;
    return data;
  }
}

class IsVerifed {
  String? token;
  bool? status;

  IsVerifed({this.token, this.status});

  IsVerifed.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['status'] = this.status;
    return data;
  }
}
