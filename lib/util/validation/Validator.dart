import 'ValidationMessage.dart';

class Validator {
  static ValidationMessage validateUsername(String value) {
    const minLen = 5;
    const maxLen = 20;
    if (value == null || value.isEmpty) {
      return new ValidationMessage(false, 'Username is required');
    }
    if (value.length < minLen) {
      return new ValidationMessage(
          false, 'Username is too short (at least ' + minLen.toString() + ')');
    }
    if (value.length > maxLen) {
      return new ValidationMessage(
          false, 'Username is too long (at most ' + maxLen.toString() + ')');
    }
    final RegExp exp = new RegExp(r'^(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+$');
    if (!exp.hasMatch(value)) {
      return new ValidationMessage(
          false, 'Username can only contain letters and numbers.');
    }
    return new ValidationMessage(true, '');
  }

  static ValidationMessage validateEmail(String value) {
    if (value == null || value.isEmpty) {
      return new ValidationMessage(true, '');
    }
    final RegExp exp = new RegExp(
        r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$");
    if (!exp.hasMatch(value)) {
      return new ValidationMessage(false, 'Email is not valid');
    }
    return new ValidationMessage(true, '');
  }

  static ValidationMessage validatePassword(String value, String compare) {
    const minLen = 6;
    if (value == null || value.isEmpty) {
      return new ValidationMessage(false, 'Password is required');
    }
    if (value.length < minLen) {
      return new ValidationMessage(
          false, 'Password is too short (at least ' + minLen.toString() + ')');
    }
    final RegExp exp =
        new RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d!$%@#£€*?&].*$');
    if (!exp.hasMatch(value)) {
      return new ValidationMessage(
          false, 'Password must contain both letters and numbers');
    }
    if (value != compare)
      return new ValidationMessage(false, 'Password does not match');
    return new ValidationMessage(true, '');
  }
}
