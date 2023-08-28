import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/logout_usecase.dart';
import '../../../domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this.loginUseCase,
    this.registerUseCase,
    this.logout,
  ) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<AuthLogin>(_onAuthLogin);
    on<AuthRegister>(_onAuthRegister);
    on<AuthLogout>(_onAuthLogout);
  }

  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final Logout logout;

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result =
        await loginUseCase(SendLoginParam(event.email, event.password));
    result.fold((l) => emit(AuthFailed(l.message)), (r) => emit(AuthPass()));
  }

  void _onAuthRegister(AuthRegister event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result =
        await registerUseCase(SendRegisterParam(event.email, event.password));
    if (result.isRight()) {
      print("Working .....");
    } else{
      print("Error .....");
    }
    result.fold((l) => emit(AuthFailed(l.message)), (r) => emit(AuthPass()));
  }
  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await logout(NoParams());
    await Future.delayed(const Duration(seconds: 2));
    emit(AuthPass());
  }
}
