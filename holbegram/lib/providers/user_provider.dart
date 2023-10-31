import 'package:flutter/foundation.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/models/user.dart';

class UserProvider with ChangeNotifier {
  final AuthMethods _authMethod = AuthMethods();
  Users? _user;

  Users? get user => _user;

  Future<void> refreshUser() async {
    final user = await _authMethod.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
