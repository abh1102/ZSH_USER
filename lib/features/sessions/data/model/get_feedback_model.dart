class GetFeedBackModel {
  String? sId;
  String? sessionType;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
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

  GetFeedBackModel(
      {this.sId,
      this.sessionType,
      this.title,
      this.description,
      this.startDate,
      this.endDate,
      this.noOfSlots,
      this.coachId,
      this.offeringId,
      this.userId,
      this.channelName,
      this.isApproved,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV});

  GetFeedBackModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sessionType = json['sessionType'];
    title = json['title'];
    description = json['description'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['sessionType'] = this.sessionType;
    data['title'] = this.title;
    data['description'] = this.description;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['noOfSlots'] = this.noOfSlots;
    data['coachId'] = this.coachId;
    data['offeringId'] = this.offeringId;
    data['userId'] = this.userId;
    data['channelName'] = this.channelName;
    data['isApproved'] = this.isApproved;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
