

enum ProfileStatus{
  requestInProgress, 
  requestFailed, 
  requestSuccessed , 
  unknown , 
  loggingOut , 
  loggedIn , 
  loggedOut,
  authenticationFailed
}

class ProfileState {
    final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isEmailValid;
  final bool isPhoneNumberValid;
  final bool isFormValid;
  final Map<String, String> profileData;
  final bool isEditing;
  final ProfileStatus requestStatus;
  final ProfileStatus  loginStatus;
  final ProfileStatus profileUpdate;
  final ProfileStatus updatepassword;
 final ProfileStatus deleteAccont;

  ProfileState({
        this.firstName = "",
   this.lastName = "",
    this.email = "",
    this.phoneNumber = "",
     this.isFirstNameValid = true,
     this.isLastNameValid = true,
     this.isEmailValid = true,
    this.isPhoneNumberValid = true,
    this.isFormValid = true,
    this.profileData = const {},
     this.isEditing = false,
    this.requestStatus = ProfileStatus.unknown , 
    this.loginStatus = ProfileStatus.loggedIn, 
    this.profileUpdate = ProfileStatus.unknown,
    this.updatepassword = ProfileStatus.unknown, 
    this.deleteAccont =  ProfileStatus.unknown
    
  });

  

  ProfileState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    bool? isFirstNameValid,
    bool? isLastNameValid,
    bool? isEmailValid,
    bool? isPhoneNumberValid,
    bool? isFormValid,
    Map<String, String>? profileData,
    bool? isEditing,
    ProfileStatus? requestStatus,
    ProfileStatus? loginStatus,
    ProfileStatus? profileUpdate,
    ProfileStatus ? updatepassword,
     ProfileStatus ? deleteAccont
  }) {
    return ProfileState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPhoneNumberValid: isPhoneNumberValid ?? this.isPhoneNumberValid,
      isFormValid: isFormValid ?? this.isFormValid,
      profileData: profileData ?? this.profileData,
      isEditing: isEditing ?? this.isEditing,
      requestStatus: requestStatus ?? this.requestStatus,
      loginStatus: loginStatus ?? this.loginStatus, 
      profileUpdate: profileUpdate ?? this.profileUpdate,
      updatepassword : updatepassword ?? this.updatepassword,
      deleteAccont: deleteAccont ?? this.deleteAccont

    );
  }
}
