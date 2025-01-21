part of 'user_profile_bloc.dart';

enum UserProfileStatus { initial, loading, error, success }

extension UserProfileStatusX on UserProfileStatus {
  bool get isInitial => this == UserProfileStatus.initial;
  bool get isLoading => this == UserProfileStatus.loading;
  bool get isError => this == UserProfileStatus.error;
  bool get isSuccess => this == UserProfileStatus.success;
}

class UserProfileState extends Equatable {
  final UserProfileStatus status;
  final UserProfileEntity? userProfileEntity;
  const UserProfileState(
      {this.status = UserProfileStatus.initial, this.userProfileEntity});
  UserProfileState copyWith(
          {UserProfileStatus? status, UserProfileEntity? userProfileEntity}) =>
      UserProfileState(
          status: status ?? this.status,
          userProfileEntity: this.userProfileEntity ?? userProfileEntity);

  @override
  List<Object?> get props => [status, userProfileEntity];
}
