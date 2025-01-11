enum CronMinuteType {
  EVERY,
  EVERY_START_AT,
  SPECIFIC,
  BETWEEN;

  bool get isSpecific => this == SPECIFIC;
}
