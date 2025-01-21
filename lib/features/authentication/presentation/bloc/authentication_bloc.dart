// import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:ebtik_tok/config/cache/cahce_helper.dart';
import 'package:ebtik_tok/core/const.dart';
import 'package:ebtik_tok/core/errors/failures.dart';
import 'package:ebtik_tok/core/utils.dart';
import 'package:ebtik_tok/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:equatable/equatable.dart';


part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase loginUseCase;
  
  AuthenticationBloc({required this.loginUseCase}) : super(AuthenticationState()) {
   on<LoginEvent>(_login);
   on<ToggelPasswordVisibilityEvent>(_toggelPasswordVisibility);
  }
  static AuthenticationBloc get(context) => BlocProvider.of(context);

  void _login(LoginEvent event, Emitter<AuthenticationState> emit) async{
    emit(state.copyWith(status: AuthenticationStatus.loading));
    await Future.delayed(Durations.extralong1);
    Either<Failure, Unit> result;
    result = await loginUseCase.call(phone: event.phone, password: event.password);
    result.fold((l){
      ShowToastSnackBar.displayToast(message: ' Error while login process');
      emit(state.copyWith(status: AuthenticationStatus.error));
    }, (r) async{
      ShowToastSnackBar.displayToast(message: ' login success');
      emit(state.copyWith(status: AuthenticationStatus.success));
      await CacheHelper.saveData(key: uTockenKey, value: event.phone!.substring(1,4) + event.password!.substring(1,4));
    });
  }

  void _toggelPasswordVisibility(ToggelPasswordVisibilityEvent event, Emitter<AuthenticationState> emit){
    emit(state.copyWith(passwordVisiable: !state.passwordVisiable));
  }
}
