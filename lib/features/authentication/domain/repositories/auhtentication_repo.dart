import 'package:dartz/dartz.dart';
import 'package:ebtik_tok/core/errors/failures.dart';

abstract class AuhtenticationRepo{
  Future<Either<Failure, Unit>> login({required String? phone, required String? password});
}