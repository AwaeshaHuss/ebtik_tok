import 'package:ebtik_tok/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:ebtik_tok/features/home_feed/presentation/bloc/home_feed_bloc.dart';
import 'package:ebtik_tok/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:ebtik_tok/features/user_profile/presentation/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebtik_tok/config/injection_container.dart' as di;

MultiBlocProvider blocProviders({required Widget child}){
  return MultiBlocProvider(providers: [
    BlocProvider(create: (_) => di.sl<AuthenticationBloc>()),
    BlocProvider(create: (_) => di.sl<UserProfileBloc>()..add(GetUserProfileEvent())),
    BlocProvider(create: (_) => di.sl<HomeFeedBloc>()),
    BlocProvider(create: (_) => di.sl<ThemeCubit>()),
    /// rest of BlocProviders you have
  ], child: child);
}