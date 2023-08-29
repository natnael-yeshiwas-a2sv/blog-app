import 'package:blog_application/core/exceptions/Failure.dart';
import 'package:blog_application/features/blog/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';

class IsLogedIn {
  final AuthRepository repository;
  IsLogedIn(this.repository);
  
  
  bool call()  {
    return  repository.isLoggedIn();
  }

}
