class CustomizedOfferingModel {
  String? sId;
  String? offeringsName;

  CustomizedOfferingModel({this.sId, this.offeringsName});

  CustomizedOfferingModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    offeringsName = json['offeringsName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['offeringsName'] = this.offeringsName;
    return data;
  }
}
