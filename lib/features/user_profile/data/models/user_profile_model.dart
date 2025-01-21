import 'package:ebtik_tok/features/user_profile/domain/entities/user_profile_entity.dart';

class UserProfileModel{
  final String? name;
  final String? avatar;

  UserProfileModel({required this.name, required this.avatar});

  factory UserProfileModel.fromJson(Map<String, dynamic> json){
    return UserProfileModel(name: json['name'], avatar: json['avatar']);
  }
  UserProfileEntity toEntity(){
    return UserProfileEntity(name: name, avatar: avatar);
  }
}