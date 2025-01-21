import 'package:dartz/dartz.dart';
import 'package:ebtik_tok/core/errors/failures.dart';
import 'package:ebtik_tok/features/home_feed/domain/entities/video_entity.dart';

abstract class HomeFeedRepository{
  Future<Either<Failure, List<VideoEntity>>> getVideos();
}