import 'package:ebtik_tok/core/const.dart';
import 'package:ebtik_tok/features/user_profile/data/models/user_profile_model.dart';

abstract class UserProfileDataSource{
  UserProfileModel getUserProfile();
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  @override
  UserProfileModel getUserProfile() {
    return UserProfileModel(name: 'Hussein Al-Awaisheh', avatar: personIconPath);
  }

}