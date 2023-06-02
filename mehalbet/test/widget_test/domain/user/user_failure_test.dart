import 'package:flutter_test/flutter_test.dart';
import 'package:jobportal/domain/user/user_failure.dart';

void main() {
  group('UserFailure', () {
    test('DatabaseFailure has correct message', () {
      final databaseFailure = DatabaseFailure('Database error');
      expect(databaseFailure.message, 'Database error');
    });

    test('NetworkFailure has correct message', () {
      final networkFailure = NetworkFailure('Network error');
      expect(networkFailure.message, 'Network error');
    });

    test('UnAuthorizedAccessFailure has correct message', () {
      final unAuthorizedAccessFailure =
          UnAuthorizedAccessFailure('Unauthorized access');
      expect(unAuthorizedAccessFailure.message, 'Unauthorized access');
    });

    test('DatabaseFailure props are correct', () {
      final databaseFailure1 = DatabaseFailure('Database error');
      final databaseFailure2 = DatabaseFailure('Database error');
      final databaseFailure3 = DatabaseFailure('Another database error');
      expect(databaseFailure1.props, [databaseFailure1.message]);
      expect(databaseFailure1.props, databaseFailure2.props);
      expect(databaseFailure1.props, isNot(databaseFailure3.props));
    });

    test('NetworkFailure props are correct', () {
      final networkFailure1 = NetworkFailure('Network error');
      final networkFailure2 = NetworkFailure('Network error');
      final networkFailure3 = NetworkFailure('Another network error');
      expect(networkFailure1.props, [networkFailure1.message]);
      expect(networkFailure1.props, networkFailure2.props);
      expect(networkFailure1.props, isNot(networkFailure3.props));
    });

    test('UnAuthorizedAccessFailure props are correct', () {
      final unAuthorizedAccessFailure1 =
          UnAuthorizedAccessFailure('Unauthorized access');
      final unAuthorizedAccessFailure2 =
          UnAuthorizedAccessFailure('Unauthorized access');
      final unAuthorizedAccessFailure3 =
          UnAuthorizedAccessFailure('Another unauthorized access');
      expect(unAuthorizedAccessFailure1.props,
          [unAuthorizedAccessFailure1.message]);
      expect(
          unAuthorizedAccessFailure1.props, unAuthorizedAccessFailure2.props);
      expect(unAuthorizedAccessFailure1.props,
          isNot(unAuthorizedAccessFailure3.props));
    });
  });
}
