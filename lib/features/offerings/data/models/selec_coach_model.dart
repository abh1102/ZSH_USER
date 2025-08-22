class SelectCoachModel {
  String? userId;
  String? coachType;
  CoachId? coachId;
  bool? isActive;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  SelectCoachModel(
      {this.userId,
      this.coachType,
      this.coachId,
      this.isActive,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  SelectCoachModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    coachType = json['coachType'];
    coachId =
        json['coachId'] != null ? new CoachId.fromJson(json['coachId']) : null;
    isActive = json['isActive'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['coachType'] = this.coachType;
    if (this.coachId != null) {
      data['coachId'] = this.coachId!.toJson();
    }
    data['isActive'] = this.isActive;
    data['_id'] = this.sId;
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
    

     if (json['recommendedOffering'] != null) {
      recommendedOffering = <String>[];
      json['myVideos'].forEach((v) {
        recommendedOffering!.add(v.toString());
      });
    }
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;

     if (this.recommendedOffering != null) {
      data['recommendedOffering'] = this.recommendedOffering;
    }
   
    return data;
  }
}
