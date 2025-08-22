class Answer {
  final String questionId;
  final String questionName;
  final List<String> answer;
  final int score;

  Answer({
    required this.questionId,
    required this.questionName,
    required this.answer,
    required this.score,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'questionName': questionName,
      'answer': answer,
      'score': score,
    };
  }
}

class SpecialAnswer {
  final String questionId;
  final String questionName;
  final String category;
  final List<String> answer;

  final int? score;

  SpecialAnswer({
    required this.questionId,
    required this.questionName,
    required this.category,
    required this.answer,
    this.score,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'category': category,
      'questionName': questionName,
      'answer': answer,
      'score': score,
    };
  }
}
