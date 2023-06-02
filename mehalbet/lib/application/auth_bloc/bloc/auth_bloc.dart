
import 'package:bloc/bloc.dart';
import 'package:jobportal/infrastructure/authentication/repository.dart';
import 'package:jobportal/application/auth_bloc/bloc/auth_event.dart';
import 'package:jobportal/application/auth_bloc/bloc/auth_state.dart';
import 'package:jobportal/domain/auth/auth_failure.dart';
import 'package:dartz/dartz.dart';
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<AuthEvent>((event, emit) {});
    on<AuthenticationRequestSent>(_handleAuthenticationRequest);
  }


  Future<void> _handleAuthenticationRequest(
    AuthenticationRequestSent event,
    Emitter<AuthState> emit,
  ) async {
    AuthRepository authRepository = AuthRepository();
    try {
      emit(state.copyWith(status: AuthStatus.authenticationPending));
      final Either<AuthFailure, Map<String, dynamic>> response =
          await authRepository.authenticateUser(event.authModel);

      response.fold(
        (failure) {
          if (failure is InvalidCredentialsFailure) {
            print("Invalid credentials!");
            print(failure.message);
            emit(state.copyWith(status: AuthStatus.authenticationFailed));
          } else if (failure is NetworkFailure) {
            print("Network error!");
            print(failure.message);
            emit(state.copyWith(status: AuthStatus.authenticationFailed));
          } else {
            print("Unknown failure occurred");
            emit(state.copyWith(status: AuthStatus.authenticationFailed));
          }
        },
        (userModel) {
          print("Authenticated!");
          print(userModel);
          if(userModel['entity'] == "freelancer"){
            emit(state.copyWith(status: AuthStatus.authenticationSuccess , entity: AuthStatus.freelancer));
          }else{
            print("it is company");
            emit(state.copyWith(status: AuthStatus.authenticationSuccess , entity: AuthStatus.company));
          }
        },
      );
    } catch (e) {
      print(e);
      print("Network error!");
      emit(state.copyWith(status: AuthStatus.unknown));
    }
  }
  }
