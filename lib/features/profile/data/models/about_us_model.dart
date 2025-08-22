class AboutUsModel {
  String? sId;
  String? title;
  String? content;
  int? iV;
  String? createdAt;
  String? updatedAt;

  AboutUsModel(
      {this.sId,
      this.title,
      this.content,
      this.iV,
      this.createdAt,
      this.updatedAt});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    content = json['content'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
