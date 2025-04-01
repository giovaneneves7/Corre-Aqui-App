import 'package:corre_aqui/api/supabase_api_client.dart';
import 'package:corre_aqui/features/auth/domain/services/auth_service.dart';
import 'package:corre_aqui/features/banner/controllers/banner_controller.dart';
import 'package:corre_aqui/features/banner/domain/repositories/banner_repository_interface.dart';
import 'package:corre_aqui/features/banner/domain/repositories/banner_repository.dart';
import 'package:corre_aqui/features/banner/domain/services/banner_service.dart';
import 'package:corre_aqui/features/banner/domain/services/banner_service_interface.dart';
import 'package:corre_aqui/features/category/controllers/category_controller.dart';
import 'package:corre_aqui/features/category/domain/repositories/category_repository.dart';
import 'package:corre_aqui/features/category/domain/repositories/category_repository_interface.dart';
import 'package:corre_aqui/features/category/domain/services/category_service.dart';
import 'package:corre_aqui/features/category/domain/services/category_service_interface.dart';
import 'package:corre_aqui/features/event/controllers/event_controller.dart';
import 'package:corre_aqui/features/event/domain/repositories/event_repository.dart';
import 'package:corre_aqui/features/event/domain/repositories/event_repository_interface.dart';
import 'package:corre_aqui/features/event/domain/services/event_service.dart';
import 'package:corre_aqui/features/event/domain/services/event_service_interface.dart';
import 'package:corre_aqui/features/offer/controllers/offer_controller.dart';
import 'package:corre_aqui/features/offer/domain/repositories/offer_repository.dart';
import 'package:corre_aqui/features/offer/domain/repositories/offer_repository_interface.dart';
import 'package:corre_aqui/features/offer/domain/services/offer_service.dart';
import 'package:corre_aqui/features/offer/domain/services/offer_service_interface.dart';
import 'package:corre_aqui/features/profile/controllers/profile_controller.dart';
import 'package:corre_aqui/features/profile/domain/repositories/profile_repository.dart';
import 'package:corre_aqui/features/profile/domain/repositories/profile_repository_interface.dart';
import 'package:corre_aqui/features/profile/domain/services/profile_service.dart';
import 'package:corre_aqui/features/profile/domain/services/profile_service_interface.dart';
import 'package:corre_aqui/features/store/domain/repositories/store_repository.dart';
import 'package:corre_aqui/features/store/controllers/store_controller.dart';
import 'package:corre_aqui/features/store/domain/repositories/store_repository_interface.dart';
import 'package:corre_aqui/features/store/domain/services/store_service.dart';
import 'package:corre_aqui/features/store/domain/services/store_service_interface.dart';
import 'package:corre_aqui/features/zone/controllers/zone_controller.dart';
import 'package:corre_aqui/features/zone/domain/repositories/zone_repository.dart';
import 'package:corre_aqui/features/zone/domain/repositories/zone_repository_interface.dart';
import 'package:corre_aqui/features/zone/domain/services/zone_service.dart';
import 'package:corre_aqui/features/zone/domain/services/zone_service_interface.dart';

import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> init() async {

	final sharedPreferences = await SharedPreferences.getInstance();
	final supabaseClient = SupabaseApiClient(
    	client: Supabase.instance.client,
    	authToken: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1weXlvb3N3Y3Vka2dvdWlvbXVvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzMwNTk5OTgsImV4cCI6MjA0ODYzNTk5OH0.zjQSRDm22Q8A-hCGyLLd9MObB9pIMCmf9bKg9aaE6AA',
  		sharedPreferences: sharedPreferences,
  	);

	Get.lazyPut(() => sharedPreferences);
	Get.lazyPut(() => supabaseClient);


	// Repositories
	BannerRepositoryInterface bannerRepository = BannerRepository(apiClient: Get.find());
	Get.lazyPut(() => bannerRepository);

	CategoryRepositoryInterface categoryRepositoryInterface = CategoryRepository(apiClient: Get.find());
	Get.lazyPut(() => categoryRepositoryInterface);

	EventRepositoryInterface eventRepositoryInterface = EventRepository(apiClient: Get.find());
	Get.lazyPut(() => eventRepositoryInterface);

	OfferRepositoryInterface offerRepositoryInterface = OfferRepository(apiClient: Get.find());
	Get.lazyPut(() => offerRepositoryInterface);

	ProfileRepositoryInterface profileRepositoryInterface = ProfileRepository(apiClient: Get.find());
	Get.lazyPut(() => profileRepositoryInterface);

	StoreRepositoryInterface storeRepository = StoreRepository(apiClient: Get.find());
	Get.lazyPut(() => storeRepository);

	ZoneRepositoryInterface zoneRepository = ZoneRepository(apiClient: Get.find(), sharedPreferences: Get.find());
	Get.lazyPut(() => zoneRepository);

	// Services

	AuthService authService = AuthService();
	Get.lazyPut(() => authService);

	BannerServiceInterface bannerServiceInterface = BannerService(bannerRepositoryInterface: Get.find());
	Get.lazyPut(() => bannerServiceInterface);
	
	CategoryServiceInterface categoryServiceInterface = CategoryService(categoryRepositoryInterface: Get.find());
	Get.lazyPut(() => categoryServiceInterface);

	EventServiceInterface eventServiceInterface = EventService(eventRepositoryInterface: Get.find());
	Get.lazyPut(() => eventServiceInterface);

	OfferServiceInterface offerServiceInterface = OfferService(offerRepositoryInterface: Get.find());
	Get.lazyPut(() => offerServiceInterface);

	ProfileServiceInterface profileServiceInterface = ProfileService(profileRepository: Get.find());
	Get.lazyPut(() => profileServiceInterface);

	StoreServiceInterface storeService = StoreService(storeRepository: Get.find());
	Get.lazyPut(() => storeService);

	ZoneServiceInterface zoneService = ZoneService(zoneRepository: Get.find(), sharedPreferences: Get.find());
	Get.lazyPut(() => zoneService);

	Get.lazyPut(() => BannerController(bannerServiceInterface: Get.find()));
	Get.lazyPut(() => CategoryController(categoryServiceInterface: Get.find()));
	Get.lazyPut(() => EventController(eventServiceInterface: Get.find()));
	Get.lazyPut(() => OfferController(offerServiceInterface: Get.find()));
	Get.lazyPut(() => ProfileController(profileService: Get.find()));
	Get.lazyPut(() => StoreController(storeService: Get.find()));
	Get.lazyPut(() => ZoneController(zoneService: Get.find()));
}