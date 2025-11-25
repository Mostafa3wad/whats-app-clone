class ValidationHelper {
  String? validateRequired({String? value}) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? validateEmail({String? value}) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  String? validatePhone({String? value}) {
    final RegExp phoneRegex = RegExp(r'^\d{10}$');
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    } else if (!phoneRegex.hasMatch(value)) {
      return 'Invalid phone number';
    }
    return null;
  }

  String? validateAlpha({String? value}) {
    final RegExp alphaRegex = RegExp(r'^[a-zA-Z]+$');
    if (value == null || value.isEmpty) {
      return 'This field is required';
    } else if (!alphaRegex.hasMatch(value)) {
      return 'Only alphabets are allowed';
    }
    return null;
  }

  String? validateNoLeadingOrTrailingSpaces({String? value}) {
    if (value != null && (value.trim() != value)) {
      return 'No leading or trailing spaces are allowed';
    }
    return null;
  }

  static String? isValidEgyptianNumber(String v) {
    if (!RegExp(r'^[0-9]+$').hasMatch(v)) {
      return 'The number must contain only numbers.';
    }

    if (v.length < 10) {
      return 'The number must be at least 10 digits.';
    }

    final List<String> validPrefixes = <String>[
      '010',
      '011',
      '012',
      '015',
      '10',
      '11',
      '12',
      '15',
    ];

    final bool startsWithValid = validPrefixes.any(
      (String p) => v.startsWith(p),
    );

    if (!startsWithValid) {
      return 'The number does not start with a valid code.';
    }

    return null; // Valid
  }
}
