class OfferingsModel {
  String? sId;
  String? title;
  String? subTitle;
  String? icon;
  String? createdAt;
  String? updatedAt;
  int? iV;

  OfferingsModel(
      {this.sId,
      this.title,
      this.subTitle,
      this.icon,
      this.createdAt,
      this.updatedAt,
      this.iV});

  OfferingsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    subTitle = json['subTitle'];
    icon = json['icon'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = sId;
    data['title'] = title;
    data['subTitle'] = subTitle;
    data['icon'] = icon;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
