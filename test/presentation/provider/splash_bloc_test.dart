import 'package:delivery_app/theming_and_state_management/domain/model/user.dart';
import 'package:delivery_app/theming_and_state_management/presentation/provider/splash_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/api_repository_mock.dart';
import '../../mocks/local_repository_mock.dart';

void main() {
  final apiMock = ApiRepositoryMock();
  final localMock = LocalRepositoryMock();
  final bloc = SplashBloc(
    localRepositoryInterface: localMock,
    apiRepositoryInterface: apiMock,
  ); // Test with no token (using solution 1)
  test("validate session is invalid (no token)", () async {
    when(localMock.getToken()).thenAnswer((_) => Future.value(null));
    final result = await bloc.validateSession();
    expect(result, isFalse);
  });
    // Test with a mocked token (using solution 2)
  test("validate session is valid", () async {
    const mockedToken = "some_mocked_token";
    when(localMock.getToken()).thenAnswer((_) => Future.value(mockedToken));
    when(apiMock.getUserFromToken(mockedToken))
      .thenAnswer((_) => Future.value(const User(name: '', username: ''))); // Return a user object
    final result = await bloc.validateSession();
    expect(result, isTrue);
  });

}
