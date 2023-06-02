import 'package:flutter_test/flutter_test.dart';

import 'package:jobportal/domain/notification/model/notifications.dart';

void main() {
  group('UserNotification JSON serialization', () {
    test('toJson returns correct map', () {
      final userNotification = UserNotification(
        message: 'New job offer',
        companyName: 'Acme Inc.',
        unread: true,
      );
      final map = userNotification.toJson();
      expect(map, {
        'message': 'New job offer',
        'companyName': 'Acme Inc.',
        'unread': true,
      });
    });

    test('fromJson creates UserNotification instance with correct values', () {
      final json = {
        'message': 'New job offer',
        'companyName': 'Acme Inc.',
        'unread': true,
      };
      final userNotification = UserNotification.fromJson(json);
      expect(userNotification.message, 'New job offer');
      expect(userNotification.companyName, 'Acme Inc.');
      expect(userNotification.unread, true);
    });
  });
}
