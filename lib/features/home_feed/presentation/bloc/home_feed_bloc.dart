import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ebtik_tok/core/errors/failures.dart';
import 'package:ebtik_tok/features/home_feed/domain/use_cases/get_all_videos_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebtik_tok/features/home_feed/domain/entities/video_entity.dart';
import 'package:equatable/equatable.dart';

part 'home_feed_event.dart';
part 'home_feed_state.dart';

class HomeFeedBloc extends Bloc<HomeFeedEvent, HomeFeedState> {
  final GetAllVideosUseCase getAllVideosUseCase;
  HomeFeedBloc({required this.getAllVideosUseCase}) : super(HomeFeedState()) {
    on<GetAllVideosEvent>(_getVideos);
    on<LikeVideoEvent>(_likeVideo);
  }
  static HomeFeedBloc get(context) => BlocProvider.of(context);

  FutureOr _getVideos(
      GetAllVideosEvent event, Emitter<HomeFeedState> emit) async {
    emit(state.copyWith(status: HomeFeedStateStatus.loading));
    Either<Failure, List<VideoEntity>> result;
    result = await getAllVideosUseCase();
    result.fold((l) {
      emit(state.copyWith(status: HomeFeedStateStatus.error));
    }, (r) {
      final liked = List<bool>.filled(r.length, false);
      emit(state.copyWith(
          status: HomeFeedStateStatus.success, videos: r, liked: liked));
    });
  }

  void _likeVideo(LikeVideoEvent event, Emitter<HomeFeedState> emit) {
    final newLikedStates = List<bool>.from(state.liked);
    newLikedStates[event.index] = !newLikedStates[event.index];
    emit(state.copyWith(liked: newLikedStates));
  }
}
