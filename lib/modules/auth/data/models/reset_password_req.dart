

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResetPasswordRequest {
  final String? to;
  final String? password;
  final String? code;

  const ResetPasswordRequest({this.to, this.password, this.code});

   ResetPasswordRequest copyWith({String? to, String? password, String? code}) {
    return ResetPasswordRequest(
      to: to ?? this.to,
      password: password ?? this.password,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'to': to, 'password': password, 'code': code};
  }
}
