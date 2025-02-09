import 'dart:convert';
import 'package:corre_aqui/common/screens/search_screen.dart';
import 'package:corre_aqui/features/auth/screens/auth_gate.dart';
import 'package:corre_aqui/features/auth/screens/forgot_password_screen.dart';
import 'package:corre_aqui/features/auth/screens/login_screen.dart';
import 'package:corre_aqui/features/auth/screens/signin_screen.dart';
import 'package:corre_aqui/features/event/screens/event_details_screen.dart';
import 'package:corre_aqui/features/home/screens/home_screen.dart';
import 'package:corre_aqui/features/home/screens/home_offer_screen.dart';
import 'package:corre_aqui/features/notification/screens/notification_screen.dart';
import 'package:corre_aqui/features/offer/screens/offers_by_category_screen.dart';
import 'package:corre_aqui/features/offer/screens/offer_details_screen.dart';
import 'package:corre_aqui/features/offer-map/screens/offer_map_screen.dart';
import 'package:corre_aqui/features/store/screens/store_details_screen.dart';
import 'package:corre_aqui/features/store/screens/store_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/**
* Helper com todas as rotas para telas da aplicação.
*
* @author Giovane Neves
* @since v0.0.1
*/
class RouteHelper{

  static const String authGate = '/auth-gate';
  static const String eventDetails = '/event-details';
  static const String forgotPassword = '/forgot-password';
  static const String login = '/login';
  static const String home = '/home';
  static const String homeOffer = '/home-offer';
  static const String notification = '/notification';
  static const String offersByCategory = '/offers-by-category';
  static const String offerDetails = '/offer-details';
  static const String offerMap = '/offer-map';
  static const String register = '/register';
  static const String searchScreen = '/search-screen';
  static const String signIn = '/sign-in';
  static const String storeDetails = '/store-details';
  static const String storeList = '/store-list';

  static String getAuthGateScreen() => authGate;
  static String getEventDetailsScreen({required String eventId}){

    return '$eventDetails?event_id=$eventId';    
  
  }
  static String getForgotPasswordScreen() => forgotPassword;
  static String getLoginScreen() => login;
  static String getHomeScreen() => home;
  static String getHomeOfferScreen() => homeOffer;
  static String getNotificationScreen() => notification;
  static String getOffersByCategoryScreen({required int categoryId}){

    return '$offersByCategory?category_id=$categoryId';

  }
  static String getOfferDetailsScreen({required int offerId}){

    return '$offerDetails?offer_id=$offerId';

  }
  static String getOfferMapScreen() => offerMap;
  static String getRegisterScreen() => register;
  static String getSearchScreen() => searchScreen;
  static String getSignInScreen() => signIn;
  static String getStoreDetailsScreen({required int storeId}){

    return '$storeDetails?store_id=$storeId';

  }
  static String getStoreList() => storeList;

  // Registro de rotas [ Adicionar todas as rotas do app aqui ] 
  static List<GetPage> routes = [
    GetPage(name: authGate, page: () => AuthGate()),
    GetPage(name: 
      eventDetails, 
      page: () => EventDetailsScreen(eventId: Get.parameters['event_id']!),
    ),
    GetPage(name: forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: home, page: () => HomeScreen()),
    GetPage(name: homeOffer, page: () => HomeOfferScreen()),
  	GetPage(name: notification, page: () => NotificationScreen()),
    GetPage(
      name: offersByCategory, 
      page: () => OffersByCategoryScreen(categoryId: int.parse(Get.parameters['category_id']!))
    ),
    GetPage(
      name: offerDetails, 
      page: () => OfferDetailsScreen(offerId: int.parse(Get.parameters['offer_id']!)),
    ),
    GetPage(name: offerMap, page: () => OfferMapScreen()),
    GetPage(name: register, page: () => SigninScreen()),
    GetPage(name: searchScreen, page: () => SearchScreen()),
    GetPage(name: signIn, page: () => SigninScreen()),
    GetPage(
      name: storeDetails, page: () => StoreDetailsScreen(storeId: int.parse(Get.parameters['store_id']!)),
    ),
    GetPage(name: storeList, page: () => StoreListScreen()),
  ];

}