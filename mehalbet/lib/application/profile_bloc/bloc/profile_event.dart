abstract class ProfileEvent {}

class ProfileEditRequested extends ProfileEvent {}

class ProfileSubmitRequested extends ProfileEvent {
  final Map<String, String> profileData;

  ProfileSubmitRequested({required this.profileData});
}

class ProfileRequested extends ProfileEvent{}


class ProfileResetRequested extends ProfileEvent {}

class ProfileInputChanged extends ProfileEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  ProfileInputChanged({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });
}



class LogoutRequested extends ProfileEvent{}

class UpdatePasswordRequested implements ProfileEvent{
   final Map<String, String> profileData;

  UpdatePasswordRequested({required this.profileData});
}

class PasswordInputChanged extends ProfileEvent{}