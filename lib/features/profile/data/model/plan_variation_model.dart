class PlanVariationModel {
  bool? status;
  String? message;
  List<PlanData>? data;

  PlanVariationModel({this.status, this.message, this.data});

  PlanVariationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PlanData>[];
      json['data'].forEach((v) {
        data!.add(new PlanData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlanData {
  String? sId;
  String? userId;
  String? coachId;
  List<Plan>? plans;
  String? createdAt;

  PlanData({this.sId, this.userId, this.coachId, this.plans, this.createdAt});

  PlanData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    coachId = json['coachId'];
    if (json['plans'] != null) {
      plans = <Plan>[];
      json['plans'].forEach((v) {
        plans!.add(new Plan.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['coachId'] = this.coachId;
    if (this.plans != null) {
      data['plans'] = this.plans!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Plan {
  String? note;
  String? sId;

  Plan({this.note, this.sId});

  Plan.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['note'] = this.note;
    data['_id'] = this.sId;
    return data;
  }
}
