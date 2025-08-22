
class QuestionModel {
  int? total;
  List<Questions>? questions;

  QuestionModel({this.total, this.questions});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Questions {
  String? sId;
  String? questions;
  String? qusType;
  List<String>? options;
  int? maximumAnwserSelect;
  String? category;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Questions(
      {this.sId,
      this.questions,
      this.qusType,
      this.options,
      this.maximumAnwserSelect,
      this.category,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Questions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    questions = json['questions'];
    qusType = json['qusType'];
    options = json['options'].cast<String>();
    maximumAnwserSelect = json['maximumAnwserSelect'];
    category = json['category'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['questions'] = this.questions;
    data['qusType'] = this.qusType;
    data['options'] = this.options;
    data['maximumAnwserSelect'] = this.maximumAnwserSelect;
    data['category'] = this.category;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
