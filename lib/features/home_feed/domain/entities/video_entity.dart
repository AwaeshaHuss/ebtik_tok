import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final String? videoUrl;
  final String? category;
  final String? image;

  const VideoEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.videoUrl,
      required this.category,
      required this.image,});

VideoEntity copyWith({String? id, String? title, String? description, String? videoUrl, String? category, String? image}){
  return VideoEntity(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    videoUrl: videoUrl ?? this.videoUrl,
    category: category ?? this.category,
    image: image ?? this.image,
    );
}
      
  @override
  List<Object?> get props => [
    id, title, description, videoUrl, category, image,
  ];
}
