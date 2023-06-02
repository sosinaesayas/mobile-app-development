import 'package:flutter_test/flutter_test.dart';
import 'package:jobportal/domain/notification/model/notification_failure.dart';

void main() {
  group('UserNotificationFailure', () {
    test('NetworkFailure should have correct props', () {
      final failure = NetworkFailure('Failed to connect to network');
      expect(failure.props.length, 1);
      expect(failure.props[0], 'Failed to connect to network');
    });

    test('InvalidCredentialsFailure should have correct props', () {
      final failure = InvalidCredentialsFailure('Invalid username or password');
      expect(failure.props.length, 1);
      expect(failure.props[0], 'Invalid username or password');
    });

    test('DatabaseFailure should have correct props', () {
      final failure = DatabaseFailure('Failed to connect to database');
      expect(failure.props.length, 1);
      expect(failure.props[0], 'Failed to connect to database');
    });

    test('UnknownFailure should have correct props', () {
      final failure = UnknownFailure('Unknown error occurred');
      expect(failure.props.length, 1);
      expect(failure.props[0], 'Unknown error occurred');
    });
  });
}
