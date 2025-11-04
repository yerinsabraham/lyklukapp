import 'package:lykluk/utils/theme/app_colors.dart';

enum NotificationType {
  privateChat(name: 'privateChat'),
  communityChat(name: 'communityChat'),
  challengeCreation(name: 'challenge_creation'),
  challengeJoin(name: 'challenge_join'),
  challengeUpdate(name: 'challenge_update'),
  challengeDelete(name: 'challenge_delete'),
  challengeComplete(name: 'challenge_complete'),
  challengeRequest(name: 'challenge_request'),
  taskCreation(name: 'task_creation'),
  taskUpdate(name: 'task_update'),
  taskDelete(name: 'task_delete'),
  taskComplete(name: 'task_complete'),
  taskComment(name: 'task_comment');

  final String name;
  const NotificationType({required this.name});
}

enum TicketStatusEnum {
  closed,
  unassigned,
  opened,
  unknown, // fallback
}

enum VerifyType { signup, login, forgotPin }

enum RouteType {
  transfer,
  airtime,
  p2p,
  ussd,
  internet,
  electricity,
  cable,
  betting,
}

enum SupportType {
  transfer,
  airtime,
  p2p,
  ussd,
  internet,
  electricity,
  cable,
  betting,
}

enum TransactionTypeEnum {
  p2p,
  deposit,
  transfer,
  posTransfer,
  ussdWithdrawal,
  cardWithdrawal,
  other,
}

extension TransactionTypeExtension on TransactionTypeEnum {
  static TransactionTypeEnum? fromString(String type) {
    switch (type.toLowerCase()) {
      case 'p2p':
        return TransactionTypeEnum.p2p;
      case 'deposit':
        return TransactionTypeEnum.deposit;
      case 'transfer':
        return TransactionTypeEnum.transfer;

      case 'pos-transfer':
        return TransactionTypeEnum.posTransfer;
      case 'ussd-withdrawal':
        return TransactionTypeEnum.ussdWithdrawal;
      case 'card-withdrawal':
        return TransactionTypeEnum.cardWithdrawal;
      default:
        return TransactionTypeEnum.other;
    }
  }
}

// final customerTypeProvider = StateProvider<CustomerTypeEnum?>((ref) => null);

// enum CustomerType { agent, merchant }

// void updateCustomerTypeProvider(WidgetRef ref) {
//   final type = HiveStorage.customerType;
//   final routeData = CustomerTypeEnum(customerType: type);
//   ref.read(customerTypeProvider.notifier).state = routeData;
// }

// extension CustomerTypeExtension on CustomerType {
//   String get value {
//     switch (this) {
//       case CustomerType.agent:
//         return 'AGENCY_BANKING';
//       case CustomerType.merchant:
//         return 'MERCHANT';
//     }
//   }

//   static CustomerType? fromValue(String value) {
//     switch (value) {
//       case 'AGENCY_BANKING':
//         return CustomerType.agent;
//       case 'MERCHANT':
//         return CustomerType.merchant;
//       default:
//         return null;
//     }
//   }
// }

// class CustomerTypeEnum {
//   final VerifyType? verifyType;
//   final CustomerType? customerType;
//   final OtpRequestProvider? otpRequestProvider;
//   final UserDetailsResponse? userDetailsResponse;
//   final SignUpRequestProvider? signUpRequestProvider;
//   final LoginRequestProvider? loginRequestProvider;

//   const CustomerTypeEnum({
//     this.verifyType,
//     required this.customerType,
//     this.otpRequestProvider,
//     this.userDetailsResponse,
//     this.signUpRequestProvider,
//     this.loginRequestProvider,
//   });

//   // Factory constructor for creating an instance from JSON
//   factory CustomerTypeEnum.fromJson(Map<String, dynamic> json) {
//     return CustomerTypeEnum(
//       verifyType: json['verifyType'] != null
//           ? VerifyType.values.firstWhere(
//               (e) => e.toString().split('.').last == json['verifyType'])
//           : null,
//       customerType: json['customerType'] != null
//           ? CustomerType.values.firstWhere(
//               (e) => e.toString().split('.').last == json['customerType'])
//           : null,
//       otpRequestProvider: json['otpRequestProvider'] != null
//           ? OtpRequestProvider.fromJson(json['otpRequestProvider'])
//           : null,
//       userDetailsResponse: json['userDetailsResponse'] != null
//           ? UserDetailsResponse.fromJson(json['userDetailsResponse'])
//           : null,
//       signUpRequestProvider: json['signUpRequestProvider'] != null
//           ? SignUpRequestProvider.fromJson(json['signUpRequestProvider'])
//           : null,
//       loginRequestProvider: json['loginRequestProvider'] != null
//           ? LoginRequestProvider.fromJson(json['loginRequestProvider'])
//           : null,
//     );
//   }

//   // Method to convert an instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'verifyType': verifyType?.toString().split('.').last,
//       'customerType': customerType?.toString().split('.').last,
//       'otpRequestProvider': otpRequestProvider?.toJson(),
//       'userDetailsResponse': userDetailsResponse?.toJson(),
//       'signUpRequestProvider': signUpRequestProvider?.toJson(),
//       'loginRequestProvider': loginRequestProvider?.toJson(),
//     };
//   }
// }

extension TicketStatusExtension on TicketStatusEnum {
  String get label {
    switch (this) {
      case TicketStatusEnum.closed:
        return 'Closed';
      case TicketStatusEnum.unassigned:
        return 'Unassigned';
      case TicketStatusEnum.opened:
        return 'Opened';
      case TicketStatusEnum.unknown:
        return 'Unknown';
    }
  }

  int get color {
    switch (this) {
      case TicketStatusEnum.closed:
        return AppColors.primaryColor;
      case TicketStatusEnum.unassigned:
        return AppColors.hotRed;
      case TicketStatusEnum.opened:
        return AppColors.purpleColor;
      case TicketStatusEnum.unknown:
        return AppColors.transparent;
    }
  }

  static TicketStatusEnum fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'CLOSED':
        return TicketStatusEnum.closed;
      case 'UNASSIGNED':
        return TicketStatusEnum.unassigned;
      case 'OPENED':
        return TicketStatusEnum.opened;
      default:
        return TicketStatusEnum.unknown;
    }
  }
}

// class TransferTypeEnum {
//   final String? pin;
//   final String? remark;
//   final double? amount;
//   final RouteType? routeType;
//   final NameEnquiryData? nameEnquiryData;

//   const TransferTypeEnum({this.pin, this.remark, this.amount, this.nameEnquiryData, required this.routeType});

//   // Factory constructor for creating an instance from JSON
//   factory TransferTypeEnum.fromJson(Map<String, dynamic> json) {
//     return TransferTypeEnum(
//       pin: json['pin'] as String,
//       remark: json['remark'] as String,
//       amount: json['amount'] as double?,
//       routeType: json['routeType'] != null ? RouteType.values.firstWhere((e) => e.toString().split('.').last == json['routeType']) : null,
//       nameEnquiryData: json['nameEnquiryData'] != null ? NameEnquiryData.fromJson(json['nameEnquiryData']) : null,
//     );
//   }

//   // Method to convert an instance to JSON
//   Map<String, dynamic> toJson() {
//     return {'pin': pin, 'remark': remark, 'amount': amount, 'routeType': routeType?.toString().split('.').last, 'nameEnquiryData': nameEnquiryData?.toJson()};
//   }
// }
