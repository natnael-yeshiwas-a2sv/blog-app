import "package:blog_application/core/usecases/usecase.dart";
import 'package:dartz/dartz.dart';
import "package:equatable/equatable.dart";
import "../../../../core/exceptions/Failure.dart";
import "../repositories/auth_repository.dart";

class LoginUseCase extends UseCase<void,SendLoginParam> {
  LoginUseCase(this.repository);
  AuthRepository repository;

  @override
  Future<Either<Failure,void>> call(SendLoginParam param) async {
    return await repository.login(param.email,param.password);
  }
}

class SendLoginParam extends Equatable{

  const SendLoginParam(this.email,this.password);
  final String email;
  final String password;
  @override
  List<Object?> get props => throw UnimplementedError();

}