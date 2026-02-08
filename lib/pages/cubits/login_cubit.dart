import 'package:firebase_auth/firebase_auth.dart';
import 'package:folder/pages/cubits/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> LoginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(
          LoginFailure(errorMessage: 'Wrong password provided for that user.'),
        );
      }
    } on Exception catch (e) {
      emit(
        LoginFailure(
          errorMessage: 'An error occurred. Please try again later.',
        ),
      );
    }
  }
}
