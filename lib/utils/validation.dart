

import 'package:email_validator/email_validator.dart';

bool validatorEmail (email) {
  final bool isValid = EmailValidator.validate(email);
  return isValid;
}