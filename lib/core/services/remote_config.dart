import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lykluk/core/services/logger_service.dart';

final remoteConfigServiceProvider = Provider(
  (ref) =>
      RemoteConfigService(remoteConfig: FirebaseRemoteConfig.instance)
        ..initialize(),
);

class RemoteConfigService {
  final FirebaseRemoteConfig remoteConfig;
  RemoteConfigService({required this.remoteConfig});

  final defaults = const ConfigDataModel().toMap();

  Future<void> initialize() async {
    try {
      await remoteConfig.ensureInitialized();
      await remoteConfig.setDefaults(defaults);
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await remoteConfig.fetchAndActivate();
      log.d('Remote Config initialized');
    } catch (e, stacktrace) {
      log.d("Remote Config initialization failed: $e, Stacktrace: $stacktrace");
    }
  }

  void activate() async {
    final isChanged = await remoteConfig.fetchAndActivate();
    log.d(isChanged ? 'Remote Config activated' : 'Remote Config not changed');
  }

  ConfigDataModel getConfig() {
    try {
      final Map<String, dynamic> configMap = {};
      for (final key in defaults.keys) {
        configMap[key] = remoteConfig.getString(key);
      }

      final configData = ConfigDataModel.fromMap(configMap);
      log.d("✅ Remote Config fetched: $configData");
      return configData;
    } catch (e, s) {
      LoggerService.logError(
        error: e,
        stackTrace: s,
        reason: '❌ Error in fetching config data',
      );
      return const ConfigDataModel();
    }
  }

  Stream<RemoteConfigUpdate> onChanged() {
    log.d('Remote config listener initialized');
    return remoteConfig.onConfigUpdated;
  }
}

class ConfigDataModel extends Equatable {
  final String productionUrl;
  final String sentryDns;
  final Map<String, dynamic> appUpdate;
  final String privacyPolicy;
  final String termsAndConditions;
  final int sessionTimeout;
  final int otpCountdown;
  final String poweredBy;
  final String broadcastMsg;
  final String supportEmail;
  final List<String> supportNumbers;
  final String supportWhatsApp;
  final String whatsappPrefix;
  final bool isProduction;

  // New config keys
  final String token;
  final String updatePin;
  final String pinOtpRequest;
  final String pinOtpVerify;
  final String pinResetUpdate;
  final String signup;
  final String completeSignup;
  final String updateUserProfile;
  final String getUserProfile;
  final String updateBusinessProfile;
  final String addBusiness;
  final String bankList;
  final String nameEnquiry;
  final String allTransaction;
  final String transfer;
  final String setTransPin;
  final String resetTransPin;
  final String assignTerminal;
  final String unAssignTerminal;
  final String cashpointSummary;
  final String setCashpointPin;
  final String resetCashpointPin;
  final String balance;
  final String credit;
  final String debit;
  final String createWallet;
  final String getCategoryTypes;
  final String getCategoryIssues;
  final String getBusinessTicket;
  final String getBusinessTickets;
  final String createTicket;
  final String updateConversation;
  final String updateTicketStatus;

  const ConfigDataModel({
    this.productionUrl = '',
    this.sentryDns = '',
    this.appUpdate = const {},
    this.privacyPolicy = '',
    this.termsAndConditions = '',
    this.sessionTimeout = 5,
    this.otpCountdown = 4,
    this.poweredBy = '',
    this.broadcastMsg = '',
    this.supportEmail = '',
    this.supportNumbers = const [],
    this.supportWhatsApp = '',
    this.whatsappPrefix = '',
    this.isProduction = true,
    this.token = '',
    this.updatePin = '',
    this.pinOtpRequest = '',
    this.pinOtpVerify = '',
    this.pinResetUpdate = '',
    this.signup = '',
    this.completeSignup = '',
    this.updateUserProfile = '',
    this.getUserProfile = '',
    this.updateBusinessProfile = '',
    this.addBusiness = '',
    this.bankList = '',
    this.nameEnquiry = '',
    this.allTransaction = '',
    this.transfer = '',
    this.setTransPin = '',
    this.resetTransPin = '',
    this.assignTerminal = '',
    this.unAssignTerminal = '',
    this.cashpointSummary = '',
    this.setCashpointPin = '',
    this.resetCashpointPin = '',
    this.balance = '',
    this.credit = '',
    this.debit = '',
    this.createWallet = '',
    this.getCategoryTypes = '',
    this.getCategoryIssues = '',
    this.getBusinessTicket = '',
    this.getBusinessTickets = '',
    this.createTicket = '',
    this.updateConversation = '',
    this.updateTicketStatus = '',
  });

