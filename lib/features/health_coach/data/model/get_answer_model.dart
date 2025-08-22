class GetAnswerModel {
  String? sId;
  String? userId;
  List<Result>? result;

  GetAnswerModel({this.sId, this.userId, this.result});

  GetAnswerModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? questionId;
  String? questionName;
  String? category;
  List<String>? answer;
  int? score;
  String? sId;

  Result(
      {this.questionId, this.questionName, this.answer, this.score, this.sId});

  Result.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    category = json['category'];
    questionName = json['questionName'];
    answer = json['answer'].cast<String>();
    score = json['score'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['questionName'] = this.questionName;
    data['answer'] = this.answer;
    data['category'] = this.category;
    data['score'] = this.score;
    data['_id'] = this.sId;
    return data;
  }
}
