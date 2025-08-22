class MyPlanModel {
  String? sId;
  String? planId;
  String? userId;
  int? numOfUsers;
  int? amount;
  bool? active;
  String? status;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  int? iV;
  Plan? plan;

  MyPlanModel(
      {this.sId,
      this.planId,
      this.userId,
      this.numOfUsers,
      this.amount,
      this.active,
      this.status,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.plan});

  MyPlanModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    planId = json['planId'];
    userId = json['userId'];
    numOfUsers = json['numOfUsers'];
    amount = json['amount'];
    active = json['active'];
    status = json['status'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['planId'] = this.planId;
    data['userId'] = this.userId;
    data['numOfUsers'] = this.numOfUsers;
    data['amount'] = this.amount;
    data['active'] = this.active;
    data['status'] = this.status;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    return data;
  }
}

class Plan {
  String? sId;
  String? name;
  Price? price;
  int? iV;
  String? createdAt;
  String? updatedAt;

  Plan(
      {this.sId,
      this.name,
      this.price,
      this.iV,
      this.createdAt,
      this.updatedAt});

  Plan.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    price = json['price'] != null ? new Price.fromJson(json['price']) : null;
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    if (this.price != null) {
      data['price'] = this.price!.toJson();
    }
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

class Price {
  int? amount;
  String? duration;
  List<String>? features;
  String? currency;

  Price({this.amount, this.duration, this.features, this.currency});

  Price.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    duration = json['duration'];
    features = json['features'].cast<String>();
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['duration'] = this.duration;
    data['features'] = this.features;
    data['currency'] = this.currency;
    return data;
  }
}
