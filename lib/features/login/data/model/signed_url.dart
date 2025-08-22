class SignedUrlModel {
  String? signedUrl;

  SignedUrlModel({this.signedUrl});

  SignedUrlModel.fromJson(Map<String, dynamic> json) {
    signedUrl = json['signedUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['signedUrl'] = this.signedUrl;
    return data;
  }
}
