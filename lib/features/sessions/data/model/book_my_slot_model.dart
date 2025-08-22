class BookMySlotGroupModel {
  String? sId;
  String? sessionType;
  String? title;
  String? description;
  String? startDate;
  String? endDate;
  int? noOfSlots;
  String? coachId;
  List<String>? userId;
  String? channelName;
  String? token;
  bool? isApproved;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BookMySlotGroupModel(
      {this.sId,
      this.sessionType,
      this.title,
      this.description,
      this.startDate,
      this.endDate,
      this.noOfSlots,
      this.coachId,
      this.userId,
      this.channelName,
      this.token,
      this.isApproved,
      this.createdAt,
      this.updatedAt,
      this.iV});

  BookMySlotGroupModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    sessionType = json['sessionType'];
    title = json['title'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    noOfSlots = json['noOfSlots'];
    coachId = json['coachId'];
    userId = json['userId'].cast<String>();
    channelName = json['channelName'];
    token = json['token'];
    isApproved = json['isApproved'];
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
    data['userId'] = this.userId;
    data['channelName'] = this.channelName;
    data['token'] = this.token;
    data['isApproved'] = this.isApproved;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
