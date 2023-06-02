import 'package:flutter_test/flutter_test.dart';
import 'package:jobportal/domain/auth/model.dart';

void main() {
  group('AuthModel', () {
    test('fromJson should return a valid AuthModel object', () {
      final json = {'email': 'test@example.com', 'password': 'password'};
      final authModel = AuthModel.fromJson(json);
      expect(authModel.email, 'test@example.com');
      expect(authModel.password, 'password');
    });

    test('toJson should return a valid JSON object', () {
      final authModel =
          AuthModel(email: 'test@example.com', password: 'password');
      final json = authModel.toJson();
      expect(json['email'], 'test@example.com');
      expect(json['password'], 'password');
    });

    test('props should contain email and password', () {
      final authModel =
          AuthModel(email: 'test@example.com', password: 'password');
      expect(authModel.props, [authModel.email, authModel.password]);
    });
  });
}
