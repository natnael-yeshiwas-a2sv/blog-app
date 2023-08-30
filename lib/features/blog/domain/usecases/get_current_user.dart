import 'package:blog_application/core/exceptions/Failure.dart';
import 'package:blog_application/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  @override
  Future< User> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}