class AppSettings {
  static const String appName = "Smart Food Insight";

  //URLS
  static const String openFoodFacts =
      "https://es.openfoodfacts.org/terms-of-use";
  static const String smartPrivacy =
      "https://smartfoodinsight.github.io/#/privacy-policy";

  //API
  static const String apiUrl = "https://smartfoodinsight.onrender.com";

  static const String apiSupermarket = "/api/supermarket";
  static const String apiSupermarketFinder = "/api/supermarket/finder";

  static const String apiUserEmail = "/api/user/resetEmailPass";
  static const String apiUser = "/api/user";

  static const String apiToken = "/api/auth/token";
  static const String apiRegister = "/api/auth/register";
  static const String apiLoginGoogle = "/api/auth/google";
  static const String apiLogin = "/api/auth/login";

  //ROUTES
  static const information = '/information';
  static const addProductMyFridge = '/add-product-my-fridge/';
  static const productDetails = '/product-details/';
  static const scanfridge = '/scan-fridge';
  static const scandetails = '/scan-details';
  static const signup = '/signup';
  static const login = '/login';
  static const home = '/';
}
