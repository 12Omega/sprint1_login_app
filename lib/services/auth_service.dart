class AuthService {
  static final Map<String, String> _users = {};

  static void signup(String email, String password) {
    _users[email] = password;
  }

  static bool login(String email, String password) {
    return _users.containsKey(email) && _users[email] == password;
  }
}

