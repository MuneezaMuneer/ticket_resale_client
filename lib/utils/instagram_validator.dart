class InstagramValidator {
  static String? Function(String?)? validator() {
    return (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter instagram username';
      } else if (!value.startsWith('@')) {
        return 'instagram username should start with @';
      } else if (value.length < 2) {
        return 'Enter valid instagram username';
      }
      return null;
    };
  }
}
