// ignore_for_file: public_member_api_docs, sort_constructors_first
class LoginRequest {
  final String? email;
  final String? phone;
  final String? password;
  final String? terms;
  final bool isEmail;

  LoginRequest({this.email, this.phone, this.password, this.terms, this.isEmail = true});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};

    if (email != null) json['email'] = email;
    if (phone != null) json['phone'] = phone;
    if (password != null) json['password'] = password;
    if (terms != null) json['terms'] = terms;

    return json;
  }

  Map<String, dynamic> toRequest() {
    final Map<String, dynamic> json = {};

    if (email != null) json['username'] = isEmail?  email : phone;
    if (password != null) json['password'] = password;
    if (terms != null) json['terms'] = terms;

    return json;
  }

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      terms: json['terms'],
    );
  }

  LoginRequest copyWith({
    String? email,
    String? phone,
    String? password,
    String? terms,
    bool? isEmail,
  }) {
    return LoginRequest(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      terms: terms ?? this.terms,
      isEmail: isEmail ?? this.isEmail,
    );
  }
}
