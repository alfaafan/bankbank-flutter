import 'package:bankbank/data/repositories/user_repository.dart';
import 'package:bankbank/domain/entities/user.dart';
import 'package:bankbank/domain/entities/user_login.dart';

class UserUsecase {
  final UserRepository _userRepository;

  UserUsecase(this._userRepository);

  Future<User> getUserById(int userId) async {
    return await _userRepository.getUserById(userId);
  }

  Future<User> register(String username, String password) async {
    return await _userRepository.register(username, password);
  }

  Future<User?> login(String username, String password) async {
    final user = UserLogin(username: username, password: password);
    return await _userRepository.login(user);
  }
}