import 'package:ebtik_tok/core/const.dart';
import 'package:ebtik_tok/core/cubits/bottom_nav_bar_cubit.dart';
import 'package:ebtik_tok/features/home_feed/presentation/screens/videos_screen.dart';
import 'package:ebtik_tok/features/user_profile/presentation/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg.dart';

class BottomNavBar extends StatelessWidget {
  static final List<Widget> _screens = [
    VideosScreen(),
    UserProfileScreen(),
  ];

  static final List<BottomNavigationBarItem> _bottomNavItems = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(homeIconPath),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(profileIconPath),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, int>(
      builder: (context, selectedIndex) {
        final cubit = BottomNavBarCubit.get(context);
        // final cubit = context.read<BottomNavBarCubit>();
        return Scaffold(
          extendBody: true,
          body: _screens[selectedIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 15, top: 14),
            child: BottomNavigationBar(
              items: _bottomNavItems,
              currentIndex: selectedIndex,
              onTap: cubit.updateIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.grey[850],
              type: BottomNavigationBarType.fixed,
              enableFeedback: false,
            ),
          ),
        );
      },
    );
  }
}
