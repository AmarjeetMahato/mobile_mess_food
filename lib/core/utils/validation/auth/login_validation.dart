class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }

    // Remove spaces
    final phone = value.trim();

    // Only digits check
    final regex = RegExp(r'^(\+91)?[6-9]\d{9}$');

    if (!regex.hasMatch(phone)) {
      return "Enter valid Indian phone number";
    }

    // Length check (India standard)
    if (phone.length != 10) {
      return "Phone must be 10 digits";
    }

    return null; // ✅ valid
  }

  static String? ValidationInput(String? value) {
    if (value == null || value.isEmpty) {
      return "OTP is required";
    }

    final otp = value.trim();

    // Only digits
    final regex = RegExp(r'^[0-9]+$');
    if (!regex.hasMatch(otp)) {
      return "OTP must contain only digits";
    }

    // Length check (6-digit OTP)
    if (otp.length != 6) {
      return "OTP must be 6 digits";
    }

    return null; // ✅ valid
  }
}
