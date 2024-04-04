import 'package:bankbank/data/model/user.dart';
import 'package:bankbank/data/repositories/user_repository.dart';
import 'package:bankbank/domain/entities/user.dart';
import 'package:bankbank/domain/usecases/user_usecase.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserProvider extends ChangeNotifier {
  final UserUsecase _userUsecase = UserUsecase(UserRepository());
  UserModel? _user;
  bool _isLoading = false;
  var userBox = Hive.box<User>('userBox');

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  bool isLoggedIn() {
    return userBox.get('user') != null;
  }

  Future<void> fetchUser() async {
    _isLoading = true;
    notifyListeners();
    try {
      final user = await _userUsecase.getUserById(userBox.get('user')!.userId);
      setUser(user);
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setUser(UserModel? user) {
    _user = user;
    notifyListeners();
  }

  void login(String username, String password) async {
    var user = await _userUsecase.login(username, password);
    setUser(user);
  }


}