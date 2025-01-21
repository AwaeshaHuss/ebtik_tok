import 'package:dartz/dartz.dart';
import 'package:ebtik_tok/core/const.dart';
import 'package:ebtik_tok/core/errors/exceptions.dart';

abstract class AuthenticationDataSource{
  Unit login({required String? phone, required String? password});
}

class AuthenticationDataSourceImpl implements AuthenticationDataSource{
  @override
  Unit login({required String? phone, required String? password}) {
    if (phone == mockUserPhone && password == mockUserPassword) {
      return unit;
    } else {
      throw InvalidUserCredentialsException();
    }
  }
}