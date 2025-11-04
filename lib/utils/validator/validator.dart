import 'is_empty.dart';

class ValidationException implements Exception {
  String cause;
  ValidationException(this.cause);
}

class Validator {
  Validator();

  // Form validation for registration
  static void validateRegOne({required data}) {
    if (IsEmpty.isEmpty(data['firstName'])) {
      throw Exception('First name cannot be empty');
    }
    if (data['firstName'].length < 2) {
      throw Exception('First name cannot be less than 2');
    }
    if (!IsEmpty.isEmpty(data['email'])) {
      if (!RegExp(
        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      ).hasMatch(data['email'])) {
        throw Exception('Please use a valid email');
      }
    } else {
      throw Exception('Email field cannot be empty');
    }
  }

  static void validateRegistration({required data}) {
    if (IsEmpty.isEmpty(data['firstName'])) {
      throw Exception('First name cannot be empty');
    }
    if (data['firstName'].length < 2) {
      throw Exception('First name cannot be less than 2');
    }
    if (IsEmpty.isEmpty(data['lastName'])) {
      throw Exception('Last name cannot be empty');
    }
    if (data['lastName'].length < 3) {
      throw Exception('Last name cannot be less than 3');
    }
    if (!IsEmpty.isEmpty(data['email'])) {
      if (!RegExp(
        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      ).hasMatch(data['email'])) {
        throw Exception('Please use a valid email');
      }
    } else {
      throw Exception('Email field cannot be empty');
    }
    if (IsEmpty.isEmpty(data['dateOfBirth'])) {
      throw Exception('Date Of Birth cannot be empty');
    }
    if (IsEmpty.isEmpty(data['password'])) {
      throw Exception('Password cannot be empty');
    }
  }

  // Form validation for registration
  static void validateChallengeOne({required data}) {
    if (IsEmpty.isEmpty(data['title'])) {
      throw 'Please name your challenge';
    }
    if (IsEmpty.isEmpty(data['description'])) {
      throw 'Please add a description';
    }
    if (IsEmpty.isEmpty(data['type'])) {
      throw 'Please select a challenge type';
    }
    if (data['tags'] == null || data['tags'].length == 0) {
      throw 'Please add a tag';
    }

    if (IsEmpty.isEmpty(data['image'])) {
      throw 'Please add an image';
    }
  }

  // Form validation for registration
  static void validateChallengeTwo({required data}) {
    if (IsEmpty.isEmpty(data['startDate'])) {
      throw 'Please select a start date';
    }

    if (IsEmpty.isEmpty(data['endDate'])) {
      throw 'Please select an end date';
    }

    if (IsEmpty.isEmpty(data['difficulty'])) {
      throw 'Please select a difficulty level';
    }
  }

  static void validateLogin({required data}) {
    if (!IsEmpty.isEmpty(data['email'])) {
      if (!RegExp(
        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      ).hasMatch(data['email'])) {
        throw Exception('Please use a valid email');
      }
    } else {
      throw Exception('Email field cannot be empty');
    }
    if (IsEmpty.isEmpty(data['password'])) {
      throw Exception('Password field cannot be empty');
    }
  }

  static void validatePasswordReset({required data}) {
    if (IsEmpty.isEmpty(data['email'])) {
      throw Exception('Email field cannot be empty');
    }
    if (IsEmpty.isEmpty(data['otp'])) {
      throw Exception('Token field cannot be empty');
    }
    if (IsEmpty.isEmpty(data['password'])) {
      throw Exception('Password field cannot be empty');
    }
    if (IsEmpty.isEmpty(data['confirmPassword'])) {
      throw Exception('Confirm Password field cannot be empty');
    }
  }

  static void validateEmail({required data}) {
    if (!IsEmpty.isEmpty(data['email'])) {
      if (!RegExp(
        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      ).hasMatch(data['email'])) {
        throw Exception('Please use a valid email');
      }
    } else {
      throw Exception('Email field cannot be empty');
    }
  }

  static void isValidUSPhoneNumber(String? data) {
    if (!IsEmpty.isEmpty(data)) {
      if (!RegExp(r'^\+1\s\([0-9]{3}\)\s[0-9]{3}-[0-9]{4}$').hasMatch(data!)) {
        throw Exception('Please use a valid phone number');
      }
    } else {
      throw Exception('Phone number field cannot be empty');
    }
  }

  static void validateEmailAndPassword({required data}) {
    if (!IsEmpty.isEmpty(data['email'])) {
      if (!RegExp(
        r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      ).hasMatch(data['email'])) {
        throw Exception('Please use a valid email');
      }
    } else {
      throw Exception('Email field cannot be empty');
    }

    if (IsEmpty.isEmpty(data['password'])) {
      throw Exception('Password field cannot be empty');
    }
    if (IsEmpty.isEmpty(data['confirmPassword'])) {
      throw Exception('Confirm Password field cannot be empty');
    }

    if (data['confirmPassword'] != data['password']) {
      throw Exception('Passwords do not match.');
    }
  }

  static void validatePost({required data}) {
    if (IsEmpty.isEmpty(data['firstName'])) {
      throw Exception('Name field cannot be empty');
    }
    if (IsEmpty.isEmpty(data['localImagePath'])) {
      throw Exception('please add an image');
    }
    if (IsEmpty.isEmpty(data['caption'])) {
      throw Exception('Please add a caption');
    }
  }
}
