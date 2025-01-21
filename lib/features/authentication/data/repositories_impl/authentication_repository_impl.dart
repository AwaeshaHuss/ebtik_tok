import 'package:dartz/dartz.dart';
import 'package:ebtik_tok/core/const.dart';
import 'package:ebtik_tok/core/errors/failures.dart';
import 'package:ebtik_tok/features/authentication/data/data_sources/authentication_data_source.dart';
import 'package:ebtik_tok/features/authentication/domain/repositories/auhtentication_repo.dart';

class AuthenticationRepositoryImpl implements AuhtenticationRepo{
  final AuthenticationDataSource authenticationDataSource;
  AuthenticationRepositoryImpl({required this.authenticationDataSource});
  
  @override
  Future<Either<Failure, Unit>> login({required String? phone, required String? password}) async{
    if (phone == mockUserPhone && password == mockUserPassword) {
      return Right(unit);
    } else {
      return Left(InvalidUserCredentialsFailure());
    }
  }
}