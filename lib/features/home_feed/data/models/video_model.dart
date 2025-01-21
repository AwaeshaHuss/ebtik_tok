import 'package:ebtik_tok/features/home_feed/domain/entities/video_entity.dart';
import 'package:equatable/equatable.dart';

class VideoModel extends Equatable{
  final dynamic id;
  final String? title;
  final String? description;
  final String? videoUrl;
  final String? category;
  final String? image;

  const VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.category,
    required this.image,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      videoUrl: json['videoUrl'],
      category: json['category'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'videoUrl': videoUrl,
      'category': category,
      'image': image,
    };
  }

  VideoEntity toEntity(){
    return VideoEntity(
      id: id,
      title: title,
      description: description,
      videoUrl: videoUrl,
      category: category,
      image: image,
    );
  }

  @override
  List<Object?> get props => [id, title, description, videoUrl, category, image];

  @override
  bool get stringify => true;

}
