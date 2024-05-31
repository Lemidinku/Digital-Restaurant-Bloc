import 'dart:ffi';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/application/auth/auth_bloc.dart'; // update this import based on your project structure
import 'package:restaurant/domain/user.dart';
import 'package:restaurant/Infrastructure/repositories/auth_repository.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthBloc authBloc;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authBloc = AuthBloc(authRepository: mockAuthRepository);
  });

  tearDown(() {
    authBloc.close();
  });

  final testUser =
      User(id: 1, username: 'testUser', phone: '1234567890', role: 'user');

  group('AuthBloc', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthAuthenticated] when AuthLogin is added and login is successful',
      build: () {
        when(mockAuthRepository.login(any, any))
            .thenAnswer((_) async => testUser);
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthLogin(username: 'testUser', password: 'password')),
      expect: () => [AuthAuthenticated(user: testUser)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthError] when AuthLogin is added and login fails',
      build: () {
        when(mockAuthRepository.login(any, any))
            .thenThrow(Exception('Failed to login'));
        return authBloc;
      },
      act: (bloc) =>
          bloc.add(AuthLogin(username: 'testUser', password: 'password')),
      expect: () => [AuthError(message: 'Exception: Failed to login')],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthUnauthenticated] when AuthLogout is added',
      build: () {
        when(mockAuthRepository.logout()).thenAnswer((_) async => Void);
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthLogout()),
      expect: () => [AuthUnauthenticated()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthAuthenticated] when AuthCheck is added and user is authenticated',
      build: () {
        when(mockAuthRepository.authCheck()).thenAnswer((_) async => testUser);
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthCheck()),
      expect: () => [AuthAuthenticated(user: testUser)],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthUnauthenticated] when AuthCheck is added and user is not authenticated',
      build: () {
        when(mockAuthRepository.authCheck()).thenAnswer((_) async => null);
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthCheck()),
      expect: () => [AuthUnauthenticated()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthRegistered] when AuthSignUp is added and signup is successful',
      build: () {
        when(mockAuthRepository.signup(any, any, any))
            .thenAnswer((_) async => true);
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUp(
          username: 'testUser', password: 'password', phone: '1234567890')),
      expect: () => [AuthRegistered()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthError] when AuthSignUp is added and signup fails',
      build: () {
        when(mockAuthRepository.signup(any, any, any))
            .thenThrow(Exception('Failed to register'));
        return authBloc;
      },
      act: (bloc) => bloc.add(AuthSignUp(
          username: 'testUser', password: 'password', phone: '1234567890')),
      expect: () => [AuthError(message: 'Exception: Failed to register')],
    );
  });
}
