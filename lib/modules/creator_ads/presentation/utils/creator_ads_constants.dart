/// Consolidated constants for all creator ads screens and components
class CreatorAdsConstants {
  CreatorAdsConstants._();

  // =============================================================================
  // LYKLUK STUDIO SCREEN CONSTANTS
  // =============================================================================
  static const String studioScreenTitle = 'LykLuk Studio';
  static const String studioSubtitle = 'Create compelling ads from your posts';

  // For backwards compatibility with existing files
  static const String lykLukStudio = 'LykLuk Studio';

  // Analytics Section
  static const String analyticsTitle = 'Analytics';
  static const String analytics = 'Analytics'; // backwards compatibility
  static const String insights = 'Insights';
  static const String yourTools = 'Your tools';
  static const String dateRange = 'Sep 1-30, 2024';

  static const String viewsLabel = 'Views';
  static const String views = 'Views'; // backwards compatibility
  static const String interactionsLabel = 'Interactions';
  static const String interactions = 'Interactions'; // backwards compatibility
  static const String likesLabel = 'Likes';
  static const String likes = 'Likes'; // backwards compatibility

  // Analytics values
  static const String viewsCount = '3.4K';
  static const String interactionsCount = '2.4K';
  static const String likesCount = '1.2K';

  // Growth percentages
  static const String growthPositive = '12%';
  static const String growthMedium = '8%';
  static const String growthNegative = '3%';
  static const String timePeriod = '7d';

  // Latest Post Section
  static const String latestPostTitle = 'Latest Post';
  static const String yourLatestPost =
      'Your Latest Post'; // backwards compatibility
  static const String latestPostTime = '2 hours ago';
  static const String latestPostTime2 = '2 hrs ago'; // backwards compatibility
  static const String postViews = '12.5K'; // Latest post views
  static const String postLikes = '2.8K'; // Latest post likes

  // Mutuals Section
  static const String totalMutualsTitle = 'Total Mutuals';
  static const String totalMutuals = '45.8K'; // backwards compatibility
  static const String totalMutualsDesc =
      'People who follow you and you follow back';
  static const String requestsLabel = 'Requests';
  static const String requests = '12'; // backwards compatibility
  static const String totalPostsLabel = 'Total Posts';
  static const String totalPosts = '834'; // backwards compatibility
  static const String totalShares = 'Total Shares'; // Total shares count
  static const String twentyFiveM = '25M'; // Generic large number value

  // Tools Section
  static const String inspiration = 'Inspiration';
  static const String wallet = 'Wallet';

  // Recommended Section
  static const String recommendedTitle = 'Recommended';
  static const String recommended = 'Recommended'; // backwards compatibility
  static const String createAdsText = 'Create Ads from Your Posts';
  static const String createAdsFromPosts =
      'Create Ads from Your Posts'; // backwards compatibility
  static const String createAdsDescription =
      'Turn your posts into compelling advertisements';
  static const String createAdsDesc =
      'Turn your best posts into high-performing ads and reach more people'; // backwards compatibility
  static const String getStartedButton = 'Get Started';
  static const String getStarted = 'Get Started'; // backwards compatibility

  // =============================================================================
  // ADS TOOL SCREEN CONSTANTS
  // =============================================================================
  static const String adsToolTitle = 'Create Your Ad Campaign';
  static const String backButton = 'Back';

  // For backwards compatibility with existing files
  static const String adTools = 'Ad tools';

  // Goal Selection
  static const String goalSectionTitle = 'Campaign Goal';
  static const String goalSectionSubtitle =
      'What do you want to achieve with this ad?';
  static const String chooseYourGoal =
      'Choose your goal'; // backwards compatibility

  // Goal options
  static const String boostAccount = 'Boost account';
  static const String getSales = 'Get sales';
  static const String getLeads = 'Get leads';
  static const String moreVideoViews = 'More video views';
  static const String moreFollowers = 'More followers';
  static const String moreProfileViews = 'More profile views';

  static const List<String> campaignGoals = [
    'Brand Awareness',
    'Reach',
    'Traffic',
    'Engagement',
    'App Installs',
    'Video Views',
    'Lead Generation',
    'Messages',
    'Conversions',
    'Catalog Sales',
    'Store Traffic',
  ];

  // Post Selection
  static const String postSelectionTitle = 'Choose Your Post';
  static const String postSelectionSubtitle =
      'Select the post you want to promote';
  static const String postsAvailable = '24 posts available';
  static const String selectPostButton = 'Select Posts';

  // For backwards compatibility
  static const String selectPost = 'Select post';
  static const String onePost = '1 post';

  // Audience Section
  static const String audienceTitle = 'Define Your Audience';
  static const String audienceSubtitle = 'Who do you want to see your ad?';
  static const String automaticAudience = 'Automatic (Recommended)';
  static const String automaticAudienceDesc =
      'We\'ll show your ad to people most likely to engage';
  static const String customAudience = 'Custom Audience';
  static const String customAudienceDesc =
      'You choose the demographics and interests';
  static const String customizeButton = 'Customize';

  // For backwards compatibility
  static const String defineYourAudience = 'Define your audience';
  static const String estimatedVideoViews = 'Estimated video views';
  static const String estimatedViewsRange = '1.2K - 3.5K';
  static const String defaultAudience =
      'Default audience (LykLuk chooses for you)';
  static const String custom = 'Custom';

  // Audience details
  static const String genderAll = 'Gender: All';
  static const String age1855 = 'Age: 18 - 55';
  static const String interests = 'Interests:';
  static const String culture = 'Culture';
  static const String art = 'Art';
  static const String nature = 'Nature';
  static const String folkMusic = 'Folk Music';
  static const String storytelling = 'Storytelling';
  static const String festivals = 'Festivals';
  static const String textile = 'Textile';
  static const String painting = 'Painting';
  static const String sculpture = 'Sculpture';

