import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    void onTransition(Transition<AuthEvent, AuthState> transition) {
      super.onTransition(transition);
      print(transition);
    }

    on<AuthEvent>((event, emit) async {
      if (event is LoginRequested) {
        emit(LoginLoading());
        try {
          UserCredential user = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                email: event.email,
                password: event.password,
              );
          emit(LoginSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure(errorMessage: 'No user found for that email.'));
          } else if (e.code == 'wrong-password') {
            emit(
              LoginFailure(
                errorMessage: 'Wrong password provided for that user.',
              ),
            );
          }
        } on Exception catch (e) {
          emit(
            LoginFailure(
              errorMessage: 'An error occurred. Please try again later.',
            ),
          );
        }
      } else if (event is RegisterRequested) {
        emit(RegisterLoading());
      }
    });
  }
}
