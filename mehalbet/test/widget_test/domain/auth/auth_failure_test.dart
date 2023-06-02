import 'package:flutter_test/flutter_test.dart';
import 'package:jobportal/domain/auth/auth_failure.dart';

void main() {
  group('AuthFailure', () {
    test('NetworkFailure has correct message', () {
      final networkFailure = NetworkFailure('Network error');
      expect(networkFailure.message, 'Network error');
    });

    test('InvalidCredentialsFailure has correct message', () {
      final invalidCredentialsFailure =
          InvalidCredentialsFailure('Invalid credentials');
      expect(invalidCredentialsFailure.message, 'Invalid credentials');
    });

    test('NetworkFailure props are correct', () {
      final networkFailure1 = NetworkFailure('Network error');
      final networkFailure2 = NetworkFailure('Network error');
      final networkFailure3 = NetworkFailure('Another network error');
      expect(networkFailure1.props, [networkFailure1.message]);
      expect(networkFailure1.props, networkFailure2.props);
      expect(networkFailure1.props, isNot(networkFailure3.props));
    });

    test('InvalidCredentialsFailure props are correct', () {
      final invalidCredentialsFailure1 =
          InvalidCredentialsFailure('Invalid credentials');
      final invalidCredentialsFailure2 =
          InvalidCredentialsFailure('Invalid credentials');
      final invalidCredentialsFailure3 =
          InvalidCredentialsFailure('Another invalid credentials');
      expect(invalidCredentialsFailure1.props,
          [invalidCredentialsFailure1.message]);
      expect(
          invalidCredentialsFailure1.props, invalidCredentialsFailure2.props);
      expect(invalidCredentialsFailure1.props,
          isNot(invalidCredentialsFailure3.props));
    });
  });
}
