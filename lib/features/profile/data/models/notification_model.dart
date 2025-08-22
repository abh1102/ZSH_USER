class NotificationModel {
  String? userId;
  String? title;
  String? description;
  bool? isRead;
  String? dateTime;

  String? sId;
  int? iV;

  NotificationModel(
      {this.userId,
      this.title,
      this.description,
      this.isRead,
      this.dateTime,
      this.sId,
      this.iV});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    title = json['title'];
    description = json['description'];
    isRead = json['isRead'];
    dateTime = json['date_time'];
    sId = json['_id'];
    iV = json['__v'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['isRead'] = this.isRead;
    data['date_time'] = this.dateTime;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    return data;
  }
}
