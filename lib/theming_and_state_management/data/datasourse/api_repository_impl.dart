import 'package:delivery_app/theming_and_state_management/data/in_memory_products.dart';
import 'package:delivery_app/theming_and_state_management/domain/exception/auth_exception.dart';
import 'package:delivery_app/theming_and_state_management/domain/model/product.dart';
import 'package:delivery_app/theming_and_state_management/domain/model/user.dart';
import 'package:delivery_app/theming_and_state_management/domain/repository/api_repository.dart';
import 'package:delivery_app/theming_and_state_management/domain/response/login_response.dart';
import 'package:delivery_app/theming_and_state_management/domain/request/login_request.dart';

// aqui voy a implementar como lo voy a hacer.
class ApiRepositoryImpl extends ApiRepositoryInterface {
  @override
  Future<User> getUserFromToken(String token) async {
    await Future.delayed(const Duration(seconds: 3));
    if (token == 'AA111') {
      return const User(
        name: 'Jordan Jobs',
        username: 'jordanjobs',
        image: 'assets/users/abogado.jpg',
      );
    } else if (token == 'AA222') {
      return const User(
        name: 'Elona Musk',
        username: 'elonamusk',
        image: 'assets/users/mothers-daughters-look-alike-3.jpg',
      );
    }
    throw AuthException();
  }

  @override
  Future<LoginResponse> login(LoginRequest login) async {
    await Future.delayed(const Duration(seconds: 3));
    if (login.username == 'jordanjobs' && login.password == 'jobs') {
      return const LoginResponse(
          'AA111',
          User(
            name: 'Jordan Jobs',
            username: 'jordanjobs',
            image: 'assets/users/abogado.jpg',
          ));
    }
    if (login.username == 'elonamusk' && login.password == 'musk') {
      return const LoginResponse(
          'AA222',
          User(
            name: 'Elona Musk',
            username: 'elonamusk',
            image: 'assets/users/mothers-daughters-look-alike-3.jpg',
          ));
    }
    throw AuthException();
  }

  @override
  Future<void> logout(String token) async {
    print('Removing token from server');
    return;
  }

  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(seconds: 1));
    return products;
  }
}
