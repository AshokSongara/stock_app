/// This file contains all the text strings used in the application.
/// Centralizing strings makes it easier to maintain and localize the app.

class AppStrings {
  // App General
  static const String appTitle = 'Stock Market App';
  
  // Login Screen
  static const String loginTitle = 'Stock Market App';
  static const String loginButtonText = 'Login';
  static const String emailLabel = 'Email';
  static const String emailHint = 'Enter your email';
  static const String emailValidationEmpty = 'Please enter your email';
  static const String emailValidationInvalid = 'Please enter a valid email address';
  static const String passwordLabel = 'Password';
  static const String passwordHint = 'Enter your password';
  static const String passwordValidationEmpty = 'Please enter your password';
  static const String passwordValidationLength = 'Password must be at least 6 characters';
  
  // Profile Screen
  static const String profileTitle = 'Profile';
  static const String editProfileButtonText = 'Edit Profile';
  static const String nameLabel = 'Name';
  static const String nameValidationEmpty = 'Please enter your name';
  static const String bioLabel = 'Bio';
  
  // Edit Profile Screen
  static const String editProfileTitle = 'Edit Profile';
  static const String saveButtonText = 'Save';
  static const String saveChangesButtonText = 'Save Changes';
  static const String profileUpdateSuccess = 'Profile updated successfully!';
  static const String updateUserFailed = 'Update user failed';
  
  // Stock Screen
  static const String niftySymbol = 'Nifty50';
  static const String niftyDisplayName = 'NIFTY 50';
  static const String sensexSymbol = 'BSE SENSEX';
  static const String sensexDisplayName = 'BSE SENSEX';
  static const String niftyBankDisplayName = 'NIFTY BANK';
  static const String niftyITDisplayName = 'NIFTY IT';
  static const String niftyAutoDisplayName = 'NIFTY AUTO';
  static const String niftyFMCGDisplayName = 'NIFTY FMCG';
  static const String niftyPharmaDisplayName = 'NIFTY PHARMA';
  static const String niftyMetalDisplayName = 'NIFTY METAL';
  static const String nseLabel = 'NSE';
  
  // Error Messages
  static const String errorPrefix = 'Error: ';
  static const String authenticationFailed = 'Authentication failed';
  static const String loginFailed = 'Login failed';
  
  // Validation Patterns
  static const String emailRegexPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
}