import 'package:ebtik_tok/features/user_profile/domain/entities/user_profile_entity.dart';

abstract class UserProfileRepo{
  UserProfileEntity getUserProfile();
}