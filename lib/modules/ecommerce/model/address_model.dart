

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressModel {
  final String id;
  final String address;
  final String city;
  final String state;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final bool isDefault;

  const AddressModel({
    required this.id, 
    required this.address,
    required this.city,
    required this.state,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.isDefault,
  });

  AddressModel copyWith({
    String? address,
    String? city,
    String? state,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    bool? isDefault,
    String? id,
  }) {
    return AddressModel(
      id: id?? this.id,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'address': address,
      'city': city,
      'state': state,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'isDefault': isDefault,
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as String,
      address: map['address'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      isDefault: map['isDefault'] as bool,
    );
  }

  
}
