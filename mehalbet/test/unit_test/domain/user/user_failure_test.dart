import 'package:flutter_test/flutter_test.dart';
import 'package:jobportal/domain/user/user_failure.dart';

void main() {
  group('UserFailure', () {
    test('DatabaseFailure has correct props', () {
      final message = 'Database error';
      final failure = DatabaseFailure(message);

      expect(failure.props, [message]);
    });

    test('NetworkFailure has correct props', () {
      final message = 'Network error';
      final failure = NetworkFailure(message);

      expect(failure.props, [message]);
    });

    test('UnAuthorizedAccessFailure has correct props', () {
      final message = 'Unauthorized access';
      final failure = UnAuthorizedAccessFailure(message);

      expect(failure.props, [message]);
    });
  });
}