  @override
  List<Object?> get props => [
    productionUrl,
    sentryDns,
    appUpdate,
    privacyPolicy,
    termsAndConditions,
    sessionTimeout,
    otpCountdown,
    poweredBy,
    broadcastMsg,
    supportEmail,
    supportNumbers,
    supportWhatsApp,
    whatsappPrefix,
    isProduction,
    token,
    updatePin,
    pinOtpRequest,
    pinOtpVerify,
    pinResetUpdate,
    signup,
    completeSignup,
    updateUserProfile,
    getUserProfile,
    updateBusinessProfile,
    addBusiness,
    bankList,
    nameEnquiry,
    allTransaction,
    transfer,
    setTransPin,
    resetTransPin,
    assignTerminal,
    unAssignTerminal,
    cashpointSummary,
    setCashpointPin,
    resetCashpointPin,
    balance,
    credit,
    debit,
    createWallet,
    getCategoryTypes,
    getCategoryIssues,
    getBusinessTicket,
    getBusinessTickets,
    createTicket,
    updateConversation,
    updateTicketStatus,
  ];

  Map<String, dynamic> toMap() => {
    'URL': productionUrl,
    'SENTRY_DNS': sentryDns,
    'APP_UPDATE': jsonEncode(appUpdate),
    'PRIVACY_POLICY': privacyPolicy,
    'TERMS_AND_CONDITIONS': termsAndConditions,
    'SESSION_TIMEOUT': sessionTimeout.toString(),
    'OTP_COUNTDOWN': otpCountdown.toString(),
    'POWERED_BY': poweredBy,
    'BROADCAST_MSG': broadcastMsg,
    'SUPPORT_EMAIL': supportEmail,
    'SUPPORT_NUMBERS': jsonEncode(supportNumbers),
    'SUPPORT_WHATSAPP': supportWhatsApp,
    'WHATSAPP_PREFIX': whatsappPrefix,
    'IS_PRODUCTION': isProduction.toString(),
    'TOKEN': token,
    'UPDATE_PIN': updatePin,
    'PIN_OTP_REQUEST': pinOtpRequest,
    'PIN_OTP_VERIFY': pinOtpVerify,
    'PIN_RESET_UPDATE': pinResetUpdate,
    'SIGNUP': signup,
    'COMPLETE_SIGNUP': completeSignup,
    'UPDATE_USER_PROFILE': updateUserProfile,
    'GET_USER_PROFILE': getUserProfile,
    'UPDATE_BUSINESS_PROFILE': updateBusinessProfile,
    'ADD_BUSINESS': addBusiness,
    'BANK_LIST': bankList,
    'NAME_ENQUIRY': nameEnquiry,
    'ALL_TRANSACTION': allTransaction,
    'TRANSFER': transfer,
    'SET_TRANS_PIN': setTransPin,
    'RESET_TRANS_PIN': resetTransPin,
    'ASSIGN_TERMINAL': assignTerminal,
    'UNASSIGN_TERMINAL': unAssignTerminal,
    'CASHPOINT_SUMMARY': cashpointSummary,
    'SET_CASHPOINT_PIN': setCashpointPin,
    'RESET_CASHPOINT_PIN': resetCashpointPin,
    'BALANCE': balance,
    'CREDIT': credit,
    'DEBIT': debit,
    'CREATE_WALLET': createWallet,
    'GET_CATEGORY_TYPES': getCategoryTypes,
    'GET_CATEGORY_ISSUES': getCategoryIssues,
    'GET_BUSINESS_TICKET': getBusinessTicket,
    'GET_BUSINESS_TICKETS': getBusinessTickets,
    'CREATE_TICKET': createTicket,
    'UPDATE_CONVERSATION': updateConversation,
    'UPDATE_TICKET_STATUS': updateTicketStatus,
  };

