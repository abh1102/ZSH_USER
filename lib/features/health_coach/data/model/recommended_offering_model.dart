class RecommendedOfferingModel {
  String? sId;
  String? userId;
  String? coachId;
  String? offeringId;
  String? offerTitle;
  String? offerSubtitle;
  String? offerIcon;

  RecommendedOfferingModel(
      {this.sId,
      this.userId,
      this.coachId,
      this.offeringId,
      this.offerTitle,
      this.offerSubtitle,
      this.offerIcon});

  RecommendedOfferingModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    coachId = json['coachId'];
    offeringId = json['offeringId'];
    offerTitle = json['offerTitle'];
    offerSubtitle = json['offerSubtitle'];
    offerIcon = json['offerIcon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['coachId'] = this.coachId;
    data['offeringId'] = this.offeringId;
    data['offerTitle'] = this.offerTitle;
    data['offerSubtitle'] = this.offerSubtitle;
    data['offerIcon'] = this.offerIcon;
    return data;
  }
}
