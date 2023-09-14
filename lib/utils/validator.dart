// Utils folder
class Validators {
  static String? validateUserName(String value) {
    if (value.isEmpty) {
      return 'username cannot be empty';
    }
    if (value.length < 3) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 3) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
  static String? validatePhoneNumber(String value) {
    if (value.isEmpty) {
      return 'phone cannot be empty';
    }
    if (value.length < 10) {
      return 'phone must be at least 10 characters';
    }
    return null;
  }
}
