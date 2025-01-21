import 'dart:developer';

import 'package:ebtik_tok/config/bloc_observer.dart';
import 'package:ebtik_tok/config/bloc_providers.dart';
import 'package:ebtik_tok/config/cache/cahce_helper.dart';
import 'package:ebtik_tok/core/const.dart';
import 'package:ebtik_tok/core/widgets/error_widget.dart';
import 'package:ebtik_tok/features/authentication/presentation/screens/login_screen.dart';
import 'package:ebtik_tok/core/widgets/bottom_nav_bar.dart';
import 'package:ebtik_tok/features/user_profile/presentation/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:ebtik_tok/config/injection_container.dart' as di;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await di.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Bloc.observer = AppBlocObserver();
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return CustomErrorWidget(details: details);
  };
  runApp(EbtikarApp());
}

class EbtikarApp extends StatelessWidget {
  const EbtikarApp({super.key});

  @override
  Widget build(BuildContext context) {
    String uTocken = CacheHelper.getData(key: uTockenKey) ?? '';
    log(uTocken);
    return blocProviders(
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              fontFamily: 'Proxima Nova',
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              fontFamily: 'Proxima Nova',
              scaffoldBackgroundColor: Colors.black,
            ),
            themeMode: state.themeMode,
            home: uTocken.isEmpty ? LoginScreen() : BottomNavBar(),
          );
        },
      ),
    );
  }
}
