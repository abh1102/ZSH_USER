bool checkPasswordStrength(String password) {
  // Regular expressions to check for uppercase, lowercase, and numeric characters
  RegExp upperCase = RegExp(r'[A-Z]');
  RegExp lowerCase = RegExp(r'[a-z]');
  RegExp numeric = RegExp(r'[0-9]');

  // Check if password contains at least one uppercase, one lowercase, and one numeric character
  bool hasUpperCase = upperCase.hasMatch(password);
  bool hasLowerCase = lowerCase.hasMatch(password);
  bool hasNumeric = numeric.hasMatch(password);

  // Check if password meets minimum length requirement
  bool hasMinLength = password.length >= 8;

  // Return true if all criteria are met, otherwise return false
  return hasUpperCase && hasLowerCase && hasNumeric && hasMinLength;
}
