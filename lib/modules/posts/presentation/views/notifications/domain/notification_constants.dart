class NotificationConstants {
  NotificationConstants._();

  // Notification filter types
  static const String filterAll = 'All';
  static const String filterRequests = 'Requests';
  static const String filterComments = 'Comments';
  static const String filterSuggestions = 'Suggestions';
  static const String filterMentions = 'Mentions';
  static const String filterCommunity = 'Community';
  static const String filterPodcasts = 'Podcasts';

  // Empty state
  static const String emptyStateTitle = 'Nothing to see here yet';
  static const String emptyStateSubtitle =
      'When you receive notifications, they\'ll appear here';

  // UI Constants
  static const double filterButtonHeight = 30.0;
  static const double filterButtonBorderRadius = 7.0;
  static const double headerPadding = 16.0;
  static const double topPadding = 60.0;
  static const double iconSize = 24.0;
  static const double avatarSize = 50.0;
  static const double avatarBorderRadius = 10.0;

  // Colors (matching design)
  static const int backgroundColor = 0xFFF8F9FB;
  static const int primaryTextColor = 0xFF180F1A;
  static const int activeFilterColor = 0xFF8C36C2;
  static const int inactiveFilterColor = 0xFFF8F9FB;
  static const int avatarBackgroundColor = 0x149C00FF;
  static const int headerBackgroundColor = 0xCCFFFFFF; // 80% white opacity
  static const int borderColor = 0x1419101A;
  static const int connectedButtonColor = 0x198C36C2;
  static const int showOptionsColor = 0xFFE0E0E0;
  static const int buildItemColor = 0xFFDC3545;

  // Text styles
  static const double titleFontSize = 24.0;
  static const double filterFontSize = 14.0;
  static const double emptyStateFontSize = 18.0;
}

