class PredictionRealResponse {
  final ProbabilitiesModel probabilities;

  PredictionRealResponse({required this.probabilities});

  factory PredictionRealResponse.fromJson(Map<String, dynamic> json) {
    return PredictionRealResponse(
      probabilities: ProbabilitiesModel.fromJson(json['probabilities']),
    );
  }
}

class ProbabilitiesModel {
  final num candidate;
  final num confirmed;
  final num falsePositive;

  ProbabilitiesModel({
    required this.candidate,
    required this.confirmed,
    required this.falsePositive,
  });
  factory ProbabilitiesModel.fromJson(Map<String, dynamic> json) {
    return ProbabilitiesModel(
      candidate: json['CANDIDATE'],
      confirmed: json['CONFIRMED'],
      falsePositive: json['FALSE POSITIVE'],
    );
  }
}
