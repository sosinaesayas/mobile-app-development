import 'package:bloc/bloc.dart';
import 'package:jobportal/application/profile_bloc/bloc/profile_event.dart';
import 'package:jobportal/application/profile_bloc/bloc/profile_state.dart';
import 'package:jobportal/domain/auth/auth_failure.dart';
import 'package:jobportal/domain/user/user_model.dart';
import 'package:jobportal/infrastructure/authentication/data_sources/api_datasource.dart';
import 'package:jobportal/infrastructure/user/data_sources/api_data_source.dart';
class ProfileBloc extends Bloc<ProfileEvent ,  ProfileState> {
  ProfileBloc() : super(ProfileState()) {
    on<ProfileEvent>((event, emit) {});
    on<ProfileSubmitRequested>(_handleProfileSubmitRequested);
    on<ProfileResetRequested>(_handleProfileResetRequested);
    on<LogoutRequested>(_handleLogoutRequested);
    on<ProfileEditRequested>(_handleProfileEditRequested);
    on<ProfileRequested>(_handleProfileRequested);
    on<ProfileInputChanged>(_handleProfileInputChanged);

    on<UpdatePasswordRequested>(_handleUpdatePasswordRequested);

    
  }

  void _handleProfileEditRequested(ProfileEditRequested event, Emitter<ProfileState> emit) {
    print("Emmited --------------");
    
    emit(state.copyWith(isEditing: true));
  }

  void _handleProfileSubmitRequested(ProfileSubmitRequested event, Emitter<ProfileState> emit)async {

   
    emit(state.copyWith(profileData: event.profileData));
    if(state.isFormValid){
      UserApiDataSource api = UserApiDataSource();
      emit(state.copyWith(requestStatus: ProfileStatus.requestInProgress)); 
      final response = await api.updateProfile(model: event.profileData);

      response.fold((failue){
        emit(state.copyWith(
          requestStatus: ProfileStatus.requestFailed
        ));
      }, (model) => 
      
      emit(state.copyWith(requestStatus: ProfileStatus.requestSuccessed))
      );
    }
  }

  void _handleProfileResetRequested(ProfileResetRequested event, Emitter<ProfileState> emit) {
    emit(state.copyWith(isEditing: false));

    
  }

  void _handleLogoutRequested(LogoutRequested event , Emitter <ProfileState> emit)async{
    try {
      final ApiDataSource api  = ApiDataSource();
     
      emit(
        state.copyWith(loginStatus: ProfileStatus.loggingOut)
      );
      await api.logoutUser();
     emit(state.copyWith(loginStatus: ProfileStatus.loggedOut));
      
      
    } catch (e) {
      print(e);
    }
  }

   void _handleProfileRequested(ProfileRequested event, Emitter<ProfileState> emit) async{
    emit(state.copyWith(requestStatus: ProfileStatus.requestInProgress));

    try {
       UserApiDataSource api = UserApiDataSource();
       final result = await api.getUser();
    
       result.fold((failure){
     
          emit(state.copyWith(
            requestStatus: ProfileStatus.requestFailed
          )); 
       }, (user){
         


             emit(state.copyWith(
            profileData: user.toMap() , 
            requestStatus: ProfileStatus.requestSuccessed
          ));
       });
    } catch (e) {
      print(e);
    }

  }




   _handleProfileInputChanged(ProfileInputChanged event , Emitter<ProfileState> emit) async{
    final firstName = event.firstName;
    final lastName = event.lastName;
    final email = event.email;
    final phoneNumber = event.phoneNumber;

    final isFirstNameValid = firstName.isNotEmpty;
    final isLastNameValid = lastName.isNotEmpty;
    final isEmailValid = _validateEmail(email);
    final isPhoneNumberValid = phoneNumber.isNotEmpty;
   

    final isFormValid = isFirstNameValid && isLastNameValid && isEmailValid && isPhoneNumberValid;

        emit( state.copyWith(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phoneNumber: phoneNumber,
      isFirstNameValid: isFirstNameValid,
      isLastNameValid: isLastNameValid,
      isEmailValid: isEmailValid,
      isPhoneNumberValid: isPhoneNumberValid,
      isFormValid: isFormValid,
    ));

   
  }




  bool _validateEmail(email){
     final pattern = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
  final regex = RegExp(pattern);
  return regex.hasMatch(email);
  }
  _handleUpdatePasswordRequested(UpdatePasswordRequested event , Emitter<ProfileState> emit)async{
      ApiDataSource api = ApiDataSource();
      final result = await api.updatePassword(event.profileData);
      result.fold((l){
        if(l == NetworkFailure){
          emit(state.copyWith(updatepassword: ProfileStatus.requestFailed));
        
        }
      }, (r){

        if(r == false){
          emit(state.copyWith(updatepassword: ProfileStatus.authenticationFailed));
        }
       else{
         return emit(state.copyWith(updatepassword: ProfileStatus.requestSuccessed));
       }
      });
  }
}
