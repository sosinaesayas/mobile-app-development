import 'package:flutter_test/flutter_test.dart';

import 'package:jobportal/domain/notification/model/notification_failure.dart';

void main() {
  group('UserNotificationFailure', () {
    test('DatabaseFailure has correct message', () {
      final databaseFailure = DatabaseFailure('Database error');
      expect(databaseFailure.message, 'Database error');
    });

    test('UnknownFailure has correct message', () {
      final unknownFailure = UnknownFailure('Unknown error');
      expect(unknownFailure.message, 'Unknown error');
    });

    test('DatabaseFailure props are correct', () {
      final databaseFailure1 = DatabaseFailure('Database error');
      final databaseFailure2 = DatabaseFailure('Database error');
      final databaseFailure3 = DatabaseFailure('Another database error');
      expect(databaseFailure1.props, [databaseFailure1.message]);
      expect(databaseFailure1.props, databaseFailure2.props);
      expect(databaseFailure1.props, isNot(databaseFailure3.props));
    });

    test('UnknownFailure props are correct', () {
      final unknownFailure1 = UnknownFailure('Unknown error');
      final unknownFailure2 = UnknownFailure('Unknown error');
      final unknownFailure3 = UnknownFailure('Another unknown error');
      expect(unknownFailure1.props, [unknownFailure1.message]);
      expect(unknownFailure1.props, unknownFailure2.props);
      expect(unknownFailure1.props, isNot(unknownFailure3.props));
    });
  });
}
