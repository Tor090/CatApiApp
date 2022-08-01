import 'package:cat_api_test_app/repository/repository.dart';
import 'package:cat_api_test_app/service/api_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app/app.dart';

GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository());
  getIt.registerLazySingleton<FavoriteRepository>(() => FavoriteRepository());
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  runApp(App(authenticationRepository: getIt<AuthRepository>()));
}
