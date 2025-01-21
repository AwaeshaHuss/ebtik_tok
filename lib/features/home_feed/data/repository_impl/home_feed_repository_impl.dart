import 'package:dartz/dartz.dart';
import 'package:ebtik_tok/core/errors/exceptions.dart';
import 'package:ebtik_tok/core/errors/failures.dart';
import 'package:ebtik_tok/features/home_feed/data/data_sources/home_feed_data_source.dart';
import 'package:ebtik_tok/features/home_feed/domain/entities/video_entity.dart';
import 'package:ebtik_tok/features/home_feed/domain/repositories/home_feed_repository.dart';

class HomeFeedRepositoryImpl implements HomeFeedRepository{
  final HomeFeedDataSource homeFeedDataSource;
  HomeFeedRepositoryImpl({required this.homeFeedDataSource});

  @override
  Future<Either<Failure, List<VideoEntity>>> getVideos() async{
    final videoModels = await homeFeedDataSource.getAllVideos();
    List<VideoEntity> videoEntities = videoModels.map((videoModel) => videoModel.toEntity()).toList();
    try {
      return Right(videoEntities);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}