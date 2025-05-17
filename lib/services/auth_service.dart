class AuthService {
  // Predefined users stored in memory
  static final Map<String, String> _users = {
    'test@example.com': '123456',  // <-- Preloaded user
    'admin@demo.com': 'adminpass'  // <-- Another optional user
  };

  // Sign up method (adds a new user to memory)
  static void signup(String email, String password) {
    _users[email] = password;
  }

  // Login method (checks if the email and password match)
  static bool login(String email, String password) {
    return _users.containsKey(email) && _users[email] == password;
  }
}



