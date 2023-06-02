import 'package:flutter_test/flutter_test.dart';
import 'package:jobportal/domain/auth/model.dart';

void main() {
  group('AuthModel', () {
    test('fromJson creates AuthModel instance with correct values', () {
      final json = {'email': 'test@example.com', 'password': 'password'};
      final authModel = AuthModel.fromJson(json);
      expect(authModel.email, 'test@example.com');
      expect(authModel.password, 'password');
    });

    test('toJson returns correct JSON map', () {
      final authModel =
          AuthModel(email: 'test@example.com', password: 'password');
      final json = authModel.toJson();
      expect(json['email'], 'test@example.com');
      expect(json['password'], 'password');
    });

    test('props are correct', () {
      final authModel1 =
          AuthModel(email: 'test@example.com', password: 'password');
      final authModel2 =
          AuthModel(email: 'test@example.com', password: 'password');
      final authModel3 =
          AuthModel(email: 'another@example.com', password: 'password');
      expect(authModel1.props, [authModel1.email, authModel1.password]);
      expect(authModel1.props, authModel2.props);
      expect(authModel1.props, isNot(authModel3.props));
    });
  });
}
