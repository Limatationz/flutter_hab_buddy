extension EmptyCheck on List<String> {
  bool get isEmptyCheck {
    if (isEmpty) {
      return true;
    } else {
      if(first.isEmpty) {
        return true;
      }
    }
    return false;
  }
}