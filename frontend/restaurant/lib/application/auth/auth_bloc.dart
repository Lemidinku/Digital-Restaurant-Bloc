import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/user.dart';
import '../../Infrastructure/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  // stage 1
  // AuthBloc({required this.authRepository}) : super(0) {
  //   on<AuthLogin>((event, emit) => emit(state + 1));
  // }

  // stage 2
  // AuthBloc({required this.authRepository}) : super(AuthInitial()) {
  //   on<AuthLogin>((event, emit) => emit(AuthAuthenticated(
  // user: User(
  //     username: event.username,
  //     id: 1,
  //     role: "admin",
  //     token: "asdfsdf",
  //     phone: "1234567890"))));
  // }

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthLogin>((event, emit) async {
      //   emit(AuthAuthenticated(
      //       user: User(
      //           username: event.username,
      //           id: 1,
      //           role: "admin",
      //           token: "asdfsdf",
      //           phone: "1234567890")));
      // });
      try {
        final user = await authRepository.login(event.username, event.password);
        print(user);
        emit(AuthAuthenticated(user: user));
      } catch (e) {
        print("in the auth_bloc");
        print(e.toString());
        emit(AuthError(message: e.toString()));
      }
    });
  }
}
// abstract class CounterEvent {}

// class CounterIncrementPressed extends CounterEvent {}

// class CounterDecrementPressed extends CounterEvent {}

// class CounterBloc extends Bloc<CounterEvent, int> {
//   CounterBloc() : super(0) {
//     on<CounterIncrementPressed>((event, emit) => emit(state + 1));
//     on<CounterDecrementPressed>((event, emit) => emit(state - 1));
//   }
// }
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthRepository authRepository;

//   AuthBloc({required this.authRepository}) : super(AuthInitial()) {
//     on<AuthLogin>(_onLogin);
//   }

//   void _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
//     // emit(AuthLoading());
//     try {
//       final user = await authRepository.login(event.username, event.password);
//       emit(AuthAuthenticated(user: user));
//     } catch (e) {
//       emit(AuthError(message: e.toString()));
//     }
//   }
// }

// // class AuthBloc extends Bloc<AuthEvent, AuthState> {
// //   final AuthRepository authRepository;

// //   AuthBloc({required this.authRepository}) : super(AuthInitial());

// //   @override
// //   Stream<AuthState> mapEventToState(AuthEvent event) async* {
// //     if (event is AuthLogin) {
// //       // Handle AuthLogin event here
// //       final user = await authRepository.login(event.username, event.password);
// //       yield AuthLoggedInState(); // Emit a new state
// //     }
// //   }
// // }