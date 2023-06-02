import 'package:flutter_test/flutter_test.dart';
import 'package:jobportal/domain/auth/auth_failure.dart';

void main() {
  group('NetworkFailure', () {
    test('props should contain message', () {
      final failure = NetworkFailure('Failed to connect to server');
      expect(failure.props, [failure.message]);
    });
  });
}
