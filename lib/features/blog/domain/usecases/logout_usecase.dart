

import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class Logout {
    final AuthRepository repository;

    Logout(this.repository);

  
  Future<void> call(NoParams  params) async{
    await repository.logout();
  }

}
