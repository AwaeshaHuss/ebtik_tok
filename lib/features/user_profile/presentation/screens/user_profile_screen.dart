import 'package:ebtik_tok/config/cache/cahce_helper.dart';
import 'package:ebtik_tok/core/const.dart';
import 'package:ebtik_tok/core/utils.dart';
import 'package:ebtik_tok/core/widgets/layout_builder.dart';
import 'package:ebtik_tok/core/widgets/responsive_layout.dart';
import 'package:ebtik_tok/core/widgets/text_field_widget.dart';
import 'package:ebtik_tok/features/home_feed/data/models/video_model.dart';
import 'package:ebtik_tok/features/home_feed/presentation/widgets/video_player_widget.dart';
import 'package:ebtik_tok/features/user_profile/domain/entities/user_profile_entity.dart';
import 'package:ebtik_tok/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import 'package:ebtik_tok/features/user_profile/presentation/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svg_flutter/svg.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool dark = false;
  @override
  Widget build(BuildContext context) {
    final savedVideos = CacheHelper.getVideoSet(key: savedVideosKey);
    final height = getScreenHeight(context);
    final width = getScreenWidth(context);
    return ResponsiveLayout(
      small: _buildBody(width, height * .985, savedVideos),
      medium: _buildBody(width, height * .955, savedVideos),
      );
  }

  Scaffold _buildBody(double width, double height, Set<VideoModel> savedVideos) {
    return Scaffold(
    body: BlocBuilder<UserProfileBloc, UserProfileState>(
      buildWhen: (previous, current) =>
          previous.status != current.status && !current.status.isError,
      builder: (context, state) {
        UserProfileEntity? profile = state.userProfileEntity;
        return LayoutBuilderWidget(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: width,
                    height: height * .2,
                    padding: EdgeInsetsDirectional.only(
                        start: 14.0, bottom: 8.0),
                    alignment: AlignmentDirectional.bottomStart,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent[200],
                        borderRadius: BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(12.0),
                            bottomEnd: Radius.circular(12.0))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: Colors.grey.shade300,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              dark = !dark;
                              ThemeCubit.get(context).toggleTheme();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsetsDirectional.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              shape: BoxShape.circle
                            ),
                            child: dark ? SvgPicture.asset(darkModeIconPath) : SvgPicture.asset(lightModeIconPath),
                          ),
                        )
                      ],
                    ),
                  ),
                  PositionedDirectional(
                    bottom: -26,
                    start: width * .385,
                    child: profile != null
                        ? ClipOval(
                            child: SvgPicture.asset(profile.avatar ?? '',
                                fit: BoxFit.cover))
                        : ClipOval(
                            child: SvgPicture.asset(personIconPath,
                                fit: BoxFit.cover)),
                  ),
                ],
              ),
              (height * .065).height,
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFieldWidget(
                    labelText: profile?.name ?? 'name', readOnly: true),
              ),
              (height * .0125).height,
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextFieldWidget(
                    labelText:
                        'total videos watched: ${(CacheHelper.getData(key: seensCountKey) ?? 0) + 1}',
                    readOnly: true),
              ),
              (height * .025).height,
              Container(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: 4.0),
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Saved Videos',
                    style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 17,
                        fontWeight: FontWeight.w700),
                  )),
              SizedBox(
                height: height * .35,
                child: savedVideos.isEmpty
                    ? Center(
                        child: Text(
                          'Empty saved list',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                          childAspectRatio:
                              3 / 4, // Adjust ratio to control card height
                        ),
                        padding: const EdgeInsets.all(8.0),
                        itemCount: savedVideos.length,
                        itemBuilder: (context, index) {
                          final video = savedVideos.toList()[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return VideoPlayerWidget(
                                      videoUrl: video.videoUrl ?? '',
                                      fromSearch: true);
                                },
                              ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: video.image != null
                                          ? NetworkImage(video.image ?? '')
                                          : AssetImage(emptyIconPath)),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(12))),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Stack(
                                  children: [
                                    // Video Details Overlay
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0,
                                            vertical: 12.0),
                                        decoration: BoxDecoration(
                                          color: Colors.black
                                              .withValues(alpha: 0.5),
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            bottom: Radius.circular(12.0),
                                          ),
                                        ),
                                        child: Text(
                                          video.title ?? 'Untitled Video',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        );
      },
    ),
  );
  }
}
