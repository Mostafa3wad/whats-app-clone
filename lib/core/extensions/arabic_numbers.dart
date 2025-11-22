extension IntToArabicNumbers on int {
  String get toArabicNumbers {
    return _toArabicNumbers(toString());
  }
}

extension StringToArabicNumbers on String {
  String get toArabicNumbers {
    return _toArabicNumbers(this);
  }
}

String _toArabicNumbers(String value) {
  return value
      .replaceAll('0', '٠')
      .replaceAll('1', '١')
      .replaceAll('2', '٢')
      .replaceAll('3', '٣')
      .replaceAll('4', '٤')
      .replaceAll('5', '٥')
      .replaceAll('6', '٦')
      .replaceAll('7', '٧')
      .replaceAll('8', '٨')
      .replaceAll('9', '٩');
}
