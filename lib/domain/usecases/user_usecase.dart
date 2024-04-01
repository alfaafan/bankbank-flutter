import 'package:bankbank/data/model/user.dart';
import 'package:bankbank/data/repositories/user_repository.dart';
import 'package:bankbank/domain/entities/user.dart';
import 'package:bankbank/domain/entities/user_login.dart';

class UserUsecase {
  final UserRepository _userRepository;

  UserUsecase(this._userRepository);

  Future<UserModel> getUserById(int userId) async {
    return await _userRepository.getUserById(userId);
  }

  Future<UserModel> register(String username, String password) async {
    return await _userRepository.register(username, password);
  }

  Future<UserModel?> login(String username, String password) async {
    final user = UserLogin(username: username, password: password);
    return await _userRepository.login(user);
  }

  Future<User?> getUser() async {
    return await _userRepository.getUserLogin();
  }
}