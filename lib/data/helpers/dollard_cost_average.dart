abstract class DCATarget {}

enum DCATimeTargetValues {
  SECONDS,
  MINUTES,
  HOURS,
}

enum DCATargetType {
  PRICE,
  PAIR_CREATED,
  TIME,
  ROI,
}

extension DCATargetTypeExtension on DCATargetType {

  static getBuyTargetTypes() {

  }
}



class DCAItem {

  late DCATargetType dcaTargetType;
  late dynamic targetValue;
  late int transactionRation;

  DCAItem({
    required this.dcaTargetType,
    required this.targetValue,
    required this.transactionRation,
  });
}