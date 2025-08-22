String extractFirstName(String username) {
  // Split the concatenated string by underscore
  List<String> parts = username.split('_');
  // The first part contains the first name
  String firstName = parts[0];
  return firstName;
}

String generateUsername(String fullName, String cuid) {
  String firstName = fullName.split(' ')[0];

  return '${firstName.toLowerCase()}_$cuid';
}
