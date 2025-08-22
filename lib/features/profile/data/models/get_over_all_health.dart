class GetOverAllHealthModel {
  HealthScore? healthScore;
  CurrentScore? currentScore;
  List<DailyScore>? dailyScore;

  GetOverAllHealthModel({this.healthScore, this.currentScore, this.dailyScore});

  GetOverAllHealthModel.fromJson(Map<String, dynamic> json) {
    healthScore = json['healthScore'] != null
        ? new HealthScore.fromJson(json['healthScore'])
        : null;
    currentScore = json['currentScore'] != null
        ? new CurrentScore.fromJson(json['currentScore'])
        : null;
    if (json['dailyScore'] != null) {
      dailyScore = <DailyScore>[];
      json['dailyScore'].forEach((v) {
        dailyScore!.add(new DailyScore.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.healthScore != null) {
      data['healthScore'] = this.healthScore!.toJson();
    }
    if (this.currentScore != null) {
      data['currentScore'] = this.currentScore!.toJson();
    }
    if (this.dailyScore != null) {
      data['dailyScore'] = this.dailyScore!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HealthScore {
  dynamic physicalHealth;
  dynamic mentalHealth;
  dynamic generalHealth;
  dynamic energy;

  dynamic nutrition;

  dynamic avgScore;
  String? createdAt;
  int? iV;

  HealthScore(
      {this.physicalHealth,
      this.mentalHealth,
      this.generalHealth,
      this.energy,
      this.nutrition,
      this.avgScore,
      this.createdAt,
      this.iV});

  HealthScore.fromJson(Map<String, dynamic> json) {
    physicalHealth = json['physicalHealth'];
    mentalHealth = json['mentalHealth'];
    generalHealth = json['generalHealth'];
    energy = json['energy'];

    nutrition = json['nutrition'];

    avgScore = json['avgScore'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['physicalHealth'] = this.physicalHealth;
    data['mentalHealth'] = this.mentalHealth;
    data['generalHealth'] = this.generalHealth;
    data['energy'] = this.energy;

    data['nutrition'] = this.nutrition;

    data['avgScore'] = this.avgScore;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class CurrentScore {
  dynamic finalHealthScore;
  dynamic finalSelfScore;
  dynamic finalScore;
  String? createdAt;

  CurrentScore(
      {this.finalHealthScore,
      this.finalSelfScore,
      this.finalScore,
      this.createdAt});

  CurrentScore.fromJson(Map<String, dynamic> json) {
    finalHealthScore = json['finalHealthScore'];
    finalSelfScore = json['finalSelfScore'];
    finalScore = json['finalScore'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['finalHealthScore'] = this.finalHealthScore;
    data['finalSelfScore'] = this.finalSelfScore;
    data['finalScore'] = this.finalScore;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class DailyScore {
  dynamic finalHealthScore;
  dynamic finalSelfScore;
  dynamic finalScore;
  String? createdAt;
  int? iV;

  DailyScore(
      {this.finalHealthScore,
      this.finalSelfScore,
      this.finalScore,
      this.createdAt,
      this.iV});

  DailyScore.fromJson(Map<String, dynamic> json) {
    finalHealthScore = json['finalHealthScore'];
    finalSelfScore = json['finalSelfScore'];
    finalScore = json['finalScore'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['finalHealthScore'] = this.finalHealthScore;
    data['finalSelfScore'] = this.finalSelfScore;
    data['finalScore'] = this.finalScore;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
