import 'package:ebtik_tok/features/user_profile/domain/entities/user_profile_entity.dart';
import 'package:ebtik_tok/features/user_profile/domain/repositories/user_profile_repo.dart';

class GetUserProfileUseCase{
  final UserProfileRepo userProfileRepo;
  GetUserProfileUseCase({required this.userProfileRepo});

  UserProfileEntity call(){
    return userProfileRepo.getUserProfile();
  }
}