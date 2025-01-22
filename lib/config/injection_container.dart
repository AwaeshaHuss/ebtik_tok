import 'package:ebtik_tok/core/cubits/bottom_nav_bar_cubit.dart';
import 'package:ebtik_tok/features/authentication/data/data_sources/authentication_data_source.dart';
import 'package:ebtik_tok/features/authentication/data/repositories_impl/authentication_repository_impl.dart';
import 'package:ebtik_tok/features/authentication/domain/repositories/auhtentication_repo.dart';
import 'package:ebtik_tok/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:ebtik_tok/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:ebtik_tok/features/home_feed/data/data_sources/home_feed_data_source.dart';
import 'package:ebtik_tok/features/home_feed/data/repository_impl/home_feed_repository_impl.dart';
import 'package:ebtik_tok/features/home_feed/domain/repositories/home_feed_repository.dart';
import 'package:ebtik_tok/features/home_feed/domain/use_cases/get_all_videos_use_case.dart';
import 'package:ebtik_tok/features/home_feed/presentation/bloc/home_feed_bloc.dart';
import 'package:ebtik_tok/features/user_profile/data/data_sources/user_profile_data_source.dart';
import 'package:ebtik_tok/features/user_profile/data/repositories_impl/user_profile_repository_impl.dart';
import 'package:ebtik_tok/features/user_profile/domain/repositories/user_profile_repo.dart';
import 'package:ebtik_tok/features/user_profile/domain/use_cases/get_user_profile_use_case.dart';
import 'package:ebtik_tok/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:ebtik_tok/features/user_profile/presentation/cubit/theme_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future init() async{

  /// * Features - Authentication
  /// Bloc
  sl.registerFactory(() => AuthenticationBloc(loginUseCase: sl()));
  
  /// UseCase
  sl.registerLazySingleton(() => LoginUseCase(auhtenticationRepo: sl()));
  
  /// Repository
  sl.registerLazySingleton<AuhtenticationRepo>(() => AuthenticationRepositoryImpl(authenticationDataSource: sl()));
  
  /// DataSource
  sl.registerLazySingleton<AuthenticationDataSource>(() => AuthenticationDataSourceImpl());
  
  // ! ===========

  /// * Features - UserProfile
  /// Bloc
  sl.registerFactory(() => UserProfileBloc(getUserProfileUseCase: sl()));

  /// UseCase
  sl.registerLazySingleton(() => GetUserProfileUseCase(userProfileRepo: sl()));

  /// Repository
  sl.registerLazySingleton<UserProfileRepo>(() => UserProfileRepositoryImpl(userProfileDataSource: sl()));

  /// Data Source
  sl.registerLazySingleton<UserProfileDataSource>(() => UserProfileDataSourceImpl());


  // ! ============

  /// * Features - HomeFeed
  /// Bloc
  sl.registerFactory(() => HomeFeedBloc(getAllVideosUseCase: sl()));
  
  /// Use Case
  sl.registerLazySingleton(() => GetAllVideosUseCase(homeFeedRepository: sl()));
  
  /// Repository
  sl.registerLazySingleton<HomeFeedRepository>(() => HomeFeedRepositoryImpl(homeFeedDataSource: sl()));
  
  /// Data Source
  sl.registerLazySingleton<HomeFeedDataSource>(() => HomeFeedDataSourceImpl());






  /// * OTHERS
  sl.registerFactory(() => ThemeCubit());
  sl.registerFactory(() => BottomNavBarCubit());
  
}