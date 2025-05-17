class AuthService {
  // Store users with phone numbers
  static final Map<String, Map<String, String>> _users = {
    'test@example.com': {
      'password': '123456',
      'phone': '1234567890',
    },
  };

  static void signup(String email, String password, String phone) {
    _users[email] = {
      'password': password,
      'phone': phone,
    };
  }

  static bool login(String email, String password, String phone) {
    return _users.containsKey(email) &&
        _users[email]!['password'] == password &&
        _users[email]!['phone'] == phone;
  }
}