  // Gender Options
  static const String genderTitle = 'Gender';
  static const String gender = 'Gender'; // backwards compatibility
  static const String all = 'All';
  static const String female = 'Female';
  static const String male = 'Male';
  static const List<String> genderOptions = ['All', 'Men', 'Women'];

  // Age Options
  static const String ageTitle = 'Age Range';
  static const String age = 'Age'; // backwards compatibility
  static const String age1317 = '13-17';
  static const String age1824 = '18-24';
  static const String age2534 = '25-34';
  static const String age3544 = '35-44';
  static const String age4554 = '45-54';
  static const String age55Plus = '55+';
  static const List<String> ageOptions = [
    '18-24',
    '25-34',
    '35-44',
    '45-54',
    '55-64',
    '65+',
  ];

  // Interest Options
  static const String interestsTitle = 'Interests';
  static const List<String> interestOptions = [
    'Fashion',
    'Technology',
    'Travel',
    'Food',
    'Music',
    'Sports',
    'Art',
    'Business',
    'Health',
    'Education',
    'Entertainment',
  ];

  // Budget Section
  static const String budgetTitle = 'Set Your Budget';
  static const String budgetSubtitle = 'How much do you want to spend?';
  static const String dailyBudgetLabel = 'Daily Budget';
  static const String totalBudgetLabel = 'Total Budget';
  static const String currencySymbol = '\$';
  static const String budgetHint = 'Enter amount';

  // For backwards compatibility
  static const String setBudgetAndDuration = 'Set budget and duration';
  static const String budget = 'Budget';
  static const String budgetPerDay = '₦ 50,200 per day';
  static const String enterBudget = 'Enter budget';

  // Duration Section
  static const String durationTitle = 'Campaign Duration';
  static const String durationSubtitle = 'How long should your ad run?';
  static const String startDateLabel = 'Start Date';
  static const String endDateLabel = 'End Date';
  static const String duration = 'Duration'; // backwards compatibility
  static const String tenDays = '10 days'; // backwards compatibility

  // Preview Section
  static const String previewTitle = 'Preview Your Ad';
  static const String previewButton = 'Preview & Continue';
  static const String createCampaignButton = 'Create Campaign';

  // Bottom navigation
  static const String preview = 'Preview';
  static const String create = 'Create';
  static const String dashboard = 'Dashboard';

  // Price details
  static const String priceDetails = 'Price details';
  static const String subtotal = 'Subtotal';

  // =============================================================================
  // ADS PREVIEW SCREEN CONSTANTS
  // =============================================================================
  static const String previewScreenTitle = 'Ad Preview';
  static const String previewSubtitle = 'See how your ad will look';
  static const String confirmButton = 'Confirm & Proceed';

  // For backwards compatibility with ads_preview_constants
  static const String confirm = 'Confirm';
  static const String post = 'Post';
  static const String defaultDuration = '0:00';
  static const String samplePostTitle = 'Block Global Roots 🌍🌳';
  static const String samplePostTime = '10 mins ago';
  static const String samplePostDescription =
      'Dive into a vibrant community where we bring cultural stories to life.';
  static const String originalMusic = 'original music';
  static const String avatarPlaceholder = 'https://placehold.co/44x44';
  static const String shareText = 'Share';
  static const String likeText = 'Like';
  static const String commentText = 'Comment';

  // Post Grid
  static const String selectPostGridTitle = 'Select a post to preview:';

  // Social Content
  static const String profileName = 'Your Profile';
  static const String profileHandle = '@yourhandle';
  static const String postLocation = 'Location';
  static const String sponsoredLabel = 'Sponsored';
  static const String learnMoreButton = 'Learn More';
  static const String connectButton = 'Connect';

  // Social Actions - consolidated with studio analytics
  static const String commentsCount = '89';
  static const String sharesCount = '45';
  static const String savesCount = '12';

  // =============================================================================
  // CUSTOM AUDIENCE MODAL CONSTANTS
  // =============================================================================
  static const String customAudienceTitle = 'Custom Audience';
  static const String customAudienceSubtitle = 'Define your target audience';
  static const String saveButton = 'Save';
  static const String cancelButton = 'Cancel';
  static const String resetButton = 'Reset to Default';

  // Location Section
  static const String locationTitle = 'Location';
  static const String locationHint = 'Enter location';
  static const List<String> locationSuggestions = [
    'United States',
    'Canada',
    'United Kingdom',
    'Australia',
    'Germany',
    'France',
    'Japan',
    'Brazil',
  ];

  // =============================================================================
  // COMMON UI CONSTANTS
  // =============================================================================
  static const String okButton = 'OK';
  static const String doneButton = 'Done';
  static const String nextButton = 'Next';
  static const String previousButton = 'Previous';
  static const String skipButton = 'Skip';
  static const String continueButton = 'Continue';

  // Error Messages
  static const String errorTitle = 'Error';
  static const String successTitle = 'Success';
  static const String warningTitle = 'Warning';
  static const String infoTitle = 'Information';

  // Loading States
  static const String loadingText = 'Loading...';
  static const String processingText = 'Processing...';
  static const String savingText = 'Saving...';

  // Validation Messages
  static const String requiredFieldError = 'This field is required';
  static const String invalidBudgetError = 'Please enter a valid budget amount';
  static const String invalidDateError = 'Please select a valid date range';
  static const String minimumBudgetError = 'Minimum budget is \$5 per day';
}