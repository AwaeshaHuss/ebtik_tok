import 'package:ebtik_tok/features/user_profile/data/data_sources/user_profile_data_source.dart';
import 'package:ebtik_tok/features/user_profile/data/models/user_profile_model.dart';
import 'package:ebtik_tok/features/user_profile/domain/entities/user_profile_entity.dart';
import 'package:ebtik_tok/features/user_profile/domain/repositories/user_profile_repo.dart';

class UserProfileRepositoryImpl implements UserProfileRepo{
  final UserProfileDataSource userProfileDataSource;
  UserProfileRepositoryImpl({required this.userProfileDataSource});

  @override
  UserProfileEntity getUserProfile() {
    UserProfileModel model = userProfileDataSource.getUserProfile();
    return model.toEntity();
  }
}