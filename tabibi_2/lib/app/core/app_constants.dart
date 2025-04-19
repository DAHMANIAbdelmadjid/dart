class AppConstants {
  static const String appName = 'Tabibe';
  static const String baseUrl = 'https://api.tabibe.com'; 
  static const String clinicsUrl = 'http://localhost:5245/api/clinics'; 
  // API Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String doctors = '/doctors';
  static const String appointments = '/appointments';
  
  // Asset Paths
  static const String logoPath = 'assets/images/logo.png';
  
  // Shared Preferences Keys
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  
  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
}
