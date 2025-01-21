import 'package:dartz/dartz.dart';
import 'package:ebtik_tok/core/errors/failures.dart';
import 'package:ebtik_tok/features/home_feed/domain/entities/video_entity.dart';
import 'package:ebtik_tok/features/home_feed/domain/repositories/home_feed_repository.dart';

class GetAllVideosUseCase{
  final HomeFeedRepository homeFeedRepository;
  GetAllVideosUseCase({required this.homeFeedRepository});

  Future<Either<Failure, List<VideoEntity>>> call() async{
    return await homeFeedRepository.getVideos();
  }
}