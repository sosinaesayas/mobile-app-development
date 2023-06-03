import 'package:bloc/bloc.dart';
import 'package:jobportal/application/signup_bloc/signup_event.dart';
import 'package:jobportal/application/signup_bloc/signup_state.dart';
import 'package:jobportal/infrastructure/authentication/data_sources/api_datasource.dart';
import 'package:jobportal/infrastructure/user/data_sources/api_data_source.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState()) {
    on<SignupEvent>((event, emit) {});
    on<UserSignUpRequested>(_handleSignUpRequested);
    on<CompanySignUpRequested>(_handleCompanySignUpRequested);
  }

  Future<void> _handleSignUpRequested(
      UserSignUpRequested event, Emitter<SignupState> emit) async {
    UserApiDataSource api = UserApiDataSource();
    final res = await api.signupuser(event.userdata);

    res.fold((l) {
      emit(state.copyWith(usersignup: SignUpStatus.NetworkFailure));
    }, (r) => emit(state.copyWith(usersignup: SignUpStatus.signupSuccess)));
  }

  Future<void> _handleCompanySignUpRequested(
      CompanySignUpRequested event, Emitter<SignupState> emit) async {
        print("requested");
         print(state.companysignup);
    UserApiDataSource api = UserApiDataSource();
    emit(state.copyWith(companysignup: SignUpStatus.requested));
    print(state.companysignup);
    print("--");
    final res = await api.signupCompany(event.userdata);

    res.fold((l) {
      emit(state.copyWith(companysignup: SignUpStatus.NetworkFailure));
    }, (r){
      print(r);
        r == true ?  emit(state.copyWith(companysignup: SignUpStatus.signupSuccess)) :emit(state.copyWith(companysignup: SignUpStatus.NetworkFailure));
    } );
  }
}
