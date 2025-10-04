class PredictionRealRequest {
  final String kepoiName;
  final int koiCount;
  final double koiDiccoMsky;
  final double koiDiccoMskyErr;
  final double koiMaxMultEv;
  final double koiModelSnr;
  final double koiPrad;
  final double koiPradErr1;
  final double koiScore;
  final double koiSmetErr2;

  PredictionRealRequest({
    required this.kepoiName,
    required this.koiCount,
    required this.koiDiccoMsky,
    required this.koiDiccoMskyErr,
    required this.koiMaxMultEv,
    required this.koiModelSnr,
    required this.koiPrad,
    required this.koiPradErr1,
    required this.koiScore,
    required this.koiSmetErr2,
  });


  /// toJson
  Map<String, dynamic> toJson() {
    return {
      "kepoi_name": kepoiName,
      "koi_count": koiCount,
      "koi_dicco_msky": koiDiccoMsky,
      "koi_dicco_msky_err": koiDiccoMskyErr,
      "koi_max_mult_ev": koiMaxMultEv,
      "koi_model_snr": koiModelSnr,
      "koi_prad": koiPrad,
      "koi_prad_err1": koiPradErr1,
      "koi_score": koiScore,
      "koi_smet_err2": koiSmetErr2,
    };
  }

}
  


