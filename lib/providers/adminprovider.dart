import 'package:ecomplaint/models/adminmodel.dart';
import 'package:flutter/cupertino.dart';

class AdminProvider extends ChangeNotifier {
  Admin _admin = Admin(id: '', username: '', password: '', token: '', type: '');

  Admin get admin => _admin;

  void setAdmin(String admin) {
    _admin = Admin.fromJson(admin);
    notifyListeners();
  }
}
