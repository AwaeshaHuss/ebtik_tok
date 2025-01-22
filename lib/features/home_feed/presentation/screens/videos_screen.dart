import 'package:ebtik_tok/config/cache/cahce_helper.dart';
import 'package:ebtik_tok/core/const.dart';
import 'package:ebtik_tok/core/extensions.dart';
import 'package:ebtik_tok/core/utils.dart';
import 'package:ebtik_tok/core/widgets/responsive_layout.dart';
import 'package:ebtik_tok/features/home_feed/data/models/video_model.dart';
import 'package:ebtik_tok/features/home_feed/presentation/bloc/home_feed_bloc.dart';
import 'package:ebtik_tok/features/home_feed/presentation/widgets/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:svg_flutter/svg.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key, this.initialPage = 0});
  final int initialPage;

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  Set<int> _seenVideos = {};

  @override
  void initState() {
    super.initState();
    HomeFeedBloc.get(context).add(GetAllVideosEvent());
  }

  /// Save seen videos to cache
  void _saveSeenVideos(int index) async {
    if (CacheHelper.getData(key: seensCountKey) == index) return;
    _seenVideos.add(index);
    await CacheHelper.saveData(
        key: seensCountKey, value: _seenVideos.toList().length);
  }

  /// * Save video to cache,
  /// I had to use VideoModel here to access fromJson and toJson,
  /// which is required in converting the from List<[VideoModel]> to List<[String]> and vise versa,
  /// * Because sharedPrefrences can't directly save List of custom object.
  void _saveVideo(VideoModel video) async {
      if(CacheHelper.getVideoSet(key: savedVideosKey).contains(video)){
        ShowToastSnackBar.displayToast(message: 'Already saved');
      }else{
        ShowToastSnackBar.displayToast(message: 'Saved');
        await CacheHelper.saveVideo(key: savedVideosKey, video: video);
      }
  }

  @override
  Widget build(BuildContext context) {
    final height = getScreenHeight(context);
    final width = getScreenWidth(context);
    return ResponsiveLayout(
      small: _buildBody(height: height * .95, width: width),
      medium: _buildBody(height: height * .96125, width: width),
    );
  }

  PopScope _buildBody({required double height, required double width}) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        showExitDialog(context);
      },
      child: Scaffold(
        body: BlocBuilder<HomeFeedBloc, HomeFeedState>(
          buildWhen: (previous, current) => previous.videos != current.videos,
          builder: (context, state) {
            if (state.status.isLoading) {
              return Center(
                child: CircularProgressIndicator(
                    color: Colors.grey.shade300, strokeWidth: 1),
              );
            }
            if (state.status.isError) {
              return const Center(
                child: Text(
                  'No videos available.',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
            }
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.videos.length,
              onPageChanged: (index) {
                _saveSeenVideos(index);
              },
              itemBuilder: (context, index) {
                // Build the video player widget
                return _buildVideoContent(height, width, state, index);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildVideoContent(
      double height, double width, HomeFeedState state, int index) {
    return Stack(
      children: [
        VideoPlayerWidget(videoUrl: state.videos[index].videoUrl ?? ''),
        Container(
          margin: EdgeInsetsDirectional.only(top: height * .055),
          alignment: AlignmentDirectional.topCenter,
          child: Text(
            '${state.videos[index].category}',
            style: TextStyle(
              color: Colors.grey.shade300,
              fontSize: 22,
              fontWeight: FontWeight.w900,
              decoration: TextDecoration.combine([TextDecoration.underline]),
              decorationThickness: 4,
              decorationColor: Colors.grey.shade300,
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: BlocBuilder<HomeFeedBloc, HomeFeedState>(
            buildWhen: (previous, current) => previous.liked != current.liked,
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 4),
                  GestureDetector(
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: VideoSearchDelegate(state.videos),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(12.0),
                      width: 34,
                      height: 34,
                      child: SvgPicture.asset(searchIconPath),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      HomeFeedBloc.get(context).add(LikeVideoEvent(index));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(12.0),
                      width: 34,
                      height: 34,
                      child: state.liked[index]
                          ? SvgPicture.asset(likeFilledIconPath)
                          : SvgPicture.asset(likeOutLinedIconPath),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      final videoEntity = state.videos[index];
                      _saveVideo(VideoModel(
                          id: videoEntity.id,
                          title: videoEntity.title,
                          description: videoEntity.description,
                          videoUrl: videoEntity.videoUrl,
                          category: videoEntity.category,
                          image: videoEntity.image,
                          ));
                    },
                    child: Container(
                      margin: const EdgeInsets.all(12.0),
                      width: 44,
                      height: 44,
                      child: SvgPicture.asset(saveIconPath),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await Share.share(
                          'Check out this video: ${state.videos[index].videoUrl}');
                    },
                    child: Container(
                      margin: const EdgeInsets.all(12.0),
                      width: 38,
                      height: 38,
                      child: SvgPicture.asset(shareIconPath),
                    ),
                  ),
                  const Spacer(),
                ],
              );
            },
          ),
        ),
        Container(
          width: width * .725,
          padding: EdgeInsetsDirectional.symmetric(horizontal: 8.0)
              .copyWith(bottom: height * .155),
          alignment: AlignmentDirectional.bottomStart,
          child: Card(
            elevation: 0,
            color: Colors.black.withAlpha(30),
            margin: EdgeInsetsDirectional.symmetric(vertical: 5, horizontal: 2),
            shape: const Border(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: AlignmentDirectional.topStart,
                  margin: const EdgeInsets.all(4.0),
                  child: Text(
                    '${state.videos[index].title}',
                    style: TextStyle(
                      color: const Color(0xFFE0E0E0),
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                  alignment: AlignmentDirectional.topStart,
                  margin: const EdgeInsets.all(4.0),
                  child: Text(
                    '${state.videos[index].description}',
                    style: TextStyle(
                      color: Colors.grey.shade300,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


/*

[
  {
    "id": "1",
    "title": "White Bunny",
    "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque",
    "videoUrl": "https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4",
    "category": "Animal",
    "image": "https://loremflickr.com/cache/resized/defaultImage.small_320_240_nofilter.jpg"
  },
  {
    "id": "2",
    "title": "Car Ride Tips",
    "description": "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind",
    "videoUrl": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    "category": "Productivity",
    "image": "https://fastly.picsum.photos/id/1035/300/300.jpg?hmac=h2e6yb4s09DR32Lvxopvsee73kUjJIpGLxp0IpxxN2c"
  },
  {
    "id": "3",
    "title": "Bunny Home",
    "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque",
    "videoUrl": "https://www.w3schools.com/html/mov_bbb.mp4",
    "category": "Animal",
    "image": "https://loremflickr.com/cache/resized/65535_53065639115_14eaf016a0_320_240_nofilter.jpg"
  },
  {
    "id": "4",
    "title": "Movie Trailer",
    "description": "Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind",
    "videoUrl": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    "category": "Productivity",
    "image": "https://placebear.com/400/400"
  },
  {
    "id": "5",
    "title": "Angry Man",
    "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque",
    "videoUrl": "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4",
    "category": "Productivity",
    "image": "https://fastly.picsum.photos/id/1035/300/300.jpg?hmac=h2e6yb4s09DR32Lvxopvsee73kUjJIpGLxp0IpxxN2c"
  }
]

*/