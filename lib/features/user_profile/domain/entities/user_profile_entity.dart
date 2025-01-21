import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable{
  final String? name;
  final String? avatar;

  const UserProfileEntity({required this.name, required this.avatar});
  @override
  List<Object?> get props => [name, avatar];
}