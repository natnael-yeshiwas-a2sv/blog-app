import "package:blog_application/core/usecases/usecase.dart";
import 'package:dartz/dartz.dart';
import "package:equatable/equatable.dart";
import "../../../../core/exceptions/Failure.dart";
import "../repositories/auth_repository.dart";

class RegisterUseCase extends UseCase<void, SendRegisterParam> {
  RegisterUseCase(this.repository);
  AuthRepository repository;

  @override
  Future<Either<Failure, void>> call(SendRegisterParam param) async {
    String bio =
        "madison blockstone is a director of user experience deisgn, with experience managing global teams";
    String fullname = "Jovi Daniel";
    return await repository.register(
        param.email, param.password, bio, fullname, "kjkdfjs");
  }
}

class SendRegisterParam extends Equatable {
  const SendRegisterParam(this.email, this.password);
  final String email;
  final String password;
  @override
  List<Object?> get props => throw UnimplementedError();
}
