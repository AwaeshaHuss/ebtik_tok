import 'dart:convert';

import 'package:ebtik_tok/config/network/http_service.dart';
import 'package:ebtik_tok/core/const.dart';
import 'package:ebtik_tok/core/errors/exceptions.dart';
import 'package:ebtik_tok/features/home_feed/data/models/video_model.dart';

abstract class HomeFeedDataSource{
  Future<List<VideoModel>> getAllVideos();
}

class HomeFeedDataSourceImpl implements HomeFeedDataSource {
  @override
  Future<List<VideoModel>> getAllVideos() async{
    final response = await HttpService().call(
    videosEndPoint, 
    method: HttpMethod.get, 
    /*headers: {"Content-Type": "application/json"}*/);
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<VideoModel> postModels = decodedJson
          .map<VideoModel>((json) => VideoModel.fromJson(json))
          .toList();
      return postModels;
    }else{
      throw ServerException();
    }
  }
}