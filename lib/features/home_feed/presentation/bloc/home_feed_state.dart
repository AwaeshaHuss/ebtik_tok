part of 'home_feed_bloc.dart';

enum HomeFeedStateStatus { initial, loading, error, success }

extension HomeFeedStateStatusX on HomeFeedStateStatus {
  bool get isInitial => this == HomeFeedStateStatus.initial;
  bool get isLoading => this == HomeFeedStateStatus.loading;
  bool get isError => this == HomeFeedStateStatus.error;
  bool get isSuccess => this == HomeFeedStateStatus.success;
}

class HomeFeedState extends Equatable {
  final HomeFeedStateStatus status;
  final List<VideoEntity> videos;
  final List<bool> liked;
  const HomeFeedState(
      {this.status = HomeFeedStateStatus.initial,
      this.videos = const [],
      this.liked = const [false],});
  HomeFeedState copyWith(
          {HomeFeedStateStatus? status,
          List<VideoEntity>? videos,
          List<bool> liked = const [false],}) =>
      HomeFeedState(
          status: status ?? this.status,
          videos: videos ?? this.videos,
          liked: liked /*?? this.liked*/,);

  @override
  List<Object?> get props => [status, videos, liked];
}
