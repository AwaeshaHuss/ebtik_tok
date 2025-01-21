import 'package:ebtik_tok/features/user_profile/domain/use_cases/get_user_profile_use_case.dart';
import 'package:ebtik_tok/features/user_profile/domain/entities/user_profile_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  UserProfileBloc({required this.getUserProfileUseCase}) : super(UserProfileState()) {
    on<GetUserProfileEvent>(_getUserProfile);
  }
  static UserProfileBloc get(context) => BlocProvider.of(context);
  
  void _getUserProfile(GetUserProfileEvent event, Emitter<UserProfileState> emit){
    emit(state.copyWith(status: UserProfileStatus.loading));
    UserProfileEntity result = getUserProfileUseCase();
    emit(state.copyWith(status: UserProfileStatus.success, userProfileEntity: result));
  }
}
