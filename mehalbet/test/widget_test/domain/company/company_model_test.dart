import 'package:flutter_test/flutter_test.dart';
import 'package:jobportal/domain/company/company_model.dart';


void main() {
  group('Company', () {
    test('toMap returns correct map', () {
      final company = Company(
        name: 'Acme Inc.',
        email: 'contact@acme.com',
        token: 'abc123',
        id: '123',
      );
      final map = company.toMap();
      expect(map, {
        'name': 'Acme Inc.',
        'email': 'contact@acme.com',
        'token': 'abc123',
        'id': '123',
      });
    });

    test('fromJson creates Company instance with correct values', () {
      final json = {
        'name': 'Acme Inc.',
        'email': 'contact@acme.com',
        'token': 'abc123',
        'id': '123',
      };
      final company = Company.fromJson(json);
      expect(company.name, 'Acme Inc.');
      expect(company.email, 'contact@acme.com');
      expect(company.token, 'abc123');
      expect(company.id, '123');
    });
  });
}
