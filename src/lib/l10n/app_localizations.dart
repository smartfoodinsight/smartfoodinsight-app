import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @privacyPolicy.
  ///
  /// In es, this message translates to:
  /// **'Política de privacidad'**
  String get privacyPolicy;

  /// No description provided for @information.
  ///
  /// In es, this message translates to:
  /// **'Información'**
  String get information;

  /// No description provided for @highestPrice.
  ///
  /// In es, this message translates to:
  /// **'Precio más alto'**
  String get highestPrice;

  /// No description provided for @lowestPrice.
  ///
  /// In es, this message translates to:
  /// **'Precio más bajo'**
  String get lowestPrice;

  /// No description provided for @tryagain.
  ///
  /// In es, this message translates to:
  /// **'Inténtalo de nuevo'**
  String get tryagain;

  /// No description provided for @supermarkets.
  ///
  /// In es, this message translates to:
  /// **'Supermercados'**
  String get supermarkets;

  /// No description provided for @save.
  ///
  /// In es, this message translates to:
  /// **'Guardar'**
  String get save;

  /// No description provided for @deleteAccount.
  ///
  /// In es, this message translates to:
  /// **'Eliminar cuenta'**
  String get deleteAccount;

  /// No description provided for @theProductExpired.
  ///
  /// In es, this message translates to:
  /// **'¡Atención! este producto ha caducado, cuidado al consumirlo'**
  String get theProductExpired;

  /// No description provided for @pricesProducts.
  ///
  /// In es, this message translates to:
  /// **'Precios'**
  String get pricesProducts;

  /// No description provided for @myProfile.
  ///
  /// In es, this message translates to:
  /// **'Mi perfil'**
  String get myProfile;

  /// No description provided for @openConfiguration.
  ///
  /// In es, this message translates to:
  /// **'Abrir configuración'**
  String get openConfiguration;

  /// No description provided for @enableNotificationPermission.
  ///
  /// In es, this message translates to:
  /// **'Por favor, habilite los permisos de notificación en la configuración de la aplicación'**
  String get enableNotificationPermission;

  /// No description provided for @notificationPermission.
  ///
  /// In es, this message translates to:
  /// **'Permisos de notificación denegados'**
  String get notificationPermission;

  /// No description provided for @years.
  ///
  /// In es, this message translates to:
  /// **'años'**
  String get years;

  /// No description provided for @expiresYear.
  ///
  /// In es, this message translates to:
  /// **'Caduca en 1 año'**
  String get expiresYear;

  /// No description provided for @months.
  ///
  /// In es, this message translates to:
  /// **'meses'**
  String get months;

  /// No description provided for @expiresMonth.
  ///
  /// In es, this message translates to:
  /// **'Caduca en 1 mes'**
  String get expiresMonth;

  /// No description provided for @days.
  ///
  /// In es, this message translates to:
  /// **'días'**
  String get days;

  /// No description provided for @expiresDay.
  ///
  /// In es, this message translates to:
  /// **'Caduca en 1 día'**
  String get expiresDay;

  /// No description provided for @expired.
  ///
  /// In es, this message translates to:
  /// **'Caducado'**
  String get expired;

  /// No description provided for @expiresIn.
  ///
  /// In es, this message translates to:
  /// **'Caduca en'**
  String get expiresIn;

  /// No description provided for @expiresToday.
  ///
  /// In es, this message translates to:
  /// **'Caduca hoy'**
  String get expiresToday;

  /// No description provided for @gallery.
  ///
  /// In es, this message translates to:
  /// **'Galería'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In es, this message translates to:
  /// **'Cámara'**
  String get camera;

  /// No description provided for @useByDate.
  ///
  /// In es, this message translates to:
  /// **'Fecha límite de consumo (momento en el que recibirás la notificación)'**
  String get useByDate;

  /// No description provided for @addProductManually.
  ///
  /// In es, this message translates to:
  /// **'Añadir producto manualmente'**
  String get addProductManually;

  /// No description provided for @scanProduct.
  ///
  /// In es, this message translates to:
  /// **'Escanea un producto'**
  String get scanProduct;

  /// No description provided for @myFridgeProducts.
  ///
  /// In es, this message translates to:
  /// **'Añade productos contra el desperdicio alimentario para cuidar el planeta'**
  String get myFridgeProducts;

  /// No description provided for @productsEmpty.
  ///
  /// In es, this message translates to:
  /// **'¡Ups! Escanea un producto y agrégalo a tus favoritos'**
  String get productsEmpty;

  /// No description provided for @undo.
  ///
  /// In es, this message translates to:
  /// **'Deshacer'**
  String get undo;

  /// No description provided for @deletedProduct.
  ///
  /// In es, this message translates to:
  /// **'Producto eliminado'**
  String get deletedProduct;

  /// No description provided for @openFoodFactsInfo.
  ///
  /// In es, this message translates to:
  /// **'Información ofrecida por Open Food Facts'**
  String get openFoodFactsInfo;

  /// No description provided for @per.
  ///
  /// In es, this message translates to:
  /// **'Por'**
  String get per;

  /// No description provided for @salt.
  ///
  /// In es, this message translates to:
  /// **'Sal'**
  String get salt;

  /// No description provided for @proteins.
  ///
  /// In es, this message translates to:
  /// **'Proteinas'**
  String get proteins;

  /// No description provided for @fiber.
  ///
  /// In es, this message translates to:
  /// **'Fibra'**
  String get fiber;

  /// No description provided for @sugars.
  ///
  /// In es, this message translates to:
  /// **'Azúcares'**
  String get sugars;

  /// No description provided for @carbohydrates.
  ///
  /// In es, this message translates to:
  /// **'Carbohridatos'**
  String get carbohydrates;

  /// No description provided for @saturatedFats.
  ///
  /// In es, this message translates to:
  /// **'Grasas saturadas'**
  String get saturatedFats;

  /// No description provided for @fats.
  ///
  /// In es, this message translates to:
  /// **'Grasas'**
  String get fats;

  /// No description provided for @calories.
  ///
  /// In es, this message translates to:
  /// **'Calorías'**
  String get calories;

  /// No description provided for @nutriInfo.
  ///
  /// In es, this message translates to:
  /// **'Información nutricional'**
  String get nutriInfo;

  /// No description provided for @myFridge.
  ///
  /// In es, this message translates to:
  /// **'Mi nevera'**
  String get myFridge;

  /// No description provided for @products.
  ///
  /// In es, this message translates to:
  /// **'Productos'**
  String get products;

  /// No description provided for @registerSucess.
  ///
  /// In es, this message translates to:
  /// **'Hemos enviado un correo a la dirección indicada, revise su bandeja de entrada o la carpeta de spam y siga las indicaciones'**
  String get registerSucess;

  /// No description provided for @registerError.
  ///
  /// In es, this message translates to:
  /// **'Se produjo un error al registrar su cuenta'**
  String get registerError;

  /// No description provided for @loginError.
  ///
  /// In es, this message translates to:
  /// **'Usuario o contraseña incorrectos'**
  String get loginError;

  /// No description provided for @emailIsNotValid.
  ///
  /// In es, this message translates to:
  /// **'Formato de email incorrecto'**
  String get emailIsNotValid;

  /// No description provided for @fieldIsEmpty.
  ///
  /// In es, this message translates to:
  /// **'Campo requerido'**
  String get fieldIsEmpty;

  /// No description provided for @passwordEmail.
  ///
  /// In es, this message translates to:
  /// **'Te enviaremos un correo con las instrucciones para recuperar tu contraseña'**
  String get passwordEmail;

  /// No description provided for @send.
  ///
  /// In es, this message translates to:
  /// **'Enviar'**
  String get send;

  /// No description provided for @name.
  ///
  /// In es, this message translates to:
  /// **'Nombre'**
  String get name;

  /// No description provided for @forgotPassowrd.
  ///
  /// In es, this message translates to:
  /// **'¿Has olvidado la contraseña?'**
  String get forgotPassowrd;

  /// No description provided for @dontAccount.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes una cuenta?'**
  String get dontAccount;

  /// No description provided for @passwordFormat.
  ///
  /// In es, this message translates to:
  /// **'Debe de tener una mayúscula, letras y un número'**
  String get passwordFormat;

  /// No description provided for @passwordLength.
  ///
  /// In es, this message translates to:
  /// **'Mínimo 6 caracteres'**
  String get passwordLength;

  /// No description provided for @password.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get password;

  /// No description provided for @email.
  ///
  /// In es, this message translates to:
  /// **'Correo'**
  String get email;

  /// No description provided for @logout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get logout;

  /// No description provided for @login.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In es, this message translates to:
  /// **'Regístrate'**
  String get signup;

  /// No description provided for @accept.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get accept;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
