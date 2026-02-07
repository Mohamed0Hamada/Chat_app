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
    } on Exception catch (e) {
      emit(LoginFailure());
    }
  }
}
