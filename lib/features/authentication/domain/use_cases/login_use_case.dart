import 'package:dartz/dartz.dart';
import 'package:ebtik_tok/core/errors/failures.dart';
import 'package:ebtik_tok/features/authentication/domain/repositories/auhtentication_repo.dart';

class LoginUseCase{
  AuhtenticationRepo auhtenticationRepo;

  LoginUseCase({required this.auhtenticationRepo});

  Future<Either<Failure, Unit>> call({required String? phone, required String? password}) async{
    return await auhtenticationRepo.login(phone: phone, password: password);
  }
}