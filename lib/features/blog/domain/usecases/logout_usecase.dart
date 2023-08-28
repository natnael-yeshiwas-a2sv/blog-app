
import 'package:blog_application/core/exceptions/Failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class Logout {
    final AuthRepository repository;

    Logout(this.repository);

  
  Future<void> call(NoParams  params) async{
    await repository.logout();
  }

}
