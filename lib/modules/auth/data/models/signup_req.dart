// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:lykluk/utils/extensions/extensions.dart';

class SignUpRequest {
  final String? to;
  final String? email;
  final String? phone;
  final String? password;
  final String? name;
  final String? dob;
  final int? terms;
  final int? code;
  final bool isReseting;
  final List<int> interests;
  final bool isEmailUsed;

  SignUpRequest({
    this.to,
    this.email,
    this.phone,
    this.password,
    this.name,
    this.dob,
    this.terms=1,
    this.code,
    this.isReseting = false,
    this.interests = const [],
    this.isEmailUsed = true,
  });

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> json = {};
  //   if (to != null) json['to'] = to;
  //   if (email != null) json['email'] = email;
  //   if (phone != null) json['phone'] = phone;
  //   if (password != null) json['password'] = password;
  //   if (name != null) json['name'] = name;
  //   if (dob != null) json['dob'] = dob;
  //   if (terms != null) json['terms'] = terms;
  //   if (code != code) json['code'] = code;
  //   json['isReseting'] = isReseting;

  //   return json;
  // }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'to': to,
      'email': email,
      'phone': phone,
      'password': password,
      'name': name,
      'dob': dob,
      'terms': terms,
      // 'code': code,
      // 'isReseting': isReseting,
      'interestsId': interests,
    }.removeNullValues;
  }

  factory SignUpRequest.fromJson(Map<String, dynamic> map) {
    return SignUpRequest(
      to: map['to'] != null ? map['to'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      dob: map['dob'] != null ? map['dob'] as String : null,
      terms: map['terms'] != null ? map['terms'] as int : null,
      code: map['code'] != null ? map['code'] as int : null,
      isReseting: map['isReseting'] as bool,
      interests: List<int>.from(map['interestsId']),
    );
  }

  SignUpRequest copyWith({
    String? to,
    String? email,
    String? phone,
    String? password,
    String? name,
    String? dob,
    int? terms,
    int? code,
    bool? isReseting,
    List<int>? interests,
    bool? isEmailUsed,
  }) {
    return SignUpRequest(
      to: to ?? this.to,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      name: name ?? this.name,
      dob: dob ?? this.dob,
      terms: terms ?? this.terms,
      code: code ?? this.code,
      isReseting: isReseting ?? this.isReseting,
      interests: interests ?? this.interests,
      isEmailUsed: isEmailUsed ?? this.isEmailUsed,
    );
  }
}
