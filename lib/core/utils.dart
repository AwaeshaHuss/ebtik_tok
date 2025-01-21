import 'package:ebtik_tok/features/home_feed/domain/entities/video_entity.dart';
import 'package:ebtik_tok/features/home_feed/presentation/widgets/video_player_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


extension WidgetMargin on num{
  SizedBox get height => SizedBox(height: toDouble(),);
  SizedBox get width => SizedBox(width: toDouble(),);
  Size get size => Size(height.height ?? toDouble(), width.width ?? toDouble());
}

double getScreenWidth(BuildContext context, {bool realWidth = false}) {
  if (realWidth) {
    return MediaQuery.of(context).size.width;
  } //to preview widget like phone scale in preview

  if (kIsWeb) {
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? MediaQuery.of(context).size.width / 4
        : MediaQuery.of(context).size.height / 4;
  }

  return MediaQuery.of(context).orientation == Orientation.portrait
      ? MediaQuery.of(context).size.width
      : MediaQuery.of(context).size.height;
}

double getScreenHeight(BuildContext context, {bool realHeight = false}) {
  if (realHeight) {
    return MediaQuery.of(context).size.height;
  } //to preview widget like phone scale in preview
  if (kIsWeb) {
    return MediaQuery.of(context).orientation == Orientation.landscape
        ? MediaQuery.of(context).size.height / 1.4
        : MediaQuery.of(context).size.width / 1.4;
  }
  return MediaQuery.of(context).orientation == Orientation.portrait
      ? MediaQuery.of(context).size.height
      : MediaQuery.of(context).size.width;
}

bool isBigScreenDevice(c) => getScreenWidth(c) > 600;


class ShowToastSnackBar {
  static Future<bool?> displayToast({
    required String? message,
    bool isError = false,
    bool isSuccess = false,
  }) {
    return Fluttertoast.showToast(
        msg: message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        textColor: Colors.white,
        backgroundColor: const Color(0xff7A3FE1),
        fontSize: 14.0);

  }

  static void showSnackBars(BuildContext context,
      {required String? message,
        bool isError = false,
        bool isSuccess = false,
        Duration? duration,
        SnackBarAction? snackBarAction}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message!,
      ),
      duration: duration ?? const Duration(seconds: 3),
      action: snackBarAction,
      backgroundColor: isError
          ? Colors.red[800]
          : isSuccess
          ? Colors.green[800]
          : null,
    ));
  }
}

// ? the search delegate used to perform search for a video with
// ? suggestions option
class VideoSearchDelegate extends SearchDelegate {
  final List<VideoEntity> videos;

  VideoSearchDelegate(this.videos);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final filteredVideos = videos
        .where((video) => (video.title ?? '').toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Colors.grey.shade300,
      child: ListView.builder(
        itemCount: filteredVideos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filteredVideos[index].title ?? ''),
            subtitle: Text(filteredVideos[index].description ?? ''),
            onTap: () {
              close(context, null);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VideoPlayerWidget(
                    fromSearch: true,
                    videoUrl: filteredVideos[index].videoUrl ?? '',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<VideoEntity> filteredVideos = videos
        .where((video) => (video.title ?? '').toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      color: Colors.grey.shade300,
      child: ListView.builder(
        itemCount: filteredVideos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(filteredVideos[index].title ?? ''),
            subtitle: Text(filteredVideos[index].description ?? ''),
            onTap: () {
              close(context, null);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => VideoPlayerWidget(
                    fromSearch: true,
                    videoUrl: filteredVideos[index].videoUrl ?? '',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
