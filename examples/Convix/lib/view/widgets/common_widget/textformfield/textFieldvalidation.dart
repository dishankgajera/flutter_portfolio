class TextFieldValidation {
  TextFieldValidation._();

  static String? validation({
    String ?value,
    String ?message,
    bool isEmailValidator = false,
    bool isPasswordValidator = false,
    bool isGSTINNoValidator = false,
    bool isBankAccountNoValidator = false,
    bool isBankIFSCCodeValidator = false,
  }) {
    if (value!.length == 0) {
      return "$message is required!";
    } else if (isGSTINNoValidator == true) {
      if (value.isEmpty) {
        return "$message is required!";
      } else if (!RegExp(r"^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$").hasMatch(value)) {
        return 'Enter Valid $message';
      }
    } else if (isEmailValidator == true) {
      if (value.isEmpty) {
        return "$message is required!";
      } else if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
        return 'Enter Valid $message';
      }
    } else if (isPasswordValidator == true) {
      if (value.isEmpty) {
        return "$message is required!";
      } else if (!RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$").hasMatch(value)) {
        if (value.length < 6) {
          return 'Password must have at least 6 characters';
        } else if (!value.contains(RegExp(r'[A-Za-z]'))) {
          return 'Password must have at least one alphabet characters';
        } else if (!value.contains(RegExp(r'[0-9]'))) {
          return 'Password must have at least one number characters';
        }
      }
    } else if (isBankIFSCCodeValidator == true) {
      if (value.isEmpty) {
        return "$message is required!";
      } else if (!RegExp(r"^[A-Za-z]{4}[0][A-Z0-9a-z0-9]{6}$").hasMatch(value)) {
        return "Enter valid IFSC Code.";
      } else {
        return null;
      }
    } else if (isBankAccountNoValidator == true) {
      if (value.isEmpty) {
        return "$message is required!";
      } else if (!RegExp(r"^\d{9,18}$").hasMatch(value)) {
        return "Enter valid account number.";
      } else {
        return null;
      }
    }

    return null;
  }
}