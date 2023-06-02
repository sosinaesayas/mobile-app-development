

import 'package:flutter_test/flutter_test.dart';
import 'package:jobportal/domain/company/company_model.dart';

void main() {
  group('Company', () {
    test('toMap should return a valid map', () {
      final company = Company(
        name: 'Test Company',
        email: 'test@example.com',
        token: 'abc123',
        id: '1234'
      );
      final map = company.toMap();
      expect(map['name'], 'Test Company');
      expect(map['email'], 'test@example.com');
      expect(map['token'], 'abc123');
      expect(map['id'], '1234');
    });

    test('fromJson should return a valid Company object', () {
      final json = {
        'name': 'Test Company',
        'email': 'test@example.com',
        'token': 'abc123',
        'id': '1234'
      };
      final company = Company.fromJson(json);
      expect(company.name, 'Test Company');
      expect(company.email, 'test@example.com');
      expect(company.token, 'abc123');
      expect(company.id, '1234');
    });
  });
}