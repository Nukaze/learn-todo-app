import 'tools.dart';
import 'package:bcrypt/bcrypt.dart';

Map<String, String> getAuthPasswordGenerate(String password) {
  final salt = BCrypt.gensalt();
  final hashedPassword = BCrypt.hashpw(password, salt);
  return {"password": hashedPassword, "salt": salt};
}

bool getAuthPasswordCheck(String checkPassword, String validPassword, String salt) {
  final hashedCheckPassword = BCrypt.hashpw(checkPassword, salt);
  return hashedCheckPassword == validPassword;
}
