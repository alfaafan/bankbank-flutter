import 'package:bankbank/data/model/user.dart';
import 'package:bankbank/data/repositories/user_repository.dart';
import 'package:bankbank/domain/entities/user.dart';
import 'package:bankbank/domain/entities/user_register.dart';
import 'package:bankbank/domain/usecases/user_usecase.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class UserProvider extends ChangeNotifier {
  final UserUsecase _userUsecase = UserUsecase(UserRepository());
  UserModel? _user;
  bool _isLoading = false;
  var userBox = Hive.box<User>('userBox');

  DateTime selectedDate = DateTime.now();

  UserModel? get user => _user;
  bool get isLoading => _isLoading;

  bool isLoggedIn() {
    return userBox.get('user') != null;
  }

  Future<void> fetchUser() async {
    _isLoading = true;
    notifyListeners();
    var userHive = userBox.get('user');
    try {
      final user = await _userUsecase.getUserById(userHive!.userId);
      print(user);
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
    notifyListeners();
  }

  void clear() {
    setUser(null);
    notifyListeners();
  }

  void refresh() {
    clear();
    fetchUser();
    notifyListeners();
  }

  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  Future<UserModel?> register(UserRegister user) async {
    _isLoading = true;
    notifyListeners();
    try {
      var createdUser = await _userUsecase.register(user);
      return createdUser;
    } catch (e) {
      print(e);
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


}