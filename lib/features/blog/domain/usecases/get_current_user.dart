import 'package:blog_application/features/blog/domain/repositories/auth_repository.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';

class GetCurrentUser {
  final AuthRepository repository;
  const GetCurrentUser(this.repository);
  
  Future<User>  call (NoParams param) async{
    return await repository.getCurrentUser();
  }
}
