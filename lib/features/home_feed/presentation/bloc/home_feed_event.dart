part of 'home_feed_bloc.dart';

sealed class HomeFeedEvent extends Equatable {
  const HomeFeedEvent();
  @override
  List<Object> get props => [];
}

class GetAllVideosEvent extends HomeFeedEvent{
  const GetAllVideosEvent();
}

class LikeVideoEvent extends HomeFeedEvent{
  final int index;
  const LikeVideoEvent(this.index);
}

class ShareVideoEvent extends HomeFeedEvent{
  const ShareVideoEvent();
}