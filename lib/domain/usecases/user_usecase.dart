import 'package:bankbank/data/model/user.dart';
import 'package:bankbank/data/repositories/user_repository.dart';
import 'package:bankbank/domain/entities/user.dart';
import 'package:bankbank/domain/entities/user_login.dart';
import 'package:bankbank/domain/entities/user_register.dart';

class UserUsecase {
  final UserRepository _userRepository;

  UserUsecase(this._userRepository);

  Future<UserModel> getUserById(int userId) async {
    return await _userRepository.getUserById(userId);
  }

  Future<UserModel> getUserByAccountNumber(String accountNumber) async {
    return await _userRepository.getUserByAccountNumber(accountNumber);
  }

  Future<UserModel> register(UserRegister user) async {
    return await _userRepository.register(user);
  }

  Future<UserModel?> login(String username, String password) async {
    final user = UserLogin(username: username, password: password);
    return await _userRepository.login(user);
  }

  Future<User?> getUser() async {
    return await _userRepository.getUserLogin();
  }
}