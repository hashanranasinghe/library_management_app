class Validator {
  static String? nameValidate(String value) {
    if (value.isEmpty) {
      return "Name cannot be Empty";
    } else if (!value.contains(RegExp(r'[A-z]'))) {
      return "Invalid Name.";
    } else if (value.length < 3) {
      return "Invalid Name.";
    }
    return null;
  }

  static String? passwordValidate(String passwordValue) {
    if (passwordValue.isEmpty) {
      return "Password Cannot be Empty";
    } else if (!passwordValue.contains(RegExp(r'[a-zA-Z0-9]'))) {
      return "Invalid Password";
    } else if (passwordValue.length < 6) {
      return "Enter valid Password.(Min. 6 characters)";
    }
    return null;
  }

  static String? confirmPasswordValidate(
      String passwordValue, String confirmValue) {
    if (passwordValue != confirmValue) {
      return 'Password do not match';
    }
    return null;
  }

  static String? emailValidate(String emailValue) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regExp = RegExp(pattern);
    if (emailValue.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!regExp.hasMatch(emailValue)) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }

  static String? nicValidate(String value) {
    const patternOne = r"^[0-9]{9}[vV]$";
    const patternTwo = r"^[0-9]{7}[0][0-9]{4}$";
    final regExpOne = RegExp(patternOne);
    final regExpTwo = RegExp(patternTwo);

    if (value.isEmpty) {
      return 'NIC No. required';
    } else if (value.length < 10) {
      return ('Valid NIC No. Required');
    } else if (!regExpOne.hasMatch(value) && !regExpTwo.hasMatch(value)) {
      return ('Invalid NIC.');
    }
    return null;
  }

  static String? phoneNumber(String value) {
    if (value.isEmpty) {
      return "Phone Number required.";
    } else if (value.length != 10) {
      return "Invalid Phone Number.";
    }
    return null;
  }

  static String? age(String value) {
    if (value.isEmpty) {
      return "Age required";
    } else if (value.length > 3) {
      return "Invalid age";
    }
    return null;
  }
}
