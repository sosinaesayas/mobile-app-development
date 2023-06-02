import 'package:flutter_test/flutter_test.dart';
import 'package:jobportal/application/auth_bloc/bloc/auth_event.dart';

import 'package:jobportal/domain/auth/model.dart';

void main() {
  group('AuthEvent Tests', () {
    test('AuthenticationRequestSent should contain authModel', () {
      final authModel =
          AuthModel(email: 'test@example.com', password: 'password');
      final authenticationRequestSent =
          AuthenticationRequestSent(authModel: authModel);
      expect(authenticationRequestSent.authModel, equals(authModel));
    });

    test('AuthenticationFailed should not contain any data', () {
      final authenticationFailed = AuthenticationFailed();
      expect(authenticationFailed, isA<AuthEvent>());
    });

    test('AuthenticationSuccess should not contain any data', () {
      final authenticationSuccess = AuthenticationSuccess();
      expect(authenticationSuccess, isA<AuthEvent>());
    });

    test('UnauthenticateUser should not contain any data', () {
      final unauthenticateUser = UnauthenticateUser();
      expect(unauthenticateUser, isA<AuthEvent>());
    });
  });
}
