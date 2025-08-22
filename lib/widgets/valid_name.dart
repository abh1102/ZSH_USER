bool isValidName(String text) {

  if (text.isEmpty) {
    return true;
  }
  // Regular expression to check if the name contains at least one alphabet character
  RegExp alphabetRegex = RegExp(r'[a-zA-Z]');

  // Regular expression to check if the name does not consist solely of numbers
  

  return alphabetRegex.hasMatch(text) ;
}
