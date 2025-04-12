int? parseDuration(String? durationString) {
  if (durationString == null) {
    return null;
  } else {
    if (durationString.contains("ms")) {
      return int.tryParse(durationString.split("ms").first)! ~/ 1000;
    } else if (durationString.contains("s")) {
      return int.tryParse(durationString.split("s").first);
    } else {
      return int.tryParse(durationString);
    }
  }
}

String? parseImage(String? imageString) {
  if (imageString == null) {
    return null;
  } else {
    if (imageString.contains("base64")) {
      final split = imageString.split("base64,");
      return split[1];
    } else {
      return imageString;
    }
  }
}