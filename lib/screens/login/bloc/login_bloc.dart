import 'package:cat_api_test_app/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(AuthRepository authRepository)
      : _authRepository = authRepository,
        super(InitialState()) {
    on<GoogleLoginEvent>((event, emit) => logInWithGoogle());
    on<FacebookLoginEvent>((event, emit) => logInWithFacebook());
  }
  final AuthRepository _authRepository;

  Future<void> logInWithGoogle() async {
    emit(LoginingState());
    try {
      await _authRepository.logInWithGoogle();
      emit(LogedState());
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> logInWithFacebook() async {
    emit(LoginingState());
    try {
      await _authRepository.logInWithFacebook();
      emit(LogedState());
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
