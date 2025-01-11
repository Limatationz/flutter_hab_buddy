enum CronHourType {
  EVERY,
  EVERY_START_AT,
  SPECIFIC,
  BETWEEN;

  bool get isSpecific =>
      this == SPECIFIC;
}
