class UserInterestModel {
  final int id;
 final  String interest;

  UserInterestModel({required this.id, required this.interest});

  factory UserInterestModel.fromJson(Map<String, dynamic> json) {
    return UserInterestModel(
      id: json['id'],
      interest: json['interest'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'interest': interest,
    };
  }

}
