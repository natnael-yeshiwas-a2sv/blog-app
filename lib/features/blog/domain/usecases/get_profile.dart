import 'package:blog_application/features/blog/domain/entities/user.dart';
import 'package:blog_application/features/blog/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/exceptions/Failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/article.dart';

class GetProfile extends UseCase<Tuple2<User, List<Article>>, NoParam> {
  final AuthRepository repository;

  GetProfile(this.repository);

  @override
  Future<Either<Failure, Tuple2<User, List<Article>>>> call(NoParam params) async {
    return await repository.getProfile();
  }
}

class NoParam extends Equatable{
  @override
  List<Object?> get props => [];
}