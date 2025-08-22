class AllHealthCoachesModel {
  String? sId;
  String? userId;
  Profile? profile;
  bool? isApproved;
  IsVerifed? isVerifed;
  String? createdAt;
  String? updatedAt;
  int? iV;
  CoachInfo? coachInfo;
  int? countSessions;

  AllHealthCoachesModel(
      {this.sId,
      this.userId,
      this.profile,
      this.isApproved,
      this.isVerifed,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.coachInfo,
      this.countSessions});

  AllHealthCoachesModel.fromJson(Map<String, dynamic> json) {
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
    coachInfo = json['coachInfo'] != null
        ? new CoachInfo.fromJson(json['coachInfo'])
        : null;
    countSessions = json['countSessions'];
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
    if (this.coachInfo != null) {
      data['coachInfo'] = this.coachInfo!.toJson();
    }
    data['countSessions'] = this.countSessions;
    return data;
  }
}

class Profile {
  String? fullName;
  String? phone;
  String? dOB;
  String? gender;
  AreaOfSpecialization? areaOfSpecialization;
  String? state;
  String? experience;
  String? bio;
  String? primaryOfferingId;
  String? designation;
  String? image;
  Documents? documents;
  String? email;

  Profile(
      {this.fullName,
      this.phone,
      this.dOB,
      this.gender,
      this.areaOfSpecialization,
      this.state,
      this.image,
      this.email});

  Profile.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    phone = json['phone'];
    dOB = json['DOB'];
    gender = json['gender'];
    primaryOfferingId = json['primaryOfferingId'];
    experience = json['experience'];
    bio = json['bio'];

    designation = json['designation'];
    areaOfSpecialization = json['areaOfSpecialization'] != null
        ? new AreaOfSpecialization.fromJson(json['areaOfSpecialization'])
        : null;
    state = json['state'];
    image = json['image'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['phone'] = this.phone;
    data['DOB'] = this.dOB;
    data['gender'] = this.gender;
    data['experience'] = this.experience;
    data['primaryOfferingId'] = this.primaryOfferingId;
    data['bio'] = this.bio;
    data['designation'] = this.designation;
    if (this.areaOfSpecialization != null) {
      data['areaOfSpecialization'] = this.areaOfSpecialization!.toJson();
    }
    data['state'] = this.state;
    data['image'] = this.image;
    data['email'] = this.email;
    return data;
  }
}

class AreaOfSpecialization {
  Health? health;
  List<Health>? special;

  AreaOfSpecialization({this.health, this.special});

  AreaOfSpecialization.fromJson(Map<String, dynamic> json) {
    health = json['health'] != null ? Health.fromJson(json['health']) : null;

    if (json['special'] != null) {
      special = List<Health>.from(
        json['special'].map((specialty) => Health.fromJson(specialty)),
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (health != null) {
      data['health'] = health!.toJson();
    }
    if (special != null) {
      data['special'] =
          special!.map((specialty) => specialty.toJson()).toList();
    }
    return data;
  }
}

class Health {
  String? id;
  String? name;

  Health({this.id, this.name});

  Health.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
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

class CoachInfo {
  String? sId;
  String? userId;
  String? offeringId;
  String? description;
  String? image;
  String? likes;
  String? rating;
  bool? isPrimary;
  List<MyVideos>? myVideos;
  String? createdAt;
  String? updatedAt;
  int? iV;

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
      this.iV});

  CoachInfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    offeringId = json['offeringId'];
    description = json['description'];
    image = json['image'];
    likes = json['likes'];
    rating = json['rating'];
    isPrimary = json['isPrimary'];
    if (json['myVideos'] != null) {
      myVideos = <MyVideos>[];
      json['myVideos'].forEach((v) {
        myVideos!.add(new MyVideos.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
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
    data['isPrimary'] = this.isPrimary;
    if (this.myVideos != null) {
      data['myVideos'] = this.myVideos!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class MyVideos {
  String? title;
  String? videoType;
  String? description;
  List<String>? likes;
  String? thumbnailImage;
  bool? isApproved;
  String? file;
  String? sId;

  MyVideos({
    this.title,
    this.description,
    this.isApproved,
    this.file,
    this.sId,
  });

  MyVideos.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    isApproved = json['isApproved'];
  if (json['likes'] != null) {
      likes = <String>[];
      json['likes'].forEach((v) {
        likes!.add(v);
      });
    }
    thumbnailImage = json['thumbnailImage'];
    file = json['file'];
    videoType = json['videoType'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['isApproved'] = this.isApproved;
    data['thumbnailImage'] = this.thumbnailImage;
    data['file'] = this.file;
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v).toList();
    }
    data['videoType'] = this.videoType;
    data['_id'] = this.sId;
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