  factory ConfigDataModel.fromMap(Map<String, dynamic> map) => ConfigDataModel(
    productionUrl: map['URL'] ?? '',
    sentryDns: map['SENTRY_DNS'] ?? '',
    appUpdate: _parseJsonMap(map['APP_UPDATE']),
    privacyPolicy: map['PRIVACY_POLICY'] ?? '',
    termsAndConditions: map['TERMS_AND_CONDITIONS'] ?? '',
    sessionTimeout: int.tryParse(map['SESSION_TIMEOUT'] ?? '5') ?? 5,
    otpCountdown: int.tryParse(map['OTP_COUNTDOWN'] ?? '4') ?? 4,
    poweredBy: map['POWERED_BY'] ?? '',
    broadcastMsg: map['BROADCAST_MSG'] ?? '',
    supportEmail: map['SUPPORT_EMAIL'] ?? '',
    supportNumbers: _parseJsonList(map['SUPPORT_NUMBERS']),
    supportWhatsApp: map['SUPPORT_WHATSAPP'] ?? '',
    whatsappPrefix: map['WHATSAPP_PREFIX'] ?? '',
    isProduction: map['IS_PRODUCTION']?.toLowerCase() == 'true',
    token: map['TOKEN'] ?? '',
    updatePin: map['UPDATE_PIN'] ?? '',
    pinOtpRequest: map['PIN_OTP_REQUEST'] ?? '',
    pinOtpVerify: map['PIN_OTP_VERIFY'] ?? '',
    pinResetUpdate: map['PIN_RESET_UPDATE'] ?? '',
    signup: map['SIGNUP'] ?? '',
    completeSignup: map['COMPLETE_SIGNUP'] ?? '',
    updateUserProfile: map['UPDATE_USER_PROFILE'] ?? '',
    getUserProfile: map['GET_USER_PROFILE'] ?? '',
    updateBusinessProfile: map['UPDATE_BUSINESS_PROFILE'] ?? '',
    addBusiness: map['ADD_BUSINESS'] ?? '',
    bankList: map['BANK_LIST'] ?? '',
    nameEnquiry: map['NAME_ENQUIRY'] ?? '',
    allTransaction: map['ALL_TRANSACTION'] ?? '',
    transfer: map['TRANSFER'] ?? '',
    setTransPin: map['SET_TRANS_PIN'] ?? '',
    resetTransPin: map['RESET_TRANS_PIN'] ?? '',
    assignTerminal: map['ASSIGN_TERMINAL'] ?? '',
    unAssignTerminal: map['UNASSIGN_TERMINAL'] ?? '',
    cashpointSummary: map['CASHPOINT_SUMMARY'] ?? '',
    setCashpointPin: map['SET_CASHPOINT_PIN'] ?? '',
    resetCashpointPin: map['RESET_CASHPOINT_PIN'] ?? '',
    balance: map['BALANCE'] ?? '',
    credit: map['CREDIT'] ?? '',
    debit: map['DEBIT'] ?? '',
    createWallet: map['CREATE_WALLET'] ?? '',
    getCategoryTypes: map['GET_CATEGORY_TYPES'] ?? '',
    getCategoryIssues: map['GET_CATEGORY_ISSUES'] ?? '',
    getBusinessTicket: map['GET_BUSINESS_TICKET'] ?? '',
    getBusinessTickets: map['GET_BUSINESS_TICKETS'] ?? '',
    createTicket: map['CREATE_TICKET'] ?? '',
    updateConversation: map['UPDATE_CONVERSATION'] ?? '',
    updateTicketStatus: map['UPDATE_TICKET_STATUS'] ?? '',
  );

  static List<String> _parseJsonList(dynamic value) {
    if (value is String) {
      try {
        return List<String>.from(jsonDecode(value));
      } catch (_) {
        return [];
      }
    }
    return [];
  }

  static Map<String, dynamic> _parseJsonMap(dynamic value) {
    if (value is String) {
      try {
        return jsonDecode(value);
      } catch (_) {
        return {};
      }
    }
    return {};
  }
}
